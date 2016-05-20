format long
f = [complex(1, 0) complex(-5, -1) complex(9.99, 5) ...
    complex(-9.97, -9.99), complex(4.97, 9.97), ...
    complex(-0.99, -4.97), complex(0, 0.99)];

printf("-----------------------------------------------------------\n")
printf("\tFunction f\n")
printf("-----------------------------------------------------------\n")
printf("f = "), disp(f)
printf("-----------------------------------------------------------\n")

[x m] = roots2(f);
printf("-----------------------------------------------------------\n")
printf("[ G ] f roots: "), disp(x)
printf("-----------------------------------------------------------\n")
printf("[ G ] f multiplicity: "), disp(m)
printf("-----------------------------------------------------------\n")

x = roots(f);
war = [0.9 0.999959 1.1];
wac = [complex(1, 0) complex(1.00002, -0.0000351069) ...
      complex(1.00002, 0.0000351069)];
printf("[ H ] Roots from the native function: \n"),
disp(x)
printf("-----------------------------------------------------------\n")
printf("[ H ] Roots from Wolfram Alpha: \n")
printf("Real solutions: \n")
printf("x = "), disp(war(1))
printf("x = "), disp(war(2))
printf("x = "), disp(war(3))
printf("\n")

printf("Complex solutions: \n")
printf("x = "), disp(wac(1))
printf("x = "), disp(wac(2))
printf("x = "), disp(wac(3))
printf("-----------------------------------------------------------\n")

printf("[ I ] Greater accuracy: ")
printf("Function roots2")
printf("\n")
printf("-----------------------------------------------------------\n")
