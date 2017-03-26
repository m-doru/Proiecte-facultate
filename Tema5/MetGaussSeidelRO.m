function [x, N] = MetGaussSeidelRO(A, a, eps, p)

sigma = 2/p;
[x,N] = MetGaussSeidelR(A, a, eps, sigma);
for s = 2:p-1
    sigma = 2*s/p;
    [x_crt, n_crt] = MetGaussSeidelR(A, a, eps, sigma);
    
    if n_crt < N
        N = n_crt;
        x = x_crt;
    end
end

end