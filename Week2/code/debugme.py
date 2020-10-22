#!/usr/bin/env python3

"""excercise file for debugging"""

"""Creating a bug for debug test"""
def makeabug(x):
    y = x
    for i in range(x):
        try:
            y = y - 1
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This doesn't work; x = {x}, y = {y}")
        else:
            print(f"ok; x={x}, y={y}, z={z};")
    return z
makeabug(20)
