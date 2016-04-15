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
    VE = gaussian_elimination(augmented(n))
    print("Exact values from the linear equations: \n")
    print(VE)
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
        omega = 1.879
        tol = 1e-4
        print("Iterations: {} Omega: {} Tolerance: {}".format(it, omega, tol))
        m = augmented(100)
        VA = sor(m, it, omega, tol)

        print(VA)
        print("\n")

        print("-------------------------------------------")
        print("5) Truncation error")
        print("-------------------------------------------")
        #VA = sor(m, 500, 1.879, 1e-4)
        #VE = sor(m, 1000, 1.879, 1e-4)
        trunc = abs(max(abs((i - j) / j) for i, j in zip(VA, VE)))
        print("Biggest truncation error: {}".format(trunc))

