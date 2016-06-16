format long
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Chapter 5, exercise 2	    %
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
printf('\n[ 2b ] Splines com extremos quadráticos: ')
printf('\n[ 2b ] a ='), disp(a)
printf('[ 2b ] b ='), disp(b)
printf('[ 2b ] c ='), disp(c)
printf('[ 2b ] d ='), disp(d)

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

printf('\n[ 2c ] Dado xp = 1.3, qual spline representa?')
printf('\n[ 2c ] Resp.: '), disp(with)

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

printf('\n[ 2d ] Dado x = 1.3')
printf('\n[ 2d ] O valor de y em x é: '), disp(point);

%%%%
%2e%
%%%%
%plot(a, "g;'splines no ponto a';")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chapter 5, exercise 3       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Chapter 6, exercise 1	    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%1a%
%%%%
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
printf('\n[ 1a ] Interpolação Polinomial: ')
printf('\n[ 1a ] Grau n ='), disp(n)
printf('[ 1a ] Erro máximo: '), disp(max_pol_error)

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

printf('\n[ 1b ] Maclaurin:')
printf('\n[ 1b ] Grau n ='), disp(n)
printf('[ 1b ] Erro máximo: '), disp(max_mac_error)
printf('[ 1b ] Coeficientes da série de Maclaurin: ')
mac(1:n+1)

%%%%
%1c%
%%%%
n = 3;
tchbscv = [0 383/384 0 -5/32];
y_tchbsv = remainders(n, tchbscv, range);
tcbv_error = abs(exct .- y_tchbsv);
max_tcbv_error = max(tcbv_error);
printf('\n[ 1c ] Série de Tchebyschev: ')
printf('\n[ 1c ] Grau n = '), disp(n)
printf('[ 1c ] Erro máximo: '), disp(max_tcbv_error);

%%%%
%1d%
%%%%
n = 5;
tchbscv = [0 11521/11520 0 -959/5760 0 23/2880];
y_tchbsv = remainders(n, tchbscv, range);
tcbv_error = abs(y_tchbsv .- exct);
max_tcbv_error = max(tcbv_error);
printf('\n[ 1d ] Série de Tchebyschev: ')
printf('\n[ 1d ] Grau n = '), disp(n)
printf('[ 1d ] Erro máximo = '), disp(max_tcbv_error)

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

printf('\n[ 1e ] Série racional de Padé:')
printf('\n[ 1e ] Grau n ='), disp(n_pade)
printf('[ 1e ] Grau m ='), disp(m_pade)
printf('[ 1e ] Erro máximo = '), disp(max_pade_error)

%%%%
%1f%
%%%%
%plot(points, mac_error, "g;'Erro = | T3(x) - sen(x) |, série Tchebyschev n = 3';",
%    points, tcbv_error, "k;'Erro = | abs(T5(5) - sen(x) |, série Tchebyschev n = 5';",
%    points, pade_error, "m;'Erro = | abs(R32(x) - sen(x) |, Racional de Padé m = 5';")
%grid

