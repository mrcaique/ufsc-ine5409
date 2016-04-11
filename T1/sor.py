#!/usr/bin/python3

from sys import float_info
from copy import deepcopy

def sor(mat, iterations, relax, tol=float_info.epsilon):
    neq = len(mat)
    x = [0] * neq
    for k in range(iterations):
        prev = deepcopy(x)
        for i in range(neq):
            summ = sum(mat[i][j] * x[j] for j in range(neq) if j != i)
            x[i] += relax * (((mat[i][neq] - summ) / mat[i][i]) - x[i])
        if abs(max(prev[i] - x[i] for i in range(len(x)))) < tol:
            print("Maximum tolerance exceeded at iteration {}.".format(k+1))
            break
    return x

