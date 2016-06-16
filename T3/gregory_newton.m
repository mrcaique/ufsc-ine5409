%{
    DIVIDED DIFFERENCES
    Given the respective tabulated values:
    
    i  =  [1  2  ... n]
    xi = [x1 x2 ... xn]
    yi = [y1 y2 ... yn] = f(xi)
    
    The divided difference delta^(k)y, in foward ward, is defined as:

    delta^(1)yi = (y[i+1] - y[i]) / (x[i+1] - x[i])
        For the first order difference
    delta^(k)yi = (delta^(k-1)y[i+1] - delta^(k-1)y[i]) / (x[i-k] - x[i])
        For the k-th order difference

	NEWTON POLYNOMIAL
	The Newton polynomial is a linear combination between "Newton basis
	polynomials" and the dividide differences. The result is:

	N(x) = y1 + dy1*(x - x1) + d^(2)y1*(x - x1)*(x - x2) + ...
        + d^(n)y1*(x - x1)*...*(x - xn)

    Args:
        points : points between a interval [a, b] ("Line of the points in x")
        x : x points in the tabulated table (with correspondents y)
        y : y points in the tabulated table (with correspondents x)
        n : number of points ("number of the columns in the table")

    Return:
        yPn : Newton polynomial

    See:
        https://en.wikipedia.org/wiki/Newton_polynomial#Definition
        https://en.wikipedia.org/wiki/Divided_differences
%}
function yPn = gregory_newton(points, n, x, y)
    % Foward Divided Differences
    k = 1; % Order of the divided difference
    for i = 1 : n
        % Divided differences for first order
        DDy(i,k) = (y(i+1) - y(i)) / (x(i+1) - x(i));
    end
    for k = 2 : n
        % Divided differences for 2 to k-th order
        for i = 1 : n-k+1
            DDy(i,k) = (DDy(i+1, k-1) - DDy(i, k-1)) / (x(i+k) - x(i));
        end
    end

    % Newton polynomial (N(x) == yPn)
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
