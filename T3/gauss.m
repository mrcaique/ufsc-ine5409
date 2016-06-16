%{
    Algorithm to solving systems of linear equations.

    Args:
        m : Augmented matrix to resolve the linear equations
        n : Size of the matrix

    Returns:
        x : Array with values of [x[1], x[2], ..., x[n]]
    
    See:
        https://en.wikipedia.org/wiki/Gaussian_elimination
%}
function x = gauss(n, m)
    for k = 1 : n-1
        m = partial_pivoting(m, k, n);
        for i = k+1 : n
            aux = m(i, k) / m(k, k);
            for j = k+1 : n+1
                m(i, j) = m(i, j) - aux * m(k, j);
            end
            m(i,k) = 0;
        end
    end

    if(abs(m(n,n)) < eps)
        if(abs(m(n,n+1)) < eps)
            printf("Sistema indeterminado\n")
            x(n) = 0;
        else
            printf("Sistema impossível\n")
            x(n) = NaN;
        end
    else
        x(n) = m(n, n+1) / m(n, n);
    end

    for i = n-1 : -1 : 1
        soma = 0;
        for j = i+1 : n
            soma = soma + m(i,j) * x(j);
        end
        x(i) = (m(i, n+1) - soma) / m(i,i);
    end
end

