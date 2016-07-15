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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 8, exercise 6       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%6f%
%%%%
x = a : 0.01 : b;
y = 2 / sqrt(pi) .* exp(-x.**2);

yp = polyval(coef, x);
printf('\n[ 6f ] plot!\n');
%plot(x, y, '-r;Integrand function 2/sqrt(pi)*-exp(-x^2);', 'linewidth', 10,
%    x, yp, '-k;Approx. function Pn(x);', 'linewidth', 3,
%    xm, ym, 'x;Points used by Gauss Legendre method;', 'linewidth', 5);

printf('\n-------------------------------------------------------------\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 7, exercise 1       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%1a%
%%%%
% clear
% clc
% format long

% m = 6; % Number of points
% t = [ 0.2  0.4  0.6  0.8  0.9  1.0  ];
% v = [ 0.04 0.14 0.30 0.45 0.61 0.69 ];

% initial_x = [0.5 0.5];
% sol = nl_newton_raphson(initial_x);

% a = g1(sol(1));
% b = g2(sol(2));

% printf('\n[ 1a ] a = ');
% disp(a);
% printf('[ 1b ] b = ');
% disp(b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 7, exercise 2       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printf('\n[ 2 ] Comments!\n')
%%%%
%2a%
%%%%
%{
    O ajuste polinomial é utilizado quando se quer notar um padrão entre uma
    dada sequência de pontos estudados e concluídos. O ajuste constitui de uma
    função aproximada aos pontos em questão, de tal que há um erro inerente
    (desvio local) entre um ponto estudado e o local onde a função estimada
    passa. Interpolação é utilizado quando se quer o polinômio que passa sobre
    todos os pontos.
%}
%%%%
%2b%
%%%%
%{
    O polinômio encontrado na interpolação passa por todos os pontos tabelados.
%}
%%%%
%2c%
%%%%
%{
    O polinômio encontrado no ajuste passa o mais próximo possível dos pontos
    tabelados com o menor desvio possível.
%}
%%%%
%2d%
%%%%
%{
    Ajustando um polinômio interpolador a n + 1 pontos tabelados, o desvio chega
    tão próximo a zero que iguala ao próprio polinômio interpolador.
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 7, exercise 3       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%3a%
%%%%
clear
clc
format long

m = 7;
xtemp = [13.9 37.0 67.8 79.0 85.5 93.1 99.2]; % x
ycm   = [1.04 1.18 1.29 1.35 1.28 1.21 1.06]; % y

h = (xtemp(m) - xtemp(1)) / m; % interval
xpoints = xtemp(1) : h : xtemp(m);

nf = 1;
xsolf = pol_adjust(nf, m, xtemp, ycm);
ysolf = horner(nf, xsolf, xpoints);

ns = 2;
xsols = pol_adjust(ns, m, xtemp, ycm);
ysols = horner(ns, xsols, xpoints);

printf('\n[ 3a ] y points in the adjust Pn(x), where n = 1');
disp(transpose(ysolf));
printf('\n[ 3a ] y points in the adjust Pn(x), where n = 2');
disp(transpose(ysols));

%%%%
%3b%
%%%%
n = m - 1;
inter = gregory_newton(xpoints, n, xtemp, ycm);
printf('\n[ 3b ] y points in the interpolating polinomial: ');
disp(transpose(inter));

%%%%
%3c%
%%%%
printf('\n[ 3c ] Plot!\n');
% plot(
%     xtemp, ycm, '*', 'markersize', 20,
%     xpoints, ysolf, "-r;Adjust with a Pn(x), where n = 1;", 'linewidth', 5,
%     xpoints, ysols, "-k;Adjust with a Pn(x), where n = 2;", 'linewidth', 5,
%     xpoints, inter, "-b;Polynomial Interpolation Pn(x);", 'linewidth', 5
% );

%%%%
%3d%
%%%%
printf('\n[ 3d ] Comments!\n');
%{
    Vale mais ajustar usando o ajuste polinomial de grau 2, porque é onde mais
    se adequa aos padrões dos pontos. O ajuste polinomial de grau 1 não captura
    a pequena curva dos pontos experimentais, enquanto a interpolação se torna
    visivelmente inviável (sem padrão, apenas passa por cima dos pontos).
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 7, exercise 4       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%4a%
%%%%
clear
clc
format long

m = 4;
t = [0.00 0.39 0.78 1.18];
v = [0.99 0.92 0.71 0.38];

a = [0 0;
    0 0];

b = [0 0];

for k = 1 : m
    a(1,1) = a(1,1) + t(k)^2;
    a(1,2) = a(1,2) + t(k) * cos(t(k));
    a(2, 2) = a(2, 2) + (cos(t(k)))^2;
    b(1) = b(1) + t(k) * v(k);
    b(2) = b(2) + v(k) * cos(t(k));
end
a(2,1) = a(1,2);

sol = gauss(2, [a transpose(b)]);
a = sol(1);
b = sol(2);

printf('\n[ 4a ] a = ');
disp(a);
printf('[ 4a ] b = ');
disp(b);

%%%%
%4b%
%%%%
tpoints = t(1) : 0.01 : t(m);
adjust = a .* tpoints .+ b .* cos(tpoints);
vk = a .* t .+ b .* cos(t);
deviation = abs(v .- vk);
printf('\n[ 4b ] Plot!\n');
%bar(t, deviation, "b*;Local deviations;"); 
