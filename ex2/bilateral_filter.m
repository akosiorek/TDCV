function f = bilateral_filter(img, sigma_d, sigma_r)
    
    if mod(sigma_d, 2) == 1
        p = (3 * sigma_d - 1) / 2;
    else
        p = 3 * sigma_d / 2;
    end       
    
    f = zeros(size(img)- 2*p);
    
    for x = p+1:size(img, 1)-p
        for y = p+1:size(img, 2)-p
            f(x-p, y-p) = bilateral(img(x-p:x+p, y-p:y+p), sigma_d, sigma_r);
        end
    end
end

function h = bilateral(m, sigma_d, sigma_r)
    
    c = gaus(closeness(m), sigma_d);
    s = gaus(similarity(m), sigma_r);
    
    mult = c .* s;
    denom = sum(sum(mult));
    
    h = sum(sum(m .* mult)) / denom;
end


function c = closeness(m)
    
    x =  center(m);
    [n m] = size(m);
    
    horiz = repmat(1:m, n, 1);
    vert = repmat((1:n)', 1, m);
    
%     c = sqrt(sum(sum((horiz-x(2)).^2 + (vert-x(1)).^2))); 
    c = sqrt((horiz-x(2)).^2 + (vert-x(1)).^2); 
end

function f = similarity(m)
   c = center(m);
%    f = sqrt(sum(sum((m - m(c(1), c(2))).^2)));
   f = m - m(c(1), c(2));
end

function x = center(m)
   x =  (size(m) - 1) / 2 + 1;
end

function g = gaus(x, sigma)
    g = exp(-0.5 * (x / sigma).^2);
end