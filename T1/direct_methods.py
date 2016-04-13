#!/usr/bin/python3

def partial_pivoting(k, n, m):
    """ Partial pivoting of a matrix. The entry with largest absolute
    value from the column of the matrix that is currently being 
    considered as the pivot element, partial pivoting adjusts the
    main diagonal with these pivots.
    
    Args:
        k : column to be adjusted, with largest in the top
        (according with the respective line)
        n : number of the rows
        m : matrix to be "pivoted"

    Returns:
        m : pivoted matrix
    
    See:
        https://en.wikipedia.org/wiki/Pivot_element#Partial_and_complete_pivoting
    """
    max_value = abs(m[k][k])
    max_vpos = k
    
    for i in range(k+1, n):
        if abs(m[i][k]) > max_value:
            max_value = m[i][k]
            max_vpos = i
    
    aux = m[k]
    m[k] = m[max_vpos]
    m[max_vpos] = aux
    return m

def gauss_with_pivoting(m):
    """ Gaussian elimination with partial pivoting

    Args:
        m : Augmented matrix to resolve the linear equations

    Returns:
        x : Array with values of [x[1], x[2], ..., x[n]]
    """
    n = len(m)
    for i in range(n-1):
        m = partial_pivoting(i, n, m)
        for j in range(i+1, n):
            aux = m[j][i] / m[i][i]
            m[j][i] = aux
            for k in range(i+1, n):
                m[j][k] = m[j][k] - aux * m[i][k]
            m[j][n] -= aux * m[i][n]
    x = [0] * n
    for i in range(n-1, -1, -1):
        le_sum = sum(m[i][j] * x[j] for j in range(i+1, n))
        x[i] = (m[i][n] - le_sum) / m[i][i]
    return x

def gaussian_elimination(m):
    """ Algorithm to solving systems of linear equations.

    Args:
        m : Augmented matrix to resolve the linear equations

    Returns:
        x : Array with values of [x[1], x[2], ..., x[n]]
    
    See:
        https://en.wikipedia.org/wiki/Gaussian_elimination
    """
    n = len(m)
    ops = 0
    for i in range(n-1):
        for j in range(i+1, n):
            aux = m[j][i] / m[i][i]
            m[j][i] = aux
            ops += 1
            for k in range(i+1, n):
                m[j][k] -= aux * m[i][k]
                ops += 2
            m[j][n] -= aux * m[i][n]
            ops += 2
    x = [0] * n
    for i in range(n-1, -1, -1):
        le_sum = sum(m[i][j] * x[j] for j in range(i+1, n))
        x[i] = (m[i][n] - le_sum) / m[i][i]
        ops += 2 + 2* len(range(i+1, n))
    print("Floating point operations: {}".format(ops))
    return x

