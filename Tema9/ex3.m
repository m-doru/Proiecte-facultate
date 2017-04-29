function ex3()
  a = -3;
  b = 3;
  f = @(x)x.^3-x.^2-4*x+4;
  m = 100;
  metode = {'dreptunghi', 'trapez', 'Simpson'};
  for i = 1:numel(metode)
    metoda = metode{i};
    aprox_int = Integrare(f, a, b, m, metoda);
    real_int = quad(f, a, b);
    err = abs(aprox_int - real_int);
    disp(['Eroarea pentru metoda ', metoda, ' este ', num2str(err)]);    
  end
end