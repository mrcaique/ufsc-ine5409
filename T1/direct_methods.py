#!/usr/bin/python3

def partial_pivoting(k, n, matrix):
    max_value = abs(matrix[k][k])
    max_vpos = k
    
    for i in range(k+1, n):
        if abs(matrix[i][k]) > max_value:
            max_value = matrix[i][k]
            max_vpos = i
    
    aux = matrix[k]
    matrix[k] = matrix[max_vpos]
    matrix[max_vpos] = aux
    return matrix

def gaus_with_pivoting(matrix):
    n = len(matrix)
    for i in range(n-1):
        matrix = partial_pivoting(i, n, matrix)
        for j in range(i+1, n):
            aux = matrix[j][i] / matrix[i][i]
            matrix[j][i] = aux
            for k in range(i+1, n):
                matrix[j][k] = matrix[j][k] - aux * matrix[i][k]
            matrix[j][n] -= aux * matrix[i][n]
    x = [0] * n
    for i in range(n-1, -1, -1):
        le_sum = sum(matrix[i][j] * x[j] for j in range(i+1, n))
        x[i] = (matrix[i][n] - le_sum) / matrix[i][i]
    return x

def gaussian_elimination(matrix):
    n = len(matrix)
    for i in range(n-1):
        for j in range(i+1, n):
            aux = matrix[j][i] / matrix[i][i]
            matrix[j][i] = aux
            for k in range(i+1, n):
                matrix[j][k] = matrix[j][k] - aux * matrix[i][k]
            matrix[j][n] -= aux * matrix[i][n]
    x = [0] * n
    for i in range(n-1, -1, -1):
        le_sum = sum(matrix[i][j] * x[j] for j in range(i+1, n))
        x[i] = (matrix[i][n] - le_sum) / matrix[i][i]
    return x

