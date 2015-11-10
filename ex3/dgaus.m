function dg = dgaus(sigma)
   
    g = gaus2d(sigma) * -sigma^-2; 
    x = (size(g, 1) - 1) / 2;
    y = (size(g, 2) - 1) / 2;
    dx = g .* repmat(-x:x, [2*x+1 1]);
    dy = g .* repmat((-y:y)', [1 2*y+1]);
    dg = {dx dy};
end