function y = remainders(index, mac, x)
    n = length(x);
    for k = 1 : n
        r(index+1) = mac(index+1);
        for i = index : -1 : 1
            r(i) = mac(i) + r(i+1) * x(k);
        end
        y(k) = r(1);
    end
end

