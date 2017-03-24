function [ x1 ] = MetJacobi( A, a, eps )

q = normamatrinf(eye(size(A)) - A);

if q >= 1
    disp('Metoda Jacobi nu asigura convergenta')
    return;
end

x0 = zeros(size(A,1), 1);
x1 = a;

norma_x0x1 = norm(x1-x0);

B = eye(size(A)) - A;
b = a;

k = 2;
qpow = q;
while qpow/(1-q)*norma_x0x1 > eps
    x0 = x1;
    x1 = B*x0 + b;
    qpow = qpow * q;
end

end

