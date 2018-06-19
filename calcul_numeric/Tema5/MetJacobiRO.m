function [x, N] = MetJacobiRO(A, a, eps, p)

norma_inf = normamatrinf(A);

sigma = 2/(norma_inf*p);
[x,N] = MetJacobiR(A, a, eps, sigma);
for s = 2:p-1
    sigma = 2*s/(norma_inf*p);
    [x_crt, n_crt] = MetJacobiR(A, a, eps, sigma);
    
    if n_crt < N
        N = n_crt;
        x = x_crt;
    end
end

end