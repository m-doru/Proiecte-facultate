function [ x, N ] = GradConj2( A, b, eps )

n = size(b, 1);

x_prev = rand(size(b));
r_prev = A * x_prev - b;
v_prev = -r_prev;
N = 0;

while 1
    alfa = -dot(r_prev, v_prev)/dot(A*v_prev, v_prev);
    
    x = x_prev + alfa * v_prev;
    
    r = A*x - b;
    if ~all(r)
        return;
    end
    
    beta = dot(r, A*v_prev)/dot(A*v_prev, v_prev);
    v = beta*v_prev-r;
    
    if norm(x - x_prev) < eps
        break;
    end
    
    
    x_prev = x;
    v_prev = v;
    r_prev = r;
    N = N + 1;
end

x = x_prev;

end

