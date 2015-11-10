function I = non_max_suppresion(mat, x0, y0)
   
    
    I = zeros(size(mat));
    [n, m] = size(mat);
    x0 = (x0 - 1) / 2;
    y0 = (y0 - 1) / 2;
    
    for i = x0+1:n-x0
        for j = y0+1:m-y0
            if  mat(i, j) ~= 0
                I(i, j) = (max(max(mat(i-x0:i+x0,j-y0:j+y0))) == mat(i, j)) * mat(i, j);
            end
        end
    end
end