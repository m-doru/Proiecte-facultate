clear
clc
a = -1;
b = 1;
n = 4;
x = 1;
step = 0.01;
f = @(x)exp(2*x);
fd = @(x)2*exp(2*x);
noduri = 10*(n+1);
% noduri = n;

ex = 3;

pctFct = f(a:step:b);
pctSpline = zeros(1,size(a:step:b,1));
switch ex
    case 1

        i = 1;
        for j = a:step:b
            pctSpline(i) = SplineLine(f, a, b, noduri, j);
            i = i + 1;
        end

        plot(a:step:b, pctFct, 'r');
        hold on;
        plot(a:step:b, pctSpline,'g');
        hold off;
    case 2
        i = 1;
        for j = a:step:b
            pctSpline(i) = SplinePatratic(f, fd, a, b, noduri, j);
            i = i + 1;
        end

        plot(a:step:b, pctFct, 'r');
        hold on;
        plot(a:step:b, pctSpline,'g');
        hold off;
    case 3
        i = 1;
        for j = a:step:b
            pctSpline(i) = SplineCubic(f, fd, a, b, noduri, j);
            i = i + 1;
        end

        plot(a:step:b, pctFct, 'r');
        hold on;
        plot(a:step:b, pctSpline,'g');
        hold off;
end