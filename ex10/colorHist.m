function h = colorHist(img)
   
    img = rgb2hsv(img);
    hue = img(:, :, 1);
    h = zeros(256, 1);
    index = hueindex(hue);
    for n = 1:numel(index)
        h(index(n)) = h(index(n)) + 1;
    end
end