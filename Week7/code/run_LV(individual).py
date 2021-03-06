"""Runs both LV1.py and LV2.py with appropriate arguments."""

from LV1 import main as lv1run
from LV2 import main as lv2run
import cProfile
import pstats

lv1run([])
lv2run([1,5000,0.5,1.5,0.75])

pr = cProfile.Profile() #creating a new profile

pr.enable() #enabling the profile
lv1run([]) #run the program for profiling 
pr.disable() #disabling the profile
ps = pstats.Stats(pr)
ps.sort_stats('cumtime').print_stats(15)   # Sort by cumulative time spent in the function

pr.enable()
lv2run([])
pr.disable()
ps = pstats.Stats(pr)
ps.sort_stats('cumtime').print_stats(15)   # Sort by cumulative time spent in the function


