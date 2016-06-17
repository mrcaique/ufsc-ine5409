%{
    DIVIDED DIFFERENCES
    Given the respective tabulated values in the table T1:
    
    Table T1 = {
        i  =  [1  2  ... n]
        xi = [x1 x2 ... xn]
        yi = [y1 y2 ... yn] = f(xi)
    }

    The divided difference delta^(k)y, in foward ward, is defined as:

    delta^(1)yi = (y[i+1] - y[i]) / (x[i+1] - x[i])
        For the first order difference
    delta^(k)yi = (delta^(k-1)y[i+1] - delta^(k-1)y[i]) / (x[i-k] - x[i])
        For the k-th order difference
    
    Args:
        n : number of points ("number of the columns in the table T1")
        x : x points in the tabulated table T1 (with correspondents y)
        y : y points in the tabulated table T1 (with correspondents x)

    Returns:
        DDy : foward divided difference

    See:
        https://en.wikipedia.org/wiki/Divided_differences
%}
function DDy = divided_differences(n, x, y)
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
end
