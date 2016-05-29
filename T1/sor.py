#!/usr/bin/python3

from sys import float_info
from copy import deepcopy

def sor(m, it, lamb, tol=float_info.epsilon):
    """Successive over-relaxation (SOR) is a variant of the Gauss-Seidel
    method for resolving linear system of equations to result a faster convergence.

    Args:
        m : matrix with the linear system of equations
        it : maximum number of iterations
        lamb : Relaxing factor
        tol : tolerancy, a stopping criterion (to not execute several operations)
            default: epsilon constant (2.220446049250313e-16)
    
    Returns:
        x : Array with the values of the elements of linear equations

    See:
        direct_methods.py
        https://en.wikipedia.org/wiki/Successive_over-relaxation
    """
    n = len(m)
    x = [0] * n
    ops = 0
    for k in range(it):
        init = deepcopy(x)
        i = 0
        x[i] = (1 - lamb) * x[i] + lamb * (m[i][n] - x[i+1])
        ops += 4
        for i in range(1, n//2):
            x[i] = (1 - lamb) * x[i] + lamb * (m[i][n] - x[i-1] - x[i+1] - x[i+(n//2)]) / m[i][i]
            ops += 8
        for i in range(n//2, n-1):
            x[i] = (1 - lamb) * x[i] + lamb * (m[i][n] - x[i-(n//2)] - x[i-1] - x[i+1]) / m[i][i]
            ops += 8
        i = n - 1
        x[i] = (1 - lamb) * x[i] + lamb * (m[i][n] - x[i-1])
        ops += 5
        if max(abs((i - j) / j) for i, j in zip(init, x)) < tol:
            print("Maximum tolerance exceeded at iteration {}.".format(k+1))
            break
    print("Operations: {}".format(ops))
    return x

