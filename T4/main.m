clear
clc
format long

% Function handler
% see: https://www.gnu.org/software/octave/doc/v4.0.1/Function-Handles.html
func = @exp;
const = 2 / sqrt(pi);

x = 1;
a = 0;
b = 1;

exct = erf(x);

%%%%
%6a%
%%%%
% Trapezium method
%{
    Minimum estimated 'n' from the 
    estimated error formula.
    
    Err = (max|f''(x)|_{xE[a, b]} * h^(2) * (b - a)) / 12
        Err = 10^(-6)
    
    f(x) = erf(x)
    f''(x) = (4 * e^(-x^(2)) * x) / sqrt(pi)
        f''(0) = 0;
        f''(1) ~= -0.830215
        max|f''(x)|_{[xE[a, b]]} = max|erf''(x)|_{[xE[0, 1]]}
            = max(0, 0.830215) = 0.830215
        
    h = sqrt((10^(-6) * 12) / 0.830215)
        h ~= 0.00380185 
    
    h = (b - a) / n
    n = (b - a) / h
        n = (1 - 0) / 0.00380185
        n ~= 263.0298407543
        n = 264
        for the next power of 2:
            n = 512 = 2^9
%}
n = 512;

tn = trapezium(n, a, b, func);
tn = tn * const;
tnn = trapezium(2 * n, a, b, func);
tnn = tnn * const;
exct_error = abs(tn - exct);
max_est_error = abs(tn - tnn);

printf('\n[ 6 ] Function erf(x)');
printf('\n[ 6a ] n = ');
disp(n);
printf('[ 6a ] Exact value of erf(x), where x = 1: ');
disp(exct);
printf('[ 6a ] Approximated value from trapezium method (tn): ');
disp(tn);
printf('[ 6a ] Approximated value from trapezium method (tnn): ');
disp(tnn);
printf('[ 6a ] maximum exact error (abs(tn - exct)): ');
disp(exct_error);
printf('[ 6a ] maximum estimated error (abs(tn - tnn)): ');
disp(max_est_error);

%%%%
%6b%
%%%%
% Simpson's method
%{
    Minimum n estimated from the error formula
    
    Err = (h^4 * (b - a) * max|f''''(x)|_{[xE[a, b]]}) / 180
        Err = 10^(-6)
    
    f(x) = erf(x)
    f''''(x) = (-8 * e^(-x^(2)) * x * (2x^(2) - 3)) / sqrt(pi)
        f''(0) = 0;
        f''(1) ~= 1.66043
        
        max|f''''(x)|[xE[a, b]] = max|erf''''(x)|[xE[0, 1]] 
            = max(0, 1.66043) = 1.66043
        
    h = sqrt((10^(-6) * 180) / 1.66043, 4)
        h ~= 0.1020382
    
    h = (b - a) / n
    n = (b - a) / h
        n = (1 - 0) / 0.1020382
        n ~= 9.8002512784
        n = 10 (simpson's method must be an even number)
        for the next power of 2:
            n = 16
%}
n = 10;

sn = simpson(n, a, b, func);
sn = sn * const;
snn = simpson(2 * n, a, b, func);
snn = snn * const;
exct_error = abs(sn - exct);
max_est_error = abs(snn - sn);

printf('\n[ 6b ] n = ');
disp(n);
printf('[ 6b ] Exact value of erf(x), where x = 1: ');
disp(exct);
printf('[ 6b ] Approximated value from Simpson method (sn): ');
disp(sn);
printf('[ 6b ] Approximated value from Simpson method (snn): ');
disp(snn);
printf('[ 6b ] maximum exact error (abs(sn - exct)): ');
disp(exct_error);
printf('[ 6b ] maximum estimated error (abs(sn - snn)): ');
disp(max_est_error);

%%%%
%6c%
%%%%
% Gauss-Legendre's method
%{
    Error formula:
        err =< (b-a)^(2m - 1) * (m!^4 / ((2m + 1) * [(2 * m)!]^3))
            * max|f^(2m)(x)|_{[xE[a, b]]})
    
    with m = 1
        err = 0.0345923
    with m = 2
        err = 0.000384359
    with m = 3
        err = 1.64725e-6
    with m = 4
        err = 1.08323e-7
    
%}
m = 4; % Number of points
[gm, coef, xm, ym] = gauss_legendre(m, a, b, func);
gm = gm * const;
[gmm, ~, ~, ~] = gauss_legendre(m + 1, a, b, func);
gmm = gmm * const;
max_est_error = abs(gmm - gm);
exct_error = abs(gm - exct);

printf('\n[ 6c ] m = ');
disp(m);
printf('[ 6c ] Exact value of erf(x), where x = 1: ');
disp(exct);
printf('[ 6c ] Approximated value from Gauss-Legendre method (gm): ');
disp(gm);
printf('[ 6c ] Approximated value from Gauss-Legendre method (gmm): ');
disp(gmm);
printf('[ 6c ] maximum exact error (abs(gm - exct)): ');
disp(exct_error);
printf('[ 6c ] maximum estimated error (abs(gm - gmm)): ');
disp(max_est_error);

%%%%
%6d%
%%%%
printf('\n[ 6d ] The %d coeficients of the interpolating polynomial Pn(x):', m);
disp(transpose(coef));

%%%%
%6e%
%%%%
% Derivates / Integrals / Transforms
% See: https://www.gnu.org/software/octave/doc/v4.0.1/Derivatives-_002f-Integrals-_002f-Transforms.html

% Coeficients of the integral of the polynomial
% whose coefficients are represented by coef
% [1 0 1] == x^2 + 1
integral = polyint(coef);
% Evaluate the polynomial "integral" at the specified values of a or b.
area = polyval(integral, b) - polyval(integral, a); 
printf('\n[ 6e ] Integral of the polynomial Pn(x): ');
disp(area);

%%%%
%6e%
%%%%
x = a : 0.01 : b;
y = erf(x);

yp = polyval(integral, x);
printf('\n[ 6f ] Plot!\n')
%plot(x, y, '-r;Exact function erf(x);', 'linewidth', 10,
%    x, yp, '-k;Approx. function Pn(x);', 'linewidth', 3,
%    xm, ym, 'x;Points used by Gauss Legendre method;', 'linewidth', 5);
