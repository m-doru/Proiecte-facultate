function [ Y ] = f2( t, X )
    A = [1 2; 2 1];
    b = [1; 2];
    Y = A*X + b;
end

