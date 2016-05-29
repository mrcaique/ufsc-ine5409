## T2
Dada a seguinte equação polinomial de coeficientes complexos com grau n, determine todas as suas n raízes e respectivas multiplicidades M (em precisão `double`), com critério de parada no limite da precisão da sua máquina digital; Sugestão: `(abs(dx)+abs(R(1))<1e-12` (altere se necessário) e 120 iterações máximas. Use o método de Newton-Raphson com a correção da raiz pela multiplicidade M determinada simultaneamente:

P6(x)= (1+0i)x^6 - (5 + i)x^5 + (9.99 + 5i)x^4 - (9.97 + 9.99i)x^3 + (4.97 + 9.97i)x^2 - (0.99 + 4.97i)x + (0. + 0.99i) = 0

(polinômio fatorado (x-0.9)(x-1)3(x-1.1)(x-I), I=sqrt(-1) -> complexo)

Pede-se:

a). O seu valor inicial, otimizado por um algoritmo de busca com pelo menos uma cota limite;
b). Faça experimentos numéricos com o valor limite mínimo dos restos Rlim considerados 'numericamente pequenos' na contagem de restos nulos para computo da multiplicidade M. Imprima, em um 'texto-string', os valores testados e o valor final otimizado, que gera o menor número de iterações total para obter todas as raízes;
c). Número de iterações do Newton-Raphson na primeira chamada com cada polinômio de grau reduzido (resultante das divisões);
d). Número de iterações do Newton-Raphson na segunda chamada de refinamento no polinômio original  (sem arredondamentos nos coeficientes);
e). Critério de parada atingido após aplicar os dois processos de Newton-Raphson;
f). Numero total de iterações efetuadas;
g). as raízes refinadas convergidas e suas multiplicidades M;
h). as raízes da função roots() do próprio octave e do WolframAlpha para comparar os seus resultados;
i). imprima quais resultados tem maior exatidão e o porquê.
