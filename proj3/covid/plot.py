import matplotlib.pyplot as plt

file = open("time", "r")


# Serial runs
serial_small = 0
serial_medium = 0
serial_big = 0

for _ in range(5):
    serial_small += float(file.readline())
# use the mean time of 5 runs
serial_small = serial_small/5.0

for _ in range(5):
    serial_medium += float(file.readline())
# use the mean time of 5 runs
serial_medium = serial_medium/5.0

for _ in range(5):
    serial_big += float(file.readline())
# use the mean time of 5 runs
serial_big = serial_big/5.0


# Parallel runs
bsp = [[0, 0, 0, 0, 0] for _ in range(3)]

for j in range(5):
    y = 0
    for _ in range(5):
        y += float(file.readline())
    y = y/5.0
    bsp[0][j] = serial_small/y

for j in range(5):
    y = 0
    for _ in range(5):
        y += float(file.readline())
    y = y/5.0
    bsp[1][j] = serial_medium/y

for j in range(5):
    y = 0
    for _ in range(5):
        y += float(file.readline())
    y = y/5.0
    bsp[2][j] = serial_big/y


fig = plt.figure()
ax = plt.axes()
x = [2, 4, 6, 8, 12]
plt.plot(x, bsp[0], label="small")
plt.plot(x, bsp[1], label="medium")
plt.plot(x, bsp[2], label="big")
plt.xlabel('Number of Threads')
plt.ylabel('Speedup')
plt.title("Editor Speedup Graph (BSP)")
plt.legend(loc="best")
# plt.show()
plt.savefig('speedup-bsp.png')


file.close()
