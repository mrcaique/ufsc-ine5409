function xI = bounds(n,a)
    % Max bound
    max_rad(1) = 1 + max(abs(a(2:n+1))) / abs(a(1));
    min_rad(1) = 1 / (1 + max(abs(a(1:n))) / abs(a(n+1)));

    % Cauchy bound
    % max:
    rI = abs(a(n+1) / a(1)) ^ (1/n);
    for k = 1 : 30
        t_sum = abs(a(n+1) / a(1));
        for i = 2 : n
            t_sum = t_sum + abs(a(i) / a(1)) * rI ^ (n-i+1);
        end
        max_rad(2) = t_sum ^ (1/n);
        rI = max_rad(2);
    end
    %min:
    rI = abs(a(1) / a(n+1)) ^ (1/n);
    for k = 1 : 30
        t_sum = abs(a(1) / a(n+1));
        for i = 2 : n
            t_sum = t_sum + abs(a(i) / a(n+1)) * rI ^ (i-1);
        end
        rI = t_sum ^ (1/n);
    end
    min_rad(2) = 1/rI;

    % Kojima bound
    % max:
    for i = 2 : n+1
        q(i) = abs(a(i) / a(1)) ^ (1 / (i-1));
    end
    order = sort(q);
    max1 = order(n+1);
    max2 = order(n);
    max_rad(3) = max1 + max2;
    % min:
    for i = 2 : n+1
        q(i) = abs(a(n-i+2) / a(n+1)) ^ (1 / (i-1));
    end
    order = sort(q);
    max1 = order(n+1);
    max2 = order(n);
    min_rad(3) = 1 / (max1 + max2);

    rmax = min(max_rad);
    rmin = max(min_rad);

    mean_rad = ((rmax+rmin)/2);
    a = mean_rad * cos(pi/4);
    b = -a;
    xI = complex(a,b);
end
