eps = 0.00001;
p = 10;

%%
% a = [0.3;0.5;0.7];
% A = [0.2 0.01 0; 0 1 0.004; 0 0.02 1];
% x = MetJacobi(A, a, eps);
% 
% disp(x);
% %%
% A = [4 1 2; 0 3 1; 2 4 8];
% a = [2; 5; 1];
% x = MetJacobiDDL(A, a, eps);
% 
% disp(x);

%%
A = [4 2 2; 2 10 4; 2 4 6];
a = [6; 1; 4];

[x, N] = MetJacobiRO(A, a, eps, p);

disp('-----------');
disp(x);
disp('si N = ');
disp(N);

disp(A*x);

[x, N] = MetGaussSeidelRO(A, a, eps, p);
disp('-----------');
disp(x);
disp('si N = ');
disp(N);
disp(A*x);