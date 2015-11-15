function a = harris_laplace(img, n, s0, k, alpha, t)
    
    
    [xSize, ySize] = size(img);
    corners = zeros(xSize, ySize, n);
    logs = cell(n, 2);
    response = zeros(n, 1);
    
    for l = 1:n
        [c, sigmaD, mask_size] = harris(img, l-1, s0, k, alpha, t);
        corners(:, :, l) = c;
        logs{i, 1} = flipud(fliplr(fspecial('log', mask_size, sigmaD)));
        logs{i, 2} = sigmaD;
    end
    
    
    pad = (size(logs{end}) - 1) / 2;
    img = padarray(img, pad, 0, 'both');
    
    
    final_corners = zeros(size(img));
    
    for x = 1 + pad(1) : xSize + pad(1)
        for y = 1 + pad(2) : ySize + pad(2)
            if nnz(corners(x-pad(1), y-pad(2), :))
               r = response(img, x, y, logs);
                
                
            end
        end
    end
    
        
    
    
end


function r = response(img, x, y, logs)
   
    r = zeros(logs, 1);
    for k = 1:numel(logs)
        log = logs{i, 1};;
        sigmaD = logs{i, 2};
        pad = (size(log) - 1) / 2;
        r(i) = sigmaD^2 * ...
            sum(sum(img(x-pad(1):x+pad(1), y-pad(2):y+pad(2)) .* log));
    end
end