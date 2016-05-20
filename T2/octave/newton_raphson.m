function [x M k difDif] = newton_raphson(n, a, xI, tol)
    difAnt = 1;
    k=0;
    difDif = 1;
    while (difDif > tol && k < 120)
        k = k + 1;
        r = remainders(n, a, xI);
        M = multiplicity(r);
        dx = - r(M)/(M*r(M+1));
        x = xI + dx;
        xI = x;
        dif = abs(dx)+abs(r(1));
        difDif = abs(difAnt - dif);
        difAnt = dif;
    end
    printf("[ C ] Iterations in NR: "),
    disp(k)
    printf("[ E ] Stopping criterion from Newton-Raphson in: "),
    disp(difDif);
end
