function y = Fex1( x )

tmp = double(exp(x) - 2);

y = tmp - double(cos(tmp));
    
end

