#!/usr/bin/env python3

def newton_raphson(func, xi, tol):
    n = len(func)
    old = 1
    k = 0
    diff = 1
    while(diff > tol and k < 120):
        k += 1
        r = briot_ruffini(func, xi)
        m = multiplicity(r)
        dx = - r[m] / (m * r[m+1])
        x = xi + dx
        dif = abs(dx) + abs(r[0])
        diff = abs(diff1 - dif)
        old = dif

    return [x, m, k, diff]
