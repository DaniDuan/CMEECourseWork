#!/usr/bin/env python3

## imports ##
import sys

# constants ##

# Square root x
def foo_1(x = 2):
    y = x ** 0.5
    return "The square root of %d is %d" % (x, y)

# print out the higher number
def foo_2(x = 1,y = 2):
    if x > y:
        return "The higher number is %d" % x
    return "The higher number is %d" % y

# rank the numbers from small to large
def foo_3(x = 3, y = 2,z = 1): 
    if x > y: 
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return "Ranking the three numbers from low to high: [%d, %d ,%d]" % (x, y, z)

# the factorial of x
def foo_4(x = 5): 
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return "the factorial of %d is %d " % (x, result)

# a recursive function that calculates the factorial of x
def foo_5(x = 5):
    if x == 1:
        return 1
    result = x * foo_5(x - 1)
    return result

# Calculate the factorial of x in a different way
def foo_6(x = 5):
    facto = 1
    y = x
    while x >= 1:
        facto = facto * x
        x = x - 1
    return "the factorial of %d is %d " % (y, facto)

## functions ##

def main(argv):
    print(foo_1(2))
    print(foo_2(3, 5))
    print(foo_3(2, 5, 1))
    print(foo_4(5))

    foo5_in = 5
    foo5_out = foo_5(foo5_in)
    print("the factorial of %d is %d " % (foo5_in, foo5_out))

    print(foo_6(5))

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)


