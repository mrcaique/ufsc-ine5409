%{
    Simpson's method.
    The Simpson's method is a technique for approximating the definite integral.

    Given a function f(x) in a interval [a, b], the definite integral I
    from this function defines the area A of the curve. This curve can be
    approximate by several trapezium, where each trapezium is defined by two
    points. Each trapezium are grouped two by two (with three points), defining
    an area A of the trapezium, because of this that Simpson's method need
    a even number of points.
    
    Args:
        n : number of points
        a : interval a
        b : interval b
        func : function f(x)
    
    Returns:
        sn: Area of the function f(x) approximate by the Simpson's method
    
    See:
        https://en.wikipedia.org/wiki/Simpson%27s_rule
%}
function sn = simpson(n, a, b, func)
    h = (b - a) / n;
    x = a : h : b;
    % y = f(x) = -x ^ 2
    % f(x) is the integrand function from the erf function
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
