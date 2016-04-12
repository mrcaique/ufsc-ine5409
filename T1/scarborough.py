#!/usr/bin/python3

def scarborough(m):
    """Scarborough criterion for convergence of a iterative solution of linear equations.
    For a linear equation system, if every equation has a element that is greater
    or equal then the sum of the others AND at least one equation has an element 
    that is greater then the others, then the linear equation system converge to a
    result (has diagonal dominace), else, nothing can be said about the convergence.

    Args:
        m : matrix m to evaluate the convergency

    Returns:
        conv : a boolean value, if the matrix has or not diagonal dominace.
    
    See:
        https://en.wikipedia.org/wiki/Scarborough_criterion
    """
    conv = False
    eqs = len(m)
    for i in range(eqs):
        equation = m[i]
        equation.pop() # Remove the augmented part of the matrix
        big = max(equation)
        equation.remove(max(equation))
        if big < sum(equation):
            print("{} is not bigger or equal than {}".format(big, sum(equation)))
            return False
        elif big > sum(equation):
            conv = True
    return conv

