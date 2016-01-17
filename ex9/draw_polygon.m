function draw_polygon(x, varargin)
   
    colour = 0;
    if nargin == 2
        colour = varargin{1};
    end
    
    patch(x(:, 2), x(:, 1), colour, 'FaceColor', 'none', 'LineWidth', 2)
end