## T2
Dada a seguinte equação polinomial de coeficientes complexos com grau n, determine todas as suas n raízes e respectivas multiplicidades M (em precisão `double`), com critério de parada no limite da precisão da sua máquina digital; Sugestão: `(abs(dx)+abs(R(1))<1e-12` (altere se necessário) e 120 iterações máximas. Use o método de Newton-Raphson com a correção da raiz pela multiplicidade M determinada simultaneamente:

P6(x)= (1+0i)x^6 - (5 + i)x^5 + (9.99 + 5i)x^4 - (9.97 + 9.99i)x^3 + (4.97 + 9.97i)x^2 - (0.99 + 4.97i)x + (0. + 0.99i) = 0

(polinômio fatorado (x-0.9)(x-1)3(x-1.1)(x-I), I=sqrt(-1) -> complexo)

Pede-se:

1. O seu valor inicial, otimizado por um algoritmo de busca com pelo menos uma cota limite;
2. Faça experimentos numéricos com o valor limite mínimo dos restos Rlim considerados 'numericamente pequenos' na contagem de restos nulos para computo da multiplicidade M. Imprima, em um 'texto-string', os valores testados e o valor final otimizado, que gera o menor número de iterações total para obter todas as raízes;
3. Número de iterações do Newton-Raphson na primeira chamada com cada polinômio de grau reduzido (resultante das divisões);
4. Número de iterações do Newton-Raphson na segunda chamada de refinamento no polinômio original  (sem arredondamentos nos coeficientes);
5. Critério de parada atingido após aplicar os dois processos de Newton-Raphson;
6. Número total de iterações efetuadas;
7. As raízes refinadas convergidas e suas multiplicidades M;
8. As raízes da função `roots()` do próprio Octave e do Wolfram Alpha para comparar os seus resultados;
9. Imprima quais resultados tem maior exatidão e o porquê.
