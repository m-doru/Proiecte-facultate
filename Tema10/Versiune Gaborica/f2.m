function [ y ] = f2( x, t )
    A = [1, 2; 2, 1];
    b = [1; 2];
    A * x
    y = A * x + b;
end

