function [ x, Q, R ] = DescQR( A, b )

n = size(A, 1);

R = zeros(size(A));
Q = zeros(size(A));

R(1,1) = sqrt(sum(A(:, 1).^2));

Q(:, 1) = A(:, 1) /R(1,1);

for k = 2:n
    for j = 1:k-1
        R(j, k) = sum(A(:,k).*Q(:, j));
    end
    
    R(k,k) = sqrt(sum(A(:, k).^2) - sum(R(1:k-1, k).^2));
    
    for i = 1:n
        Q(i, k) = 1/R(k,k)*(A(i, k) - sum(R(1:k-1,k).*Q(i, 1:k-1)'));
    end
end

y = Q'*b;
x = SubsAsc(R, y);

Q

R

end

