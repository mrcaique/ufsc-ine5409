function y = briot_ruffini(n, a, x)
    Nx = length(x);
    for k = 1 : Nx
        b(1) = a(1);
        for i = 2 : n + 1
            b(i) = a(i) + x(k) * b(i-1);
        end
        y(k) = b(n+1);
    end
end

