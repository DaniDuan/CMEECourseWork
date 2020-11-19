"""Numerical computing in Python"""

import scipy as sc
import numpy as np

#Using numpy
a = np.array(range(5))
a
print(type(a))
print(type(a[0]))

a = np.array(range(5), float)
a 
a.dtype

x = np.arange(5)
x = np.arange(5.)
x
x.shape

b = np.array([i for i in range(10) if i % 2 == 1])
b

c = b.tolist()
c

mat = np.array([[0,1],[2,3]])
mat
mat.shape

#Using scipy
a = sc.array(range(5))
a
print(type(a))
print(type(a[0]))
a = sc.array(range(5),float)
a.dtype
x = sc.arange(5)
x
x = sc.arange(5.)
x
x.shape
b = sc.array([i for i in range(10) if i % 2 == 1])
b
c = b.tolist()
c
mat = sc.array([[0,1],[2,3]])
mat
mat.shape

mat[1]
mat[:,1]
mat[0,0]
mat[1,0]
mat[0,1]
mat[0,-1]
mat[-1,0]
mat[0,-2]

mat[0,0] = -1
mat[:,0] = [12,12]
sc.append(mat, [[12,12]], axis = 0) #appending row
sc.append(mat, [[12],[12]], axis = 1) #appending column

newRow = [[12,12]]
mat = sc.append(mat, newRow, axis = 0)
sc.delete(mat, 2, 0) #delete the 3rd row
mat = sc.array([[0,1],[2,3]])
mat0 = sc.array([[0,10], [-1,3]])
sc.concatenate((mat,mat0), axis = 0)

mat.ravel() #change array dimensions(e.g. from matrix to a vector)
mat.reshape((4,1))
mat.reshape((1,4))

sc.ones((4,2))
sc.zeros((4,2))
m = sc.identity(4) #identity matrix
m
m.fill(16)

mm = sc.arange(16)
mm = mm.reshape(4,4)
mm
mm.transpose()
mm // mm.transpose()
mm // (mm+1).transpose()
mm* sc.pi
mm.dot(mm) #?
mm = sc.matrix(mm)
print(type(mm))
mm*mm

import scipy.stats
scipy.stats.norm.rvs(size=10) #10 samples from 0-1
scipy.stats.randint.rvs(0,10, size=7) #random integers


####The Lotka-Volterra model
import scipy.integrate as integrate

def dCR_dt(pops, t=0):
    """Returns the growth rate of consumer and resource population at any given time step"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C
    return sc.array([dRdt,dCdt])

type(dCR_dt)

r = 1.
a = 0.1
z =1.5
e = 0.75

t = sc.linspace(0, 15, 1000)

R0 = 10
C0 = 5
RC0 = sc.array([R0, C0])
#infodict: return a modifiable information dictionry object
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops
type(infodict)
infodict.keys()
infodict['message'] #whether the integration was successful

import matplotlib.pylab as p
f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label = 'Resource density')
p.plot(t, pops[:,1] , 'b-', label='Consumer density')
p.grid()
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.legend(loc='best')

p.show()

f1. savefig('../results/LV_model.pdf')