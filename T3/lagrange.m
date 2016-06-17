%{
   Find the coeficients from Lagrange basis polyninials.

   Args:
        xpoints : points in x between the interval [a, b]
        n : number of points
        x : x points in tabulated table
        y : y points in tabulated table

   Returns:
       l : y aprox. for each x

   See:
        https://en.wikipedia.org/wiki/Lagrange_polynomial    
%}
function l = lagrange(xpoints, n, x, y)
    l = 0;
    for i = 1 : n + 1
        prdct = 1;
        for j = 1 : n + 1
            if (j != i)
                prdct = prdct * (xpoints - x(j))/(x(i) - x(j));
            end
        end
        l = l + y(i) * prdct;
    end
end
