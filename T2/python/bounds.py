#!/usr/bin/env python3

def cauchy(func, tol):
    def cauchy_rad(func, tol):
        n = len(func)
        max_rad = (abs(func[-1] / func[0])) ** (1/n-1)
        while True:
            init_rad = max_rad
            max_rad = sum(abs(func[j] / func[0]) * (init_rad ** (n - j)) for j in range(1, n)) ** (1/n)
            if (abs(max_rad - init_rad) < tol):
                return max_rad

    return (cauchy_rad(func, tol), cauchy_rad(func[::-1], tol))

def kojima(func):
    def kojima_rad(func):
        queue = [abs(func[i] / func[0]) ** (1 / i) for i in range(1, len(func))]
        return sum(sorted(queue)[-2:])

    return (kojima_rad(func), 1 / kojima_rad(func[::-1]))

