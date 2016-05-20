function [x M]= roots2(a)
    tol = 1e-12;
    n = length(a) - 1;
    nI = n;
    aI = a;
    index_root = 0;
    it = 0;
    printf("Tolerancy: "), disp(tol)

    while n > 0
        printf("-----------------------------------------------------------\n");
        index_root = index_root + 1
    % Finding roots
        printf("[ A ] Initial value by search algorithms (Cauchy and Kojima bounds):\n");
        xi = bounds(n, a);
        disp(xi)
    % Approach by Newton-Raphson
        [x(index_root) M(index_root) k difDif] = newton_raphson(n, a, xi, tol);
        printf("[ C ] Iterations in NR: "),
        disp(k)
        it += k;
    % Refinement of the approximate root
        [x(index_root) M(index_root) k difDif] = newton_raphson(nI, aI, ...
          x(index_root), tol);
        printf("[ D ] Iterations of Newton-Raphson with refinement:"),
        disp(k),
        it += k;
        printf("[ E ] Stopping criterion after two NR: \n"),
        disp(difDif)
    % Degree reduction to get the remaining roots
        [n, a] = briot_ruffini(n, a, x(index_root), M(index_root));
        printf("-----------------------------------------------------------\n");
        printf("\n")
    end
    printf("[ F ] Total iterations: "), disp(it), printf("\n")
end
