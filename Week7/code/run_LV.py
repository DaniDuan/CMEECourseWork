#!usr/bin/env python3

"""Imports LV1.py, LV2.py, LV3.py, LV4.py and LV5.py and profiles them"""

__appname__ = "Run_LV.py"
__author__ = 'Elin Falla (ef16@ic.ac.uk), Ioan Evans (ie917@ic.ac.uk), Danica Duan (dd1820@ic.ac.uk)'
__version__ = '0.0.2'

# Imports #
# Packages
import cProfile
import pstats
import sys

# Scripts
import LV1
import LV2
import LV3
import LV4
import LV5


scripts = (LV1, LV2, LV3, LV4, LV5)

for script in scripts:
    # opens profile
    pr = cProfile.Profile()

    # enables profile
    pr.enable()

    # runs script within profile
    script.main([])  # main takes argv which is a list so put in empty list

    # disables profile
    pr.disable()

    # create stats based on the profile
    ps = pstats.Stats(pr)

    # sort stats by cumulative time then print first 20 lines to get only largest cumtimes
    ps.sort_stats('cumtime').print_stats(20)







