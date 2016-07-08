function sn = simpson(n, a, b, func)
    h = (b - a) / n;
    x = a : h : b;
    y = func(-x .^ 2);

    tsum = 0;
    esum = 0;
    for i = 2 : 2: n
        tsum += y(i);
    end
    for i = 3 : 2 : n - 1
        esum += y(i);
    end
    sn = h/3 * (y(1) + 4 * tsum + 2 * esum + y(n+1));
end
