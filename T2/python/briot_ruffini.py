#!/usr/bin/env python3

def briot_ruffini(func, x):
    n = len(func)
    b = [None] * n
    for i in range(n):
        b[0] = func[0]
        for j in range(1, n):
            b[j] = x * b[j-1] + func[j]
        n -= 1
        func = b

    r = b[1]

    return r

