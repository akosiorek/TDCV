function corners = harris(img, n, s0, k, alpha, t)
%   h = HARRIS(img, n, s0, k, alpha, t)
%   img - input image
%   n - scale level
%   s0 - initial scale value
%   k - scale step
%   alpha - constant factor
%   t - threshold for the Harris response R
%
%
    sigmaI = s0;
    dx = [-1 0 1; -1 0 1; -1 0 1];
    dy = dx';
    
    Idx = conv2(img, dx, 'same');
    Idy = conv2(img, dy, 'same');

    [xSize, ySize] = size(img);
    scaleR = zeros(xSize, ySize, n);
    
    for i = 1:n
        sigmaI = k * sigmaI;
        sigmaD = 0.7 * sigmaI;
        
        % 1. Gaussian-smoothed derivatives at each pixel        
        g = gaus2d(sigmaD);
        Ix = conv2(Idx, g, 'same');
        Iy = conv2(Idy, g, 'same');

        % 2. 2nd moment matrix
        g = gaus2d(sigmaI);
        Ixx = sigmaD^2 * conv2(Ix .* Ix, g, 'same');
        Ixy = sigmaD^2 * conv2(Ix .* Iy, g, 'same');
        Iyy = sigmaD^2 * conv2(Iy .* Iy, g, 'same');

        detM = Ixx .* Iyy - Ixy.^2;
        traceM = Ixx + Iyy;
        R = detM - alpha * traceM.^2;
        
        R(find(R<t)) = 0;
        scaleR(:, :, i) = non_max_suppresion(R, 3, 3);


        maxR = max(max(R));
        minR = min(min(R));
        numC = nnz(scaleR(:, :, i));        
        fprintf('sigmaI = %.2f, maxR = %.2f, minR = %.2f, num corners = %d\n', sigmaI, maxR, minR, numC);
    end
    
    
    corners = zeros(size(img));
    
    for i = 1:xSize
        for j = 1:ySize
            if nnz(scaleR(i, j, :))
                corners(i, j) = find(max(scaleR(i, j, :)) == scaleR(i, j, :));
            end
        end
    end
    
%     corners = s0 * k .^ corners;
    nnz(corners)
     
end
