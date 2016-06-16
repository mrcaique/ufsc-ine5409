function yPn = gregory_newton(points, n, x, y)
    k = 1;
    for i = 1 : n
        DDy(i,k) = (y(i+1) - y(i)) / (x(i+1) - x(i));
    end
    for k = 2 : n
        for i = 1 : n-k+1
            DDy(i,k) = (DDy(i+1, k-1) - DDy(i, k-1)) / (x(i+k) - x(i));
        end
    end

    for index = 1 : length(points)
        t_sum = y(1);
        for k = 1 : n
            prdct = 1;
            for j = 1 : k
                prdct *= points(index) - x(j);
            end
            t_sum += DDy(1,k) * prdct;
        end
        yPn(index) = t_sum;
    end
end

