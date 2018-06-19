function [ x1, step ] = findSolSecanta( x0, x1, f, admissibleError )
    step = 1;
    while abs(x1 - x0) > admissibleError
        x2 = (x1 * f(x0) - x0 * f(x1))/(f(x0) - f(x1));
        x0 = x1;
        x1 = x2;
        step = step + 1;
    end
end

