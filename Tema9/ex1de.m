function ex1de()
a = -3;
b = 3;
fct = @(x)x.^3 - x.^2 -4*x + 4;
n_vals = [4 6 8];
fderiv = @(x)3*x.^2 - 2*x - 4;
fderiv2 = @(x)6*x-2;

domeniu = linspace(a,b);

vals_fderiv = fderiv(domeniu);
vals_fderiv2 = fderiv2(domeniu);

for n_idx = 1:numel(n_vals)
  n = n_vals(n_idx);
  h = (b-a)/n;
  vals_metRich = zeros(1,numel(domeniu));
  for idx = 1:numel(domeniu)
    vals_metRich(idx) = MetRichardson(fct, domeniu(idx), h, n-1, @phi2);
  end
  figure;
  plot(domeniu, vals_metRich, 'b');
  title(['grafic metRich pentru n = ', num2str(n)]);
  figure;
  plot(domeniu, abs(vals_fderiv2-vals_metRich), 'r');
  title(['grafic de eroare pentru n = ', num2str(n)]);
 end
end