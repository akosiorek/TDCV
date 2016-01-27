function O = orientation(img, threshold)
   
    gx = [1 0 -1; 1 0 -1; 1 0 -1];
    gy = [1 1 1; 0 0 0; -1 -1 -1];
    
    Os = zeros(size(img));
    ms = zeros(size(img));
    
    g = gaus2d(1);
    
    for z = 1:size(img, 3)
%         channel = conv2(img(:, :, z), g, 'same');
        channel = img(:, :, z);
        gx = conv2(channel, gx, 'same');
        gy = conv2(channel, gy, 'same');

        Os(:, :, z) = atan2(gy, gx);
        ms(:, :, z) = gx.^2 + gy.^2;
    end
    
    [max_magnitude, max_arg] = max(sqrt(ms), [], 3);
    index = cat(3, max_arg==1, max_arg==2, max_arg==3);
    
    O = reshape(Os(index), [size(Os, 1) size(Os, 2)]);
    O(max_magnitude < threshold) = nan;
end