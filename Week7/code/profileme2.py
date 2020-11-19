'''Converted the loop to a list comprehension,
replaced .join with an explicit string concatenation '''

def my_squares(iters): 
    """Calculating a square"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """Joining strings"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x, y): 
    """Running all functions"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")