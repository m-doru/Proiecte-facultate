function [ x1, steps ] = findSolFalsPos( a0, b0, f, error )

    steps = 1;
    x1 = (b0*f(a0) - a0*f(b0))/(f(a0) - f(b0))
    x0 = x1 + error - 1;
    while abs(x1 - x0) > error && f(x1) ~= 0
        x0 = x1;
        if f(a0)*f(x0) < 0
            b0 = x0;
        else
            a0 = x0;
        end
        x1 = (b0*f(a0) - a0*f(b0))/(f(a0) - f(b0))
        steps = steps + 1;
    end

end

