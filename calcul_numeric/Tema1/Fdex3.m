function y = Fdex3( x )
    tmp = exp(x);
    y = tmp + sin(tmp - 2) * tmp;
end