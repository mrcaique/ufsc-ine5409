format long
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 5, exercise 2       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%2b%
%%%%
x = [ 0  1 2 3];
y = [-3 -2 4 0];
n = length(x) - 1;
 
for i = 1 : n
    h(i) = x(i+1) - x(i);
end

a=[];
b=[]; 
[a  b  c  d] = splines(n,x,y,h);
printf('\n[ 2b ] Splines com extremos quadráticos: ');
printf('\n[ 2b ] a ='), disp(a);
printf('[ 2b ] b ='), disp(b);
printf('[ 2b ] c ='), disp(c);
printf('[ 2b ] d ='), disp(d);

%%%%
%2c%
%%%%
point = 1.3;
with = 0; % Spline with the 'point = 1.3'
for i = 1 : n
    if (point > x(i))
        point = i;
    end
end

printf('\n[ 2c ] Dado xp = 1.3, qual spline representa?');
printf('\n[ 2c ] Resp.: '), disp(with);

%%%%
%2d%
%%%%
point = 1.3;
with = 0;
for i = 1 : n
    if (point > y(i))
        point = i;
    end
end

printf('\n[ 2d ] Dado x = 1.3');
printf('\n[ 2d ] O valor de y em x é: '), disp(point);

%%%%
%2e%
%%%%
%plot(a, "g;'splines no ponto a';")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 5, exercise 3       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

% AB segment
n = 4;
points = 100;
h = 1 / points;

x(1) = 0;   y(1) = 0;
x(2) = 1;   y(2) = 1;
x(3) = 1.9; y(3) = 1;
x(4) = 2;   y(4) = 1;
[xx yy xp yp] = bezier(x, y, points, h);

%plot(xx, yy, '-k', "linewidth", 3,
%    xp, yp, '*', "linewidth", 5)

% BC segment
x(1) = 2;       y(1) = 1;
x(2) = 3;       y(2) = 1 + 1 * tan(-15 * pi / 180);
x(3) = 8 - 1;   y(3) = 0.2 - 1 * tan(-8 * pi / 180);
x(4) = 8;       y(4) = 0.2;
[xx yy xp yp] = bezier(x, y, points, h);

%plot(xx, yy, '-k', "linewidth", 3,
%    xp, yp, '*', "linewidth", 5)

% CD segment
x(1) = 8;           y(1) = 0.2; 
x(2) = 8 + 0.5;     y(2) = 0.2 + 0.5 * tan(-8 * pi/180);
x(3) = 10 - 0.5;    y(3) = 0.5 * tan(-05 * pi/180);
x(4) = 10;          y(4) = 0;
[xx yy xp yp] = bezier(x, y, points, h);

printf('\n[ 3 ] plot\n');
%plot(xx, yy, '-k', "linewidth", 3,
%    xp, yp, '*', "linewidth", 5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 5, exercise 4       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
%%%%
%4a%
%%%%
n = 1;
interval_a = 0;
interval_b = pi / 2;

points = 100;
middle = (interval_b - interval_a) / points;
xpoints = interval_a : middle : interval_b;
exct = sin(xpoints);

max_pol_error = 1;
while (max_pol_error > (sqrt(10) * 1e-2))
    n = n + 1;
    h = (interval_b - interval_a) / n;
    x = interval_a : h : interval_b;
    y = sin(x);
    dd = divided_differences(n, x, y);

    for i = 1 : points + 1
        yaprx(i) = gregory_newton(xpoints(i), n, x, y);
    end
    max_pol_error = max(abs(yaprx .- exct));
end

printf('\n[ 4a ] Interpolação Polinomial: ');
printf('\n[ 4a ] Grau n ='), disp(n);

%%%%
%4b%
%%%%
printf('\n[ 4b ] x = '), disp(transpose(x));
printf('[ 4b ] y = '), disp(transpose(y));
printf('[ 4b ] dd = '), disp(dd);

%%%%
%4c%
%%%%
printf('\n[ 4c ] Erro máximo entre pol e f(x): '), disp(max_pol_error);

%%%%
%4d%
%%%%
n = 2;
h = (interval_b - interval_a) / n;
x = interval_a : h : interval_b;

y = sin(x);
h_points = (x(n+1) - x(1)) / points;

x_points = x(1) : h_points : x(n+1);
exct = sin(x_points);
%dd = divided_differences(n, x, y);

for i = 1 : points + 1
    yaprx(i) = gregory_newton(x_points(i), n, x, y);
end

nwtn_error = abs(yaprx .- exct);
%printf('\n[ 4d ] Erro ='), disp(transpose(nwtn_error));

printf('\n[ 4d ] plot\n')
%plot(x, y, 'x',
%   x_points, yaprx, "r;N(x) interpolador;", "linewidth", 5,
%   x_points, exct, "k;f(x) exata;", "linewidth", 5) 
%grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 5, exercise 5       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
a = 0;
b = 1;
n = 2;
h = (b - a) / n;
x = a : h : b;
y = exp(x);

npoints = 20 * n;
hpoints = (x(n + 1) - x(1)) / npoints;
xpoints = a : hpoints : b;
exct = exp(xpoints);

% Canonical
eqs = n + 1;
for i = 1 : eqs 
      m(i, eqs) = 1; 
      for j = eqs - 1 : -1 : 1 
            m(i, j) = m(i, j + 1) * x(i); 
      end
      m(i, eqs + 1) = y(i);
end
pol = gauss(eqs, m); % Coeficients

ca_yaprx = briot_ruffini(n, pol, xpoints);
ca_max_error = max(abs(ca_yaprx .- exct));

% Gregory-Newton and Lagrange
for i = 1 : npoints + 1
    la_yaprx(i) = lagrange(xpoints(i), n, x, y);
    ng_yaprx(i) = gregory_newton(xpoints(i), n, x, y);
end

la_max_error = max(abs(la_yaprx .- exct));
ng_max_error = max(abs(ng_yaprx .- exct));

printf(strcat('\n[ 5b ] Erro máximo do interpolador de f(x)=cos(x) no ',
    ' polinômio interpolador na base canônica:')),
disp(ca_max_error);

printf(strcat('\n[ 5c ] Erro máximo do interpolador de f(x)=cos(x) na ',
    ' base dos polinômios de Lagrange:')),
disp(la_max_error);

printf(strcat('\n[ 5d ] Erro máximo do interpolador de f(x)=cos(x) na ',
    ' interpolação de Gregory-Newton com diferenças divididas ascendentes:')),
disp(ng_max_error);
%printf('\n[ 5c ] Coeficientes de Lagrange: '), disp(transpose(yaprx));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 5, exercise 6       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%6a%
%%%%
clear
a = 0;
b = pi / 2;
n = 2;
h = (b - a) / n;
x = a : h : b;
y = cos(x);

npoints = 20 * n;
hpoints = (x(n + 1) - x(1)) / npoints;
xpoints = a : hpoints : b;
exct = cos(xpoints);

for i = 1 : npoints + 1
    yaprx(i) = gregory_newton(xpoints(i), n, x, y);
end

max_error = max(abs(yaprx .- exct));
printf('\n[ 6a ] Erro máximo do interpolador de f(x)=cos(x): '),
disp(max_error);

%%%%
%6b%
%%%%
n = 1;
interval_a = 0;
interval_b = pi / 2;

points = 100;
middle = (interval_b - interval_a) / points;
xpoints = interval_a : middle : interval_b;
exct = sin(xpoints);

max_pol_error = 1;
while (max_pol_error > (sqrt(10) * 1e-6))
    n = n + 1;
    h = (interval_b - interval_a) / n;
    x = interval_a : h : interval_b;
    y = sin(x);

    for i = 1 : points + 1
        yaprx(i) = gregory_newton(xpoints(i), n, x, y);
    end
    errors = abs(yaprx .- exct);
    max_pol_error = max(errors);
end

printf('\n[ 6b ] Erro máximo: '), disp(max_pol_error);
%plot(xpoints, errors,
%    "r;Erro entre Pn(x) e f(x);",
%    "linewidth", 5);
%grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 6, exercise 1       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%1a%
%%%%
clear
n = 1;

interval_a = -1;
interval_b = 1;

points = 200;
middle = (interval_b - interval_a) / points;
range = interval_a : middle : interval_b;

exct = sin(range);

max_pol_error = 1;
while (max_pol_error > (sqrt(10) * 1e-2))
    n++;
    steps = (interval_b - interval_a) / n;
    x = interval_a : steps : interval_b;
    y = sin(x);
    for i = 1 : points + 1
        aprx(i)=gregory_newton(range(i), n, x, y);
    end
    pol_error = abs(exct .- aprx);
    max_pol_error = max(pol_error);
end
printf('\n[ 1a ] Interpolação Polinomial: ');
printf('\n[ 1a ] Grau n ='), disp(n);
printf('[ 1a ] Erro máximo: '), disp(max_pol_error);

%%%%
%1b%
%%%%
for i = 1 : 5
    ii = 2 * i;
    mac(ii - 1) = 0;
    mac(ii) = (-1) ^ (i - 1) / factorial(2*i-1);
end

n = 0;
max_mac_error = 1;
while (max_mac_error > (sqrt(10) * 1e-2))
    n += 1;
    points_mac = remainders(n, mac, range);
    mac_error = abs(points_mac .- exct);
    max_mac_error = max(mac_error);
end

printf('\n[ 1b ] Maclaurin:');
printf('\n[ 1b ] Grau n ='), disp(n);
printf('[ 1b ] Erro máximo: '), disp(max_mac_error);
printf('[ 1b ] Coeficientes da série de Maclaurin: ');
disp(mac(1:n+1));

%%%%
%1c%
%%%%
n = 3;
tchbscv = [0 383/384 0 -5/32];
y_tchbsv = remainders(n, tchbscv, range);
tcbv_error = abs(exct .- y_tchbsv);
max_tcbv_error = max(tcbv_error);
printf('\n[ 1c ] Série de Tchebyschev: ');
printf('\n[ 1c ] Grau n = '), disp(n);
printf('[ 1c ] Erro máximo: '), disp(max_tcbv_error);

%%%%
%1d%
%%%%
n = 5;
tchbscv = [0 11521/11520 0 -959/5760 0 23/2880];
y_tchbsv = remainders(n, tchbscv, range);
tcbv_error = abs(y_tchbsv .- exct);
max_tcbv_error = max(tcbv_error);
printf('\n[ 1d ] Série de Tchebyschev: ');
printf('\n[ 1d ] Grau n = '), disp(n);
printf('[ 1d ] Erro máximo = '), disp(max_tcbv_error);

%%%%
%1e%
%%%%
n_pade = 3;
m_pade = 2;
[a b] = pade(n_pade, m_pade, mac);

for k = 1 : points + 1
    num = remainders(n_pade, a, range(k));
    den = remainders(m_pade, b, range(k));
    y_pade(k) = num / den;
end

pade_error = abs(y_pade .- exct);
max_pade_error = max(pade_error);

printf('\n[ 1e ] Série racional de Padé:');
printf('\n[ 1e ] Grau n ='), disp(n_pade);
printf('[ 1e ] Grau m ='), disp(m_pade);
printf('[ 1e ] Erro máximo = '), disp(max_pade_error);

%%%%
%1f%
%%%%
%plot(points, mac_error, "g;'Erro = | T3(x) - sen(x) |, série Tchebyschev n = 3';",
%    "linewidth", 5,
%    points, tcbv_error, "k;'Erro = | abs(T5(5) - sen(x) |, série Tchebyschev n = 5';",
%    "linewidth", 5,
%    points, pade_error, "m;'Erro = | abs(R32(x) - sen(x) |, Racional de Padé m = 5';",
%    "linewidth", 5);
%grid;
