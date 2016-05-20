#!/usr/bin/env python3

from bounds import kojima, cauchy 
from briot_ruffini import briot_ruffini
from math import cos, pi

if __name__ == "__main__":
    print("-----------------------------------------")
    tol = 1e-12
    f = [complex(1, 0), complex(-5, -1), complex(9.99, 5),\
        complex(-9.97, -9.99), complex(4.97, 9.97), \
        complex(-0.99, -4.97), complex(0, 0.99)]
    
    c_rad = cauchy(f, tol)
    k_rad = kojima(f)

    rmax = min([c_rad[0], k_rad[0]])
    rmin = max([c_rad[1], k_rad[1]])

    mean = (rmax + rmin) / 2
    
    a = mean * cos(pi/4)
    xi = complex(a, -a)
    print(xi)

    print("-----------------------------------------")
    remainder = briot_ruffini(f, rmin)
    print(abs(remainder))

