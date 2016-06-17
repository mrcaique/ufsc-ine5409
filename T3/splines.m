function [a b c d] = splines(m,x,y,h) 
    t(2) = 0;
    r(2) = 3 * h(1) + 2 * h(2);
    d(2) = h(2);
    b(2) = 6 * ((y(3) - y(2)) / h(2) - (y(2) - y(1)) / h(1));

    for i = 3 : m-1
        t(i) = h(i-1);
        r(i) = 2 * (h(i-1) + h(i));
        d(i) = h(i);
        b(i) = 6 * ((y(i+1) - y(i)) / h(i)-
               (y(i) - y(i-1)) / h(i-1)); 
    end

    t(m) = h(m-1);
    r(m) = (2 * h(m-1) + 3 * h(m));
    d(m) = 0;
    b(m) = 6 * ((y(m + 1) - y(m)) / h(m) - (y(m) - y(m - 1)) / h(m - 1));

    for i = 3 : m
        aux = t(i) / r(i-1);
        t(i) = 0;
        r(i) = r(i) - aux * d(i-1);
        b(i) = b(i) - aux * b(i-1);
    end

    S(m) = b(m) / r(m);

    for i = m-1 : -1 : 2 
      S(i) = (b(i) - d(i) * S(i+1)) / r(i); 
    end

    S(1) = S(2);
    S(m+1) = S(m); 
    S
    a = [];
    b = [];
    c = [];
    d = [];
    for i=1 : m 
        a(i) = (S(i+1) - S(i)) / (6 * h(i)); 
        b(i) = S(i) / 2; 
        c(i) = (y(i+1) - y(i)) / h(i) - (S(i+1) + 2 * S(i)) * h(i) / 6; 
        d(i) = y(i); 
    end
end

