function [corners, varargout] = harris(img, n, s0, k, alpha, t)
%   h = HARRIS(img, n, s0, k, alpha, t)
%   img - input image
%   n - scale level
%   s0 - initial scale value
%   k - scale step
%   alpha - constant factor
%   t - threshold for the Harris response R
%
%

    dx = [-1 0 1; -1 0 1; -1 0 1];
    dy = dx';
    
    Idx = conv2(img, dx, 'same');
    Idy = conv2(img, dy, 'same');
    
    sigmaI = k^n * s0;
    sigmaD = 0.7 * sigmaI;

    % 1. Gaussian-smoothed derivatives at each pixel        
    gD = gaus2d(sigmaD);
    Ix = conv2(Idx, gD, 'same');
    Iy = conv2(Idy, gD, 'same');

    % 2. 2nd moment matrix
    gI = gaus2d(sigmaI);
    Ixx = sigmaD^2 * conv2(Ix .* Ix, gI, 'same');
    Ixy = sigmaD^2 * conv2(Ix .* Iy, gI, 'same');
    Iyy = sigmaD^2 * conv2(Iy .* Iy, gI, 'same');

    detM = Ixx .* Iyy - Ixy.^2;
    traceM = Ixx + Iyy;
    R = detM - alpha * traceM.^2;

    R(find(R<t)) = 0;
    corners = non_max_suppresion(R, 3, 3);
    varargout{1} = sigmaD;
    varargout{2} = size(gD);

%     maxR = max(max(R))
%     minR = min(min(R));
%     numC = nnz(corners);        
%     fprintf('sigmaI = %.2f, maxR = %.2f, minR = %.2f, num corners = %d\n', sigmaI, maxR, minR, numC);
    
     
end
