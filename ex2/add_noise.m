function f = add_noise(img, p, type)
    
    
    if strcmp(type, 'pepper')
        p = p / 2;
        pepper_inds = rand(size(img)) < p;
        salt_inds = rand(size(img)) > (1 - p);
        f = img;
        f(pepper_inds) = 1;
        f(salt_inds) = 0;
    elseif strcmp(type, 'gaus')
        f = img + p * randn(size(img));
        f(f > 1) = 1;
        f(f < 0) = 0;
    end
end