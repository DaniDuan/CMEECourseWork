import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages
import sys


def plot_f1(pops, t, r, a, z, e):
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resourse density')
    p.plot(t, pops[:,1], 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    return f1


def plot_f2(pops, r, a, z, e):
    f2 = p.figure()
    p.grid()
    p.plot(pops[:,0], pops[:,1],'r-')
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics')
    return f2


def save_figs(f1, f2): 
    figs = PdfPages('../results/LV_model.pdf')
    figs.savefig(f1)
    figs.savefig(f2)
    figs.close()
    return 0


def main(argv):
    r = 1
    a = 0.1 
    z = 1.5
    e = 0.75

    def dCR_dt(pops, t=0):
        R = pops[0]
        C = pops[1]
        dRdt = r * R - a * R * C
        dCdt = -z * C + e * a * R * C
        return sc.array([dRdt, dCdt])

    t = sc.linspace(0, 15, 1000)

    R0 = 10
    C0 = 5
    RC0 = sc.array([R0, C0])

    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    f1 = plot_f1(pops, t, r, a, z, e)
    f2 = plot_f2(pops, r, a, z, e)
    save_figs(f1, f2)
    return 0


if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)
