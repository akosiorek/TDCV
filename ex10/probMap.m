function map = probMap(img, hist)
    
    hue = rgb2hsv(img);
    hue = hue(:, :, 3);
    index = hueindex(hue);
    map = hist(index);
    map = single(map) / max(map(:)) * 255;
end