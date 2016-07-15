function a = pol_adjust(n, m, x, y)
    order = n + 1;
    for i = 1 : order
        for j = 1 : order
            tsum = 0;
            for k = 1 : m
                tsum += x(k)^(i+j-2);
            end
            A(i,j) = tsum;    
        end
        
        tsum = 0;
        for k = 1 : m
            tsum += x(k)^(i-1) * y(k);
        end
        b(i) = tsum;
    end
    b = transpose(b);
    m = [A b];
    a = gauss(order, m);
end
