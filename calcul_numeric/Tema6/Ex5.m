n = 20;
A = zeros(n,n);
b = zeros(n,1);
for i = 1:n
    A(i,i) = 2;
    b(i,1) = i;
end

for i = 1:n-1
    A(i,i+1) = 1;
    A(i+1,i) = 1;
end

eps = 10^(-10);
[x,N] = GradConj2(A, b, eps);

disp(x);
disp(N);
