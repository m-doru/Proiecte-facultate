function x = GaussFaraPivot(A, b)
    n = size(A, 1);
    Aext = [A b];
    
    for k = 1:(n-1)
        %obtinem indecsii corespunzatori valorilor diferite de 0
        z_idx = find(Aext(:, k) ~= 0);
        %obtinem indecsii care sunt >= k
        idx = find(z_idx >= k);
        %obtinem pe cel mai mic
        p = z_idx(idx(1));
        
        lp = Aext(p, :);
        Aext(p, :) = Aext(k, :);
        Aext(k, :) = lp;
        
        for l = k+1:n
            m = Aext(l, k)/Aext(k,k);
            
            Aext(l, k:n+1)=Aext(l, k:n+1) - m.*Aext(k, k:n+1);
        end
        
    end
    
    if Aext(n, n) == 0
        disp('Sistem incompatibil');
        return;
    end
    
    x = SubsDesc(Aext(1:n, 1:n), Aext(:, n+1));
end