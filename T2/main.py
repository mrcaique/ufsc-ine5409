#!/usr/bin/env python3

from bounds import kojima, cauchy 
from func import func
from math import cos, pi

if __name__ == "__main__":
    print("-----------------------------------------")
    tol = 1e-12
    f = [complex(1, 0), complex(-5, -1), complex(9.99, 5), complex(-9.97, -9.99), complex(4.97, 9.97), complex(-0.99, -4.97), complex(0, 0.99)]
    
    #max_rad= [None] * 3
    #min_rad = [None] * 3

    #max_rad[0] = 1 + max(abs(i) for i in f) / abs(f[0])
    #min_rad[0] = 1 / (1 + max(abs(i) for i in f)) / abs(f[-1])

    c_rad = cauchy(f, tol)
    k_rad = kojima(f)

    rmax = min(c_rad)
    rmin = max(c_rad)

    mean = (rmax + rmin) / 2
    
    a = mean * cos(pi/4)
    b = (-1) * a
    xi = complex(a, b)
    print(xi)

