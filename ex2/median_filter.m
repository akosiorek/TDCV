function f = median_filter(img, s, varargin)
%  f = MEDIAN_FILTER(img, s, varargin)
%
%  img - image to filter
%  s - filter size, either scalar or vector s.t. numel(s) == numel(size(img))

    
    if numel(s) == 1
        xSize = s;
        ySize = s;
    else
        xSize = s(1);
        ySize = s(2);
    end
    assert(mod(xSize, 2) == 1);
    assert(mod(ySize, 2) == 1);
    
%     if nargin == 3
%        shrink = varargin{1};
%     else
%        shrink = false;
%     end
    
    X = (xSize - 1) / 2;
    Y = (ySize - 1) / 2;
 
    f = zeros(size(img) - 2 * [xSize ySize]);
    
    for x = X+1:size(img, 1) - X
        for y = Y+1:size(img, 2) - Y
            f(x-X, y-Y) = median(median(img(x-X:x+X, y-Y:y+Y)));
        end
    end
end
