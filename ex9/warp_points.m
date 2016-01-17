function x = warp_points(x, H)
   
    x = padarray(x, [0 1], 1, 'post');
    x = x * H.T;
    x = x(:, 1:2) ./ repmat(x(:, 3), [1 2]);
end