A = [10 7 8 7; 7 5 6 5; 8 6 10 9; 7 5 9 10];

b = [32; 23; 33; 31];

%a)
x = A\b;

disp('a)');
disp(x);

%b)
b_perturbat = [32.1;22.9;33.1;30.9];

x_perturbat = A\b_perturbat;

disp('b)');
disp(x_perturbat);

%c)
A_perturbat = [10 7 8.1 7.2; 7.08 5.04 6 5; 8 5.98 9.89 9; 6.99 4.99 9 9.98];

x_perturbat_de_a = A_perturbat\b;

disp('c)');
disp(x_perturbat_de_a);
% observatie: x-ul deviaza mai mult la perturbatii ale lui A decat al lui b
%d)
disp('d)');
kinf = normamatrinf(A)*normamatrinf(inv(A));

disp(kinf);

rapb = normamatrinf((b_perturbat-b))/normamatrinf(b);
rapx = normamatrinf((x_perturbat-x))/normamatrinf(x);

disp(rapb);
disp(rapx);

disp('---------');

disp(rapx);
disp(kinf * rapb);

disp('---------');


% e)

AA = A'*A;
val_proprii = eigs(AA);
k2 = sqrt(min(val_proprii)/max(val_proprii));

disp(k2);


