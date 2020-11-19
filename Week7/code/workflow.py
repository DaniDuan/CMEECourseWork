"""Using Python to build workflows"""

import subprocess

p = subprocess.Popen(["echo", "I'm talking to you bash!"], stdout = subprocess.PIPE, stderr=subprocess.PIPE)
stdout,stderr = p.communicate()
stderr
stdout
print(stdout.decode())

p = subprocess.Popen(["ls", "-l"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

p = subprocess.Popen(["python3", "boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout,stderr = p.communicate()
print(stdout.decode())

#subprocess.os.system("pdflatex yourlatexdoc.tex")

subprocess.os.path.join('directory', 'subdirectory', 'file')

MyPath = subprocess.os.path.join('directory', 'subdirectory', 'file')
MyPath







