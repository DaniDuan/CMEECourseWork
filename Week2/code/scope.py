#!/usr/bin/env python3
"""blocks of code illustrating variable scope."""


_a_global = 10
if _a_global >= 5:
    _b_global = _a_global

"""creating a_function"""
def a_function():
    _a_global = 5

    if _a_global >= 5:
        _b_global = _a_global
    
    _a_local = 4

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

    return None

a_function()

print("Outside the function, the value of _a_global is", _a_global)
print("Outside the function, the value of _b_global is", _b_global)


_a_global = 10
"""creating a_function"""
def a_function():
    _a_local = 4

    print("Inside the function, the value of _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
    return None

a_function()

print("Outside the function, the value of _a_global is", _a_global)


_a_global = 10

print("Outside the function, the value of _a_global is", _a_global)

"""creating a_function"""

def a_function():
    global _a_global
    _a_global = 5
    _a_local = 4

    print("Inside the function, the value of _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)

    return None

a_function()

print("Outside the function, the value of _a_global now is", _a_global)

"""creating a_function"""

def a_function():
    _a_global = 10

"""subfunction for defining global"""
def _a_function2():
    global _a_global
    _a_global = 20

    print("Before calling a_function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling _a_function2, the value of _a_global is", _a_global)

    return None

a_function()

print("The value of _a_global in main workspace is", _a_global)


_a_global = 10

"""creating a_function"""

def a_function():

    """Creating a subfunction"""

    def _a_function2():
        global a_global
        _a_global = 20

    print("Before calling a_function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace is", _a_global)