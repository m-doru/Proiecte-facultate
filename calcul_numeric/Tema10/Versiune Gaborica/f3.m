function [ Y ] = f3( t, X )
    A = [1 1 1; -2 -1 2; 4 1 4];
    b = [0; 0; 0];
    Y = A*X + b;
end

