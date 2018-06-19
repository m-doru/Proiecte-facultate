function ex1c()
 
a = -3;
b = 3;
fct = @(x)x.^3 - x.^2 -4*x + 4;
n_vals = [4 6 8];
fderiv = @(x)3*x.^2 - 2*x - 4;

domeniu = linspace(a,b);

vals_fderiv = fderiv(domeniu);

for n_idx = 1:numel(n_vals)
  n = n_vals(n_idx);
  h = (b-a)/n;
  vals_metRich = zeros(1,numel(domeniu));
  for idx = 1:numel(domeniu)
    vals_metRich(idx) = MetRichardson(fct, domeniu(idx), h, n, @phi);
  end
  fig1 = figure;
  plot(domeniu, abs(vals_fderiv-vals_metRich), 'r');
  title(['ex1c grafic pentru n = ', num2str(n)]);
  saveas(fig1, ['ex1c_grafic_pentru_n-', num2str(n), '.pdf'], 'pdf')
 end

end