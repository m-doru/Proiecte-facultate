function [ x ] = GradConj( A, b )

n = size(b, 1);

x_prev = rand(size(b));
r_prev = A * x_prev - b;
v_prev = -r_prev;

for k = 0:n-1
    alfa = - dot(r_prev, v_prev)/dot(A*v_prev, v_prev);
    
    x = x_prev + alfa * v_prev;
    
    r = A*x - b;
    if ~all(r)
        return;
    end
    
    beta = dot(r, A*v_prev)/dot(A*v_prev, v_prev);
    v = beta*v_prev-r;
    
    x_prev = x;
    v_prev = v;
    r_prev = r;
end

x = x_prev;

end

