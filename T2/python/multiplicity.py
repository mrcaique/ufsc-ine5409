#!/usr/bin/env python3

def multiplicity(ratio):
    rlim = 0.0001 * ratio[len(ratio)]
    m = 1
    remainders = abs(ratio[0]) + abs(ratio[1])
    while remainders < rlim:
        m += 1
        remainders += abs(ratio[m])

    return m
