#! /usr/bin/env python

##
## Esta es la funcion que mapea la entrada a parejas (clave, valor)
##
import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#

infile = sys.stdin
for line in infile:
    line = line.split(',')
    amount = line[4]
    purpose = line[3]
    sys.stdout.write("{}\t{}\n".format(purpose,amount))
