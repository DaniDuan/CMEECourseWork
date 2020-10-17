import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages

def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C
    return sc.array([dRdt, dCdt])

r = 1
a = 0.1 
z = 1.5
e = 0.75

t = sc.linspace(0, 15, 1000)

R0 = 10
C0 = 5
RC0 = sc.array([R0, C0])

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resourse density')
p.plot(t, pops[:,1], 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')

f2 = p.figure()
p.grid()
p.plot(pops[:,0], pops[:,1],'r-')
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')

figs = PdfPages('../../results/LV_model.pdf')
figs.savefig(f1)
figs.savefig(f2)
figs.close()