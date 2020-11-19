"""Runs fmr.R to generate the desired result
 and print to the python screen whether the run was successful,
 and the contents of the R console output."""

import subprocess


subprocess.call(["Rscript", "fmr.R"])

# try:
#     subprocess.check_output(subprocess.call(["Rscript", "fmr.R"]))
#     print("Successful!")
# except:
#     print("Unsuccessful")


p = subprocess.Popen(["Rscript", "fmr.R"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
output, error = p.communicate()
if p.returncode != 0: 
   print("\nUnsuccessful!\n %d Error occurred:\n %s" % (p.returncode, error))
