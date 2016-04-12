#!/usr/bin/python3

from sys import float_info
from copy import deepcopy

def sor(mat, it, lamb, tol=float_info.epsilon):
    n = len(mat)
    x = [0] * n
    ops = 0
    #sums = 0
    #subs = 0
    #flt = 0
    #div = 0
    #mult = 0
    for k in range(it):
        init = deepcopy(x)
        i = 0
        x[i] = (1 - lamb) * x[i] + lamb * (1.50 - x[i+1])
        ops += 1
        #sums += 1
        #flt += 3
        #mult += 2
        for i in range(1, n//2):
            x[i] = (1 - lamb) * x[i] + lamb * (1.00 - x[i-1] - x[i+1] - x[i+(n//2)]) / 3
            ops += 1
            #sums += 1
            #subs += 4
            #flt += 6
            #mult += 2
            #div += 1
        for i in range(n//2, n-1):
            x[i] = (1 - lamb) * x[i] + lamb * (2.00 - x[i-(n//2)] - x[i-1] - x[i+1]) / 3
            ops += 1
            #sums += 1
            #subs += 4
            #flt += 6
            #div += 1
            #mult += 2
        i = n - 1
        x[i] = (1 - lamb) * x[i] + lamb * (3.00 - x[i-1])
        ops += 1
        #sums += 1
        #subs += 2
        #flt += 3
        #mult += 2
        if abs(max(init[i] - x[i] for i in range(len(x)))) < tol:
            print("Maximum tolerance exceeded at iteration {}.".format(k+1))
            break
    print("Operations: {}".format(ops))
    #print("Sums: {}".format(sums))
    #print("Subtractions: {}".format(subs))
    #print("Multiplications: {}".format(mult))
    #print("Divisions: {}".format(div))
    #print("Floating points operations: {}".format(flt))
    return x

