function f = fsist(t,y)
date;
f=zeros(2,1);
f = [-g*cos(y(1))./y(2); -g*k^2*y(2).^2-g*sin(y(1))];
% fsist(t,x) defineste functia f(t,x) din ec. dif.
% y'(t) = f(t,y)
% y are doua componente y(1) = teta, y(2) = v
% deasemenea, f este un vector cu doua componente