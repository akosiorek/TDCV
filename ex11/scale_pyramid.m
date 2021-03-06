function [y, x] = scale_pyramid(img, xx, init_scale, scale_increments, score_fun, varargin)
    
    s = round([size(img, 1) - xx(4), size(img, 2) - xx(3)] * init_scale);
    XX = 1:s(2);
    YY = 1:s(1);
    [YY, XX] = meshgrid(YY, XX);
    
    increment = (1/init_scale)^(1/scale_increments);
    scale = init_scale;
    
    if nargin == 6
        template_fun = varargin{1};
    end
    
    
    for s = 0:scale_increments
        
        scaled_img = imresize(img, scale);
        xy = round(xx * scale);
        x = xy(1);
        y = xy(2);
        w = xy(3);
        h = xy(4);
        
        if exist('template_fun', 'var')
            template = template_fun(img, x, y, w, h);
        else
            template = img(y:y+h, x:x+w, :);
        end
        
        maxYX = size(scaled_img) - size(template);
        XX(XX > maxYX(2)) = maxYX(2);
        XX(XX > maxYX(1)) = maxYX(1);
        
        scores = by_points(scaled_img, template, XX, YY, score_fun);
        
        scored_points = sortrows([scores(:) XX(:) YY(:)], -1);
        N = max(round(numel(XX) / increment), 10);
        XX = round(scored_points(1:N, 2) * increment);
        YY = round(scored_points(1:N, 3) * increment);
        scale = scale * increment;
    end
    
    y = YY(1) / increment;
    x = XX(1) / increment;
end