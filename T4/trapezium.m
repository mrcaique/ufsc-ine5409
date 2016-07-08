%{
    Implements trapezium rule. The trapezium rule is a technique for
    approximating the definite integral.

    Given a function f(x) in a interval [a, b], the definite integral I
    from this function defines the area A of the curve. This curve can be
    approximate by 'n' trapezium, so, the area of these n trapezium can
    be an approximation of the area A.
    
    Args:
      n : number of points
      a : interval a
      b : interval b
      func : function f(x)
      
    Returns:
      Tn: Area of the function f(x) approximate by the trapezium method
      
    See:
      https://en.wikipedia.org/wiki/Trapezoidal_rule
%}
function Tn = trapezium(n, a, b, func)
    h = (b - a) / n;
    x = a : h : b;
    y = func(-x .^ 2);

    tsum = 0;
    for i = 2 : n
        tsum += y(i);
    end
    
    Tn = 0.5 * h * (y(1) + 2 * tsum + y(n+1));
end
