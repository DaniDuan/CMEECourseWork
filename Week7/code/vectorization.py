"""Showing the difference in runtime between a loop method and a vectorized method using numpy."""

import scipy as sc
import matplotlib.pylab as p


def loop_product(a, b):
    """a loop-based function to calculate the entrywise product of two 1D arrays"""
    N = len(a)
    c = sc.zeros(N)
    for i in range(N):
        c[i] = a[i] * b[i]
    return c

def vect_product(a, b):
    """a vectorized function to calculate the entrywise product of two 1D arrays"""
    return sc.multiply(a, b)


import timeit
array_lengths = [1, 100, 10000, 1000000, 10000000]
t_loop = []
t_vect = []

for N in array_lengths:
    print("\nSet N=%d" %N)
    #randomly generating 1D arrays of length N
    a = sc.random.rand(N)
    b = sc.random.rand(N)

    #time loop_product 3 times and save the mean execution time
    timer = timeit.repeat('loop_product(a,b)', globals=globals().copy(), number = 3)
    t_loop.append(1000 * sc.mean(timer))
    print("Loop method took %d ms on average." %t_loop[-1])

    #time vect_product 3 times and save the mean execution time
    timer = timeit.repeat('vect_product(a,b)', globals = globals().copy(), number= 3)
    t_vect.append(1000 * sc.mean(timer))
    print("vectorized method took %d ms on average." %t_vect[-1])


p.figure()
p.plot(array_lengths, t_loop, label = "loop method")
p.plot(array_lengths, t_vect, label = "vect method")
p.xlabel("Array length")
p.ylabel("Execution time(ms)")
p.legend()
p.show()


#When to vectorize? 
#Try following scripts
#Overloading, automatically kills

# N = 1000000000

# a = sc.random.rand(N)
# b = sc.random.rand(N)
# c = vect_product(a, b)

# del a
# del b
# del c

