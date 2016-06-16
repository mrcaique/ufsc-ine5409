function [xx yy xp yp] = bezier(x, y, points, h)
    xx = [];  yy = []; 
    xp = [];  yp = [];

    cx = 3 * (x(2) - x(1));
    bx = 3 * (x(3) - x(2)) - cx;
    ax = (x(4) - x(1)) - (cx + bx);

    cy = 3 * (y(2) - y(1));
    by = 3 * (y(3) - y(2)) - cy;
    ay = (y(4) - y(1)) - (cy + by); 

    t=0;
    for i = 1 : points + 1 
        xx3(i) = x(1) + t * (cx + t * (bx + t * ax)); 
        yy3(i) = y(1) + t * (cy + t * (by + t * ay)); 
        t = t + h;
    end

    xx = [xx xx3];
    yy = [yy yy3];
    xp = [xp x];
    yp = [yp y];
end
