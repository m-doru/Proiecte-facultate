'Euler'
[t, x] = Euler(@f, 0, 2, 0.5, 10)
'Taylor II'
[t, x] = TaylorII(@f, @df, 0, 2, 0.5, 10)
'Taylor IV'
[t, x] = TaylorIV(@f, @df, @d2f, @d3f, 0, 2, 0.5, 10)
'Euler Modificat'
[t, x] = EulerMod(@f, 0, 2, 0.5, 10)
'Heun'
[t, x] = Heun(@f, 0, 2, 0.5, 10)
'Runge Kutta'
[t, x] = RungeKutta(@f, 0, 2, 0.5, 10)