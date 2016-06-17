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

