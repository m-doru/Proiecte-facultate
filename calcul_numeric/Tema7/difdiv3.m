function rez = difdiv3(x1,x2,x3, f)
    rez = (difdiv(x2,x3,f)-difdiv(x1,x2,f))/(x3-x1);
end