#!/usr/bin/python3

def augmented(equations):
    """ Generate a augmented matrix of linear system of equations,
    where the equations are:
    
    for i = 1:
        x(i) + x(i+1) = 1.50
    for i = 2 to n/2:
        x(i-1) + 3x(i) + x(i+1) + x(i+n/2) = 1.00;
    for i = (n/2)+1 to n-1:
        x(i-n/2) + x(i-1) + 3x(i) + x(i+1) = 2.00
    for i = n:
        x(i-1)) + x(i) = 3.00;

    Args:
        equations : number of linear equations in the system

    Returns:
        augmented : augmented matrix where each row is a equation

    """
    n = equations
    rows = n
    cols = n + 1
    augmented = [[0] * int(cols) for i in range(rows)]

    i = 0
    augmented[i][i] = 1.0
    augmented[i][i+1] = 1.0
    augmented[i][n] = 1.50

    for i in range(1, n//2):
        augmented[i][i-1] = 1.0
        augmented[i][i] = 3.0
        augmented[i][i+1] = 1.0
        augmented[i][i+n//2] = 1.0
        augmented[i][n] = 1.00

    for i in range(n//2, n-1):
        augmented[i][i-(n//2)] = 1.0
        augmented[i][i-1] = 1.0
        augmented[i][i] = 3.0
        augmented[i][i+1] = 1.0
        augmented[i][n] = 2.00

    i = n-1
    augmented[i][i-1] = 1.0
    augmented[i][i] = 1.0
    augmented[i][n] = 3.00

    return augmented

