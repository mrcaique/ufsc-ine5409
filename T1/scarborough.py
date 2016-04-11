#!/usr/bin/python3

def scarborough(matrix):
    conv = False
    eqs = len(matrix)
    for i in range(eqs):
        equation = matrix[i]
        equation.pop() # Remove the augmented part of the matrix
        big = max(equation)
        equation.remove(max(equation))
        if big < sum(equation):
            print("{} is not bigger or equal than {}".format(big, sum(equation)))
            return False
        elif big > sum(equation):
            conv = True
    return conv

