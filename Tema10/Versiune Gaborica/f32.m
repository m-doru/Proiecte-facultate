function [ y ] = f32( x )
    y = (-2).*(exp(1).^(-2.*x)) - exp(1).^(-x) + 2 .* (exp(1).^(2*x));
end

