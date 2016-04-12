#!/usr/bin/python3

from direct_methods import gaussian_elimination
from scarborough import scarborough
from sor import sor
from augmented import augmented

if __name__ == "__main__":
    print("------------------------------------------------")
    print("A) DIRECT METHOD")
    print("\t [Gaussian elimination without partial pivoting]")
    answers = gaussian_elimination(augmented(100))
    print("Exact values from the linear equations: \n")
    print(answers)
    print("------------------------------------------------")
    print("\n")

    print("------------------------------------------------")
    print("B) ITERATIVE METHOD")
    print("1) Scarborough criterion ")
    print("------------------------------------------------")
    if not(scarborough(augmented(100))):
        print("There no has diagonal dominance.")
        print("2-3) Testing relaxing methods")
        print("4) Floating point operations")
        print("\t [Successive over-relaxation]")

        it= 1000
        lamb = 1.878
        tol = 1e-4
        print("Iterations: {} Lambda: {} Tolerance: {}".format(it, lamb, tol))
        m = augmented(100)
        scaled = sor(m, it, lamb, tol)

        print(scaled)
        print("\n")

        print("-------------------------------------------")
        print("5) Truncation error")
        print("-------------------------------------------")
        x = sor(m, 150, 1.878, 1e-4)
        y = sor(m, 300, 1.878, 1e-4)
        trunc = max(i - j for i, j in zip(x, y))
        print("Biggest truncation error: {}".format(trunc))

