format long
f = [complex(1, 0) complex(-5, -1) complex(9.99, 5) ...
    complex(-9.97, -9.99), complex(4.97, 9.97), ...
    complex(-0.99, -4.97), complex(0, 0.99)];

% printf("-----------------------------------------------------------\n")
% printf("\tFunction f\n")
% printf("-----------------------------------------------------------\n")
% printf("f = "), disp(f)
% printf("-----------------------------------------------------------\n")

printf("-----------------------------------------------------------\n")
printf("[ B ] Experiment:\n")
printf(">>> With r_lim = 1e-1, has two roots with multiplicity four each. ")
printf("However, the function has six roots. \n\n")
printf(">>> With r_lim = 1e-2, same problem, with seven roots.\n\n")
printf(">>> With r_lim = 1e-3 has correct number of roots, but less accurate.\n\n")
printf(">>> With r_lim = 1e-4 is more accurate, however, has more iterations and ")
printf("spent more time. The process with this r_lim can be seen below.\n\n")
printf("-----------------------------------------------------------\n")

[x m] = roots2(f);
printf("-----------------------------------------------------------\n")
printf("[ G ] f roots: "), disp(x)
printf("\n[ G ] f multiplicity: "), disp(m)
printf("\n-----------------------------------------------------------\n")

x = roots(f);
war = [0.9 0.999959 1.1];
wac = [complex(1, 0) complex(1.00002, -0.0000351069) ...
      complex(1.00002, 0.0000351069)];
printf("[ H ] Roots from the native function: \n"),
disp(x)

printf("\n[ H ] Roots from Wolfram Alpha: \n")
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
printf("Function roots2.\n")
printf(
    strcat("As can be seen, the roots2 function shows 13 decimal places, ",
    "meanwhile, Wolfram Alpha shows 5 decimal places and the native ",
    "function roots shows 4 decimal places.\n\n")
)

printf(
    strcat("A point to consider is the roots2 function considers the multiplicity",
    " which ends up being as determinant factor to find the roots. ",
    " Other functions not considers the multiplicity.")
)
printf("\n")
printf("-----------------------------------------------------------\n")
