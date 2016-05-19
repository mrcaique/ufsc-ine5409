#!/usr/bin/env python3

from math import cos, pi

def cauchy(func, tol):
    def cauchy_max(func, tol):
        n = len(func)
        max_rad = (abs(func[-1] / func[0])) ** (1/n-1)
        while True:
            init_rad = max_rad
            max_rad = sum(abs(func[j] / func[0]) * (init_rad ** (n - j)) for j in range(1, n)) ** (1/n)
            if (abs(max_rad - init_rad) < tol):
                return max_rad

    return (cauchy_max(func, tol), cauchy_max(func[::-1], tol))
# def cauchy_max(func, tol):
#     n = len(func)
#     max_rad = (abs(func[-1] / func[0])) ** (1/n-1)
#     while True:
#         init_rad = max_rad
#         max_rad = sum(abs(func[j] / func[1]) * (init_rad ** (n - j)) for j in range(1, n)) ** (1/n)
#         if (abs(max_rad - init_rad) < tol):
#             break

#     return max_rad

# def cauchy_min(func, tol):
#     n = len(func)
#     min_rad = abs(func[0] / func[-1]) ** (1/n-1)
#     while True:
#         init_rad = min_rad
#         min_rad = 1 / sum(abs(func[j] / func[-1]) * init_rad ** (j) for j in range(1, n)) ** (1/n)
#         if (abs(init_rad - min_rad) < tol):
#             break

#     return min_rad

def kojima(func):
    def kojima_max(func):
        queue = [abs(func[i] / func[0]) ** (1 / i) for i in range(1, len(func))]
        return sum(sorted(queue)[-2:])

    return (kojima_max(func), 1 / kojima_max(func[::-1]))

def track(f, tol):
    n = len(f)

    max_rad = [None] * 3
    min_rad = [None] * 3

    max_rad[0] = 1 + max(abs(i) for i in f) / abs(f[0])
    min_rad[0] = 1 / (1 + max(abs(i) for i in f)) / abs(f[-1])

    print(min_rad[0])

    max_rad[1] = cauchy_max(f, tol)
    max_rad[2] = kojima_max(f)
    
    print(max_rad[1])

    min_rad[1] = cauchy_min(f, tol)
    min_rad[2] = kojima_min(f, min_rad[1])

    rmax = min(max_rad)
    rmin = max(min_rad)

    mean = (rmax + rmin) / 2
    
    a = mean * cos(pi/4)
    b = (-1) * a
    xi = complex(a, b)

    return xi

