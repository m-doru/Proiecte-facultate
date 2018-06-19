function [ y, steps ] = findSolNR( a, b, f, fd, x0, eps )

    x1 = x0 - f(x0)/fd(x0);
    steps = 1;
    
    while (x1 - x0) > eps
        x0 = x1;
        x1 = x0 - f(x0)/fd(x0);
        steps = steps + 1;
    end
    y = x1;
end

