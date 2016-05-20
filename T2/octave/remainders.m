function r = remainders(n, a, xI)
    nI = n;
    n;
    a;
    for d = 1 : nI
        b(1) = a(1);
        for i = 2 : n+1
            b(i) = a(i) + xI * b(i-1);
        end
        r(d) = b(n+1);
        n = n-1;
        a = b;
    end
    r(nI+1) = b(1);
end
