clear all
date;
%urmarim algoritmul Runge - Kutta de ordinul 4
h=0.02; %pasul discretizarii
t(1)=0; %initializare variabilei temporale
y(:,1) = [teta0; v0]; %impunem datele initiale sub forma
%unui vector coloana
teta(1) = teta0; %initializam necunoscutele sistemului
v(1) = v0;
cond = 1;
i=1; %initializam contorul
x(1) = 0; %coordonatele punctului P(t)
z(1) = 0; %la momentul initial
while cond == 1
K1 = h*fsist(t(i), y(:,i));
K2 = h*fsist(t(i)+h/2,y(:,i)+K1/2);
K3 = h*fsist(t(i)+h/2,y(:,i)+K2/2);
K4 = h*fsist(t(i)+h,y(:,i)+K3);
y(:,i+1) = y(:,i) + 1/6*(K1+ 2*K2 + 2*K3 +K4);
teta(i+1) = y(1,i+1); % extragem primul element din y
v(i+1)=y(2,i+1); % extragem elementul al doilea din y
x(i+1)=x(i)+...
1/2*(v(i+1)*cos(teta(i+1))+v(i)*cos(teta(i)))*h;
z(i+1)=z(i) +...
1/2*(v(i+1)*sin(teta(i+1))+v(i)*sin(teta(i)))*h;
if z(i+1) < 0
cond = 0;
end %ne oprim daca cota punctului devine negativa
t(i+1) = t(i) + h;
i=i+1;
end
plot(x,z,'Linewidth',3)
xlabel('x')
ylabel('z')
grid on
title('Traiectoria punctului P(t)')
% Animam miscarea punctului
for i = 1:length(t)
plot(x(i), z(i),'o','MarkerFaceColor','g')
hold on
plot(min(x),min(z))%fixam chenarul figurii
plot(max(x),max(z))
axis equal
grid on
M(i) = getframe;
end
movie(M,1,length(t)/3)