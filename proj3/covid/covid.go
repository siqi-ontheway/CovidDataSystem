package main

import (
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"time"
)

const (
	zipcodeCol = 0
	weekStart  = 2
	casesWeek  = 4
	testsWeek  = 8
	deathsWeek = 14

	usage = "Usage: covid threads zipcode month year\n" +
		"    threads = the number of threads (i.e., goroutines to spawn)\n" +
		"    zipcode = a possible Chicago zipcode\n" +
		"    month = the month to display for that zipcode \n" +
		"    year  = the year to display for that zipcode \n"
)

var numOfFiles = 500

type ZipcodeInfo struct {
	cases  int
	tests  int
	deaths int
}

type SharedContext struct {
	cond       *sync.Cond
	records    map[string]bool
	zipcode    int
	month      int
	year       string
	counter    int32
	taskNum    int32
	zipRecords []map[string]ZipcodeInfo
	threads    int
	flag       int32
}

func main() {
	if len(os.Args) < 4 {
		fmt.Printf(usage)
		return
	}

	threads, _ := strconv.Atoi(os.Args[1])
	zipcode, _ := strconv.Atoi(os.Args[2])
	month, _ := strconv.Atoi(os.Args[3])
	year := os.Args[4]
	size := "big"
	if len(os.Args) != 5 {
		size = os.Args[5]
	}
	if size == "small" {
		numOfFiles = 100
	}
	if size == "medium" {
		numOfFiles = 250
	}
	f, err := os.OpenFile("./time", os.O_APPEND|os.O_WRONLY, 0666)

	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	start := time.Now()

	if threads == 0 || threads == 1 {
		sequential(zipcode, month, year)
		_, err1 := io.WriteString(f, fmt.Sprintf("%f", time.Since(start).Seconds())+"\n")

	if err1 != nil {
		log.Fatal(err1)
	}
		return
	}

	var mutex sync.Mutex
	condVar := sync.NewCond(&mutex)
	context := SharedContext{condVar, make(map[string]bool), zipcode, month, year, 0, 0, make([]map[string]ZipcodeInfo, threads), threads, 0}
	
	RunBSP(&context)

	totalCases, totalTests, totalDeaths := 0, 0, 0
	for i := 0; i < threads; i++ {
		for key, value := range context.zipRecords[i] {
			if _, prs := context.records[key]; !prs {
				totalCases += value.cases
				totalDeaths += value.deaths
				totalTests += value.tests
				context.records[key] = true
			}
		}
	}
	_, err1 := io.WriteString(f, fmt.Sprintf("%f", time.Since(start).Seconds())+"\n")

	if err1 != nil {
		log.Fatal(err1)
	}

	fmt.Printf("%v,%v,%v\n", totalCases, totalTests, totalDeaths)

}

func sequential(zipcode, month int, year string) {
	records := make(map[string]ZipcodeInfo)
	var totalCases, totalTests, totalDeaths int
	for idx := 1; idx < numOfFiles; idx++ {
		file := fmt.Sprintf("data/covid_%v.csv", idx+1)
		readFile(file, &records, zipcode, month, year, nil)
	}
	for _, value := range records {
		totalCases += value.cases
		totalTests += value.tests
		totalDeaths += value.deaths
	}

	fmt.Printf("%v,%v,%v\n", totalCases, totalTests, totalDeaths)

}

func readFile(filepath string, records *map[string]ZipcodeInfo, kZipcode, kMonth int, year string, flag *int32) {
	file, _ := os.Open(filepath)
	defer file.Close()
	r := csv.NewReader(file)
	var idx int
	var err error
	var zipcode, month, cases, tests, deaths int
	for {
		record, errRead := r.Read()
		idx++
		if idx == 1 {
			continue
		}
		if errRead == io.EOF {
			break
		}
		if errRead != nil {
			fmt.Printf("file : %s, Problem : %v\n", filepath, errRead)
			return
		}
		key := strings.Join(record, ",")
		if _, prs := (*records)[key]; !prs {
			if zipcode, err = strconv.Atoi(record[zipcodeCol]); err != nil || zipcode != kZipcode {
				continue
			}
			startStrs := strings.Split(record[weekStart], "/")
			if len(startStrs) != 3 {
				continue
			}
			month, _ = strconv.Atoi(startStrs[0])
			if month != kMonth {
				continue
			}
			if startStrs[2] != year {
				continue
			}
			if cases, err = strconv.Atoi(record[casesWeek]); err != nil {
				continue
			}
			if tests, err = strconv.Atoi(record[testsWeek]); err != nil {
				continue
			}
			if deaths, err = strconv.Atoi(record[deathsWeek]); err != nil {
				continue
			}
			if flag == nil {
				(*records)[key] = ZipcodeInfo{cases, tests, deaths}
			} else {
				for !atomic.CompareAndSwapInt32(flag, 0, 1) {
				}
				(*records)[key] = ZipcodeInfo{cases, tests, deaths}
				atomic.StoreInt32(flag, 0)
			}

		}
	}

}
