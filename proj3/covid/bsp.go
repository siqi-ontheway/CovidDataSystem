package main

import (
	"fmt"
	"sync/atomic"
)

func ExecuteBSP(idx int, ctx *SharedContext) {
	for {
		if int(ctx.taskNum)+idx+1 <= numOfFiles {
			file := fmt.Sprintf("data/covid_%v.csv", int(ctx.taskNum)+idx+1)
			readFile(file, &ctx.zipRecords[idx], ctx.zipcode, ctx.month, ctx.year, &ctx.flag)
		}

		ctx.cond.L.Lock()
		ctx.counter++
		if atomic.LoadInt32(&ctx.counter) == int32(ctx.threads) {
			ctx.taskNum += int32(ctx.threads)
			if ctx.taskNum >= int32(numOfFiles) {
				ctx.cond.Broadcast()
				ctx.cond.L.Unlock()
				return

			}
			ctx.cond.Broadcast()
			ctx.counter = 0
		} else {
			ctx.cond.Wait()
			if ctx.taskNum >= int32(numOfFiles) {
				ctx.cond.Broadcast()
				ctx.cond.L.Unlock()
				return
			}
		}
		ctx.cond.L.Unlock()
	}
}

func RunBSP(ctx *SharedContext) {
	threads := ctx.threads
	for idx := 0; idx < threads-1; idx++ {
		ctx.zipRecords[idx] = make(map[string]ZipcodeInfo)
		go ExecuteBSP(idx, ctx)
	}
	ctx.zipRecords[threads-1] = make(map[string]ZipcodeInfo)
	ExecuteBSP(threads-1, ctx)
}
