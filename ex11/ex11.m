close all; clear all; clc;

scale = 0.25; 
xx = round([252 213 85 88] * scale);
xn = xx(1);
yn = xx(2);
w = xx(3);
h = xx(4);

img_path = 'cat_in_paper.jpg';

img = imresize(imread(img_path), scale);
bw_img = rgb2gray(img);
imgs = {bw_img img};
% imgs = {img};



for n = 1:numel(imgs)
    
    figure(n)
    
    img = double(imgs{n}) / 255.0;
    template = img(yn:yn+h, xn:xn+w, :);
    
    s = size(img) - size(template);
    xs = [1 s(2)];
    ys = [1 s(1)];
    

    subplot(3, 1, 1)
    hold on
    imshow(img);
    rectangle('Position', xx, 'EdgeColor', 'r', 'LineWidth', 2 );
    
    
    subplot(3, 1, 2)
    hold on
    ssd_score = by_range(img, template, xs, ys, @(x, y) ssd(x, y));
    b = max(ssd_score(:));
    [yn, xn] = find_val(ssd_score, b);
    imshow(ssd_score / b);
    rectangle('Position', [xn yn xx(3:4)], 'EdgeColor', 'r', 'LineWidth', 2 );
    title('ssd')
    fprintf('ssd diff = %f pixels\n', norm([xn yn] - xx(1:2)));
    
    subplot(3, 1, 3)
    hold on
    ncc_score = by_range(img, template, xs, ys, @(x, y) ncc(x, y));
    a = min(ncc_score(:));
    b = max(ncc_score(:));
    [yn, xn] = find_val(ncc_score, b);
    imshow((ncc_score - a) / (b - a));
    rectangle('Position', [xn yn xx(3:4)], 'EdgeColor', 'r', 'LineWidth', 2 );
    title('ncc')
    fprintf('ncc diff = %f pixels\n', norm([xn yn] - xx(1:2)));
end