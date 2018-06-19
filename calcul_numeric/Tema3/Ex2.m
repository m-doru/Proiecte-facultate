A = [1 -3 3; 3 -5 3; 6 -6 4];

B = A'*A;

lambdas = eigs(B);

rez_a = max(sqrt(lambdas));

disp(rez_a);

rez_b = max(sqrt(lambdas)) / min(sqrt(lambdas));

disp(rez_b);