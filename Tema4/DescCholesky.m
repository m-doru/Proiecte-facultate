function [x, L] = DescCholesky(A, b)
    if A(1,1) <= 0 
        disp('Matricea nu este pozitiv definita');
        return;
    end
    
    n = size(A, 1);
    L = zeros(size(A));
    
    L(1,1) = sqrt(A(1,1));
    L(:, 1) = 1/L(1,1)*A(:,1);
    
    for k = 2:n
        alfa = A(k,k) - sum(L(k, 1:k-1).^2);
        
        if alfa <= 0
            disp('Matricea nu este pozitiv definita');
            return;
        end
        
        L(k,k) = sqrt(alfa);
        
        for i = k:n
            L(i,k) = 1/L(k,k)*(A(i,k) - sum(L(i, 1:k-1).*L(k, 1:k-1)));
        end
    end
    
    y = SubsAsc(L, b);
    x = SubsDesc(L', y);
end