function ex1b()
 
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
    fig = figure;
    deriv = plot(domeniu, vals_fderiv, 'r');
    set(deriv, 'linewidth', 3);
    hold on;
    rich = plot(domeniu, vals_metRich, 'b');
    set(rich, 'linewidth', 1.5);
    hold off;
    title(['ex1b - graficul pentru n = ', num2str(n)]);
    saveas(fig, ['ex1b - graficul pentru n = ', num2str(n), '.pdf'], 'pdf');
   end
 
end
