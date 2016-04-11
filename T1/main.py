#!/usr/bin/python3

from direct_methods import gaussian_elimination
from scarborough import scarborough
from sor import sor

def augmented(equations):
    n = equations
    rows = n
    cols = n + 1
    augmented = [[0] * int(cols) for i in range(rows)]
    
    i = 0
    augmented[i][i] = 1
    augmented[i][i+1] = 1
    augmented[i][n] = 1.50
    
    for i in range(1, n//2):
        augmented[i][i-1] = 1
        augmented[i][i] = 3
        augmented[i][i+1] = 1
        augmented[i][i+n//2] = 1
        augmented[i][n] = 1.00
    
    for i in range(n//2, n-1):
        augmented[i][i-(n//2)] = 1
        augmented[i][i-1] = 1
        augmented[i][i] = 3
        augmented[i][i+1] = 1
        augmented[i][n] = 2.00
    
    i = n-1
    augmented[i][i-1] = 1
    augmented[i][i] = 1
    augmented[i][n] = 3.00

    return augmented

if __name__ == "__main__":
    matrix = augmented(100)
    print("------------------------------------------------")
    print("\t DIRECT METHOD")
    print("Gaussian elimination without partial pivoting")
    print("------------------------------------------------")
    answers = gaussian_elimination(matrix)
    print("Exact values from the linear equations: ")
    print(answers)    

    matrix2 = augmented(100)
    print("------------------------------------------------")
    print("\t ITERATIVE METHOD")
    print("Scarborough criterion ")
    print("------------------------------------------------")
    if not(scarborough(matrix2)):
        print("There no has diagonal dominance." + "\n")
        print("Testing relaxing methods: ")
        print("-------------------------------------------")
        print("Successive over-relaxation ")
        print("-------------------------------------------")
        iterations = 1000
        lamb = 1.792
        tol = 1e-4
        print("Iterations: " + str(iterations))
        print("Tolerancy: " + str(lamb))
        matrix3 = augmented(100)
        scaled = sor(matrix3, iterations, lamb, tol)
        print(scaled)
