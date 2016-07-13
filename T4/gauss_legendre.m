%{
    Gauss-Legendre integration method.
    Given a function f(x) = y and 'm' points in a interval x E [a,b] 
    the Gauss-Legendre method will calculate the definite integral (area)
    of the function in the defined interval. With this method, is
    possible to get the exact integral of the function using until
    (2m - 1) points. The Gauss-Legendre method does not use the points 
    a and b to calculate the integral.

    Args:
        a : interval a
        b : interval b
        m : number of points in the interval
        func : function f(x)

    Returns:
        gm : The define integral from a function with bounds in [a, b]
        coef : The coeficients of the polynomial Pn(x)
        x : x points used to approximate Pn(x)
        y : y points used to approximate Pn(x)
        
    Obs.:
        'polyfit' returns the coefficients of a polynomial Pn(x) of degree (m-1)
        that minimizes the error of the fit to the points [x, y]

    See:
        https://en.wikipedia.org/wiki/Gaussian_quadrature
        https://www.gnu.org/software/octave/doc/v4.0.0/Polynomial-Interpolation.html
%}
function [gm, coef, x, y] = gauss_legendre(m, a, b, func)
    C = cgl();
    t = tgl();
    tsum = 0;
    for k = 1 : m
        x(k) = 0.5 * (b - a) * t(m, k) + 0.5 * (b + a);
        % y = f(x) = -x ^ 2
        % f(x) is the integrand function from the erf function
        y(k) = func(-x(k) .^ 2);
        tsum = tsum + C(m,k) * y(k);
    end
    gm = 0.5 * (b - a) * tsum;

    y = y * (2 / sqrt(pi));
    coef = polyfit(x, y, m-1);
end
