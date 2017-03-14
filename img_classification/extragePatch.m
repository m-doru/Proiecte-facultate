function patch = extragePatch(input, dim, centru)
    dim = dim / 2;
    patch = input(centru(1)-dim+1:centru(1)+dim, centru(2)-dim+1:centru(2)+dim); 
end