%{
    Non-linear Newton Raphson.
    Method to resolve a non-linear equations from a specific function f(x) with
    Newton-Raphson approach.
    f(x) = ln(a + b * T(k)^2)
    
    Args:
        xi : initial x
        
    Returns:
        x : final x
        
    See:
        https://en.wikipedia.org/wiki/Newton%27s_method
%}
function x = nl_newton_raphson(xi)
    dx = [1.e-6 1.e-6];
    dif = 1;
    iter = 0; 
    while (dif > 1.e-15 && iter < 30) 
        iter = iter + 1;
        
        pos1 = [xi(1) + dx(1), xi(2)];
        pos2 = [xi(1), xi(2) + dx(2)];
        pos3 = [xi(1) + dx(1), xi(2)];
        pos4 = [xi(1), xi(2) + dx(2)];
        
        mat = [
            (g1(pos1) - g1(xi)) / dx(1), ...
            (g1(pos2) - g1(xi)) / dx(2), ...
            -g1(xi);

            (g2(pos3) - g2(xi)) / dx(1), ...
            (g2(pos4) - g2(xi)) / dx(2), ...
            -g2(xi);
        ];
        
        dx = gauss(2, mat);
        x = xi + transpose(dx);
        xi = x;
        dif = max(abs(dx));
    end
end
