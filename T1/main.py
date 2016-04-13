#!/usr/bin/python3

from direct_methods import gaussian_elimination
from scarborough import scarborough
from sor import sor
from augmented import augmented

if __name__ == "__main__":
    n = 100
    print("------------------------------------------------")
    print("A) DIRECT METHOD")
    print("\t [Gaussian elimination without partial pivoting]")
    answers = gaussian_elimination(augmented(n))
    print("Exact values from the linear equations: \n")
    print(answers)
    print("------------------------------------------------")
    print("\n")

    print("------------------------------------------------")
    print("B) ITERATIVE METHOD")
    print("1) Scarborough criterion ")
    print("------------------------------------------------")
    if not(scarborough(augmented(n))):
        print("There no has diagonal dominance.")
        print("2-3) Testing relaxing methods")
        print("4) Floating point operations")
        print("\t [Successive over-relaxation]")

        it= 1000
        omega = 1.878
        tol = 1e-2
        print("Iterations: {} Omega: {} Tolerance: {}".format(it, omega, tol))
        m = augmented(100)
        scaled = sor(m, it, omega, tol)

        print(scaled)
        print("\n")

        print("-------------------------------------------")
        print("5) Truncation error")
        print("-------------------------------------------")
        x = sor(m, 500, 1.879, 1e-4)
        y = sor(m, 500, 1.879, 1e-8)
        trunc = abs(max(abs(i - j) for i, j in zip(x, y)))
        print("Biggest truncation error: {}".format(trunc))

