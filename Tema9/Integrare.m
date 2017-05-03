function I = Integrare(f, a, b, m, metoda)
  metode = {'dreptunghi','trapez', 'Simpson', 'Newton'};
  if ~any(ismember(metode, metoda))
    disp(['Metoda nu se afla printre metodele acceptate', metode]);
    return;
  end
  if strcmp(metoda,'dreptunghi')
    I = integrare_dreptunghi(f,a,b,m);
  end
  if strcmp(metoda, 'Simpson')
    I = integrare_Simpson(f,a,b,m);
  end
  if strcmp(metoda,'trapez')
    I = integrare_trapez(f,a,b,m);
  end
  if strcmp(metoda, 'Newton')
    I = integrare_Newton(f, a, b, m);
  end  
end

function I = integrare_dreptunghi(f, a, b, m)
  x = linspace(a, b, 2*m+1);
  h = (b-a)/(2*m);
  I = 0;
  for k = 1:m
    I = I + f(x(2*k));
  end
  I = I * 2 * h;
  
end

function I = integrare_trapez(f, a, b, m)
  x = linspace(a, b, m+1);
  h = (b-a)/m;
  
  I = h/2*(f(x(1)) + 2*sum(f(x(2:m))) + f(x(m+1)));
end

function I = integrare_Simpson(f, a, b, m)
  x = linspace(a,b,2*m+1);
  h = (b-a)/(2*m);
  
  I = h/3*(f(x(1)) + 4*sum(f(x(2:2:end))) + 2*sum(f(x(3:2:end))) + f(x(2*m+1)));
end

function I = integrare_Newton(f, a, b, m)
    x = linspace(a,b,m+1);
    h = (b - a)/m;
    sum = 0;
    for k=1:m
        sum = sum + f(x(k+1)) + 3 * f((2*x(k+1) + x(k))/3) + 3 * f((x(k+1) + 2*x(k))/3) + f(x(k));
    end
    I = h/8 * sum;
end