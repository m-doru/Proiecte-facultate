function [c, steps] = findSolBisect(left, right, f, k)
    c = (left + right)/2;
    cprev = c - 1;
    steps = 1;
    if k >= 0
        for i = 1:k
            leftVal = f(left);
            centerVal = f(c);
            if leftVal*centerVal == 0
                break;
            else
                if leftVal*centerVal < 0
                    right = c;
                else
                    left = c;
                end
            end
            c = (left + right)/2;
            steps = steps + 1;
        end
    else
        while abs(c - cprev) > 10^(-5)
            leftVal = f(left);
            centerVal = f(c);
            if leftVal*centerVal == 0
                break;
            else
                if leftVal*centerVal < 0
                    right = c;
                else
                    left = c;
                end
            end
            cprev = c;
            c = (double(left) + double(right))/2;
            steps = steps + 1;
        end
    end
end