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
    

    subplot(2, 2, 1)
    hold on
    imshow(img);
    rectangle('Position', xx, 'EdgeColor', 'r', 'LineWidth', 2 );
    
    
    subplot(2, 2, 2)
    hold on
    ssd_score = by_range(img, template, xs, ys, @(x, y) ssd(x, y));
    a = min(ssd_score(:));
    b = max(ssd_score(:));
    [yn, xn] = find_val(ssd_score, b);
%     imshow(ssd_score / b);
    imshow((ssd_score - a) / (b - a));
    rectangle('Position', [xn yn xx(3:4)], 'EdgeColor', 'r', 'LineWidth', 2 );
    title('negative ssd')
    fprintf('ssd diff = %f pixels\n', norm([xn yn] - xx(1:2)));
    
    subplot(2, 2, 3)
    hold on
    ncc_score = by_range(img, template, xs, ys, @(x, y) ncc(x, y));
    a = min(ncc_score(:));
    b = max(ncc_score(:));
    [yn, xn] = find_val(ncc_score, b);
    imshow((ncc_score - a) / (b - a));
    rectangle('Position', [xn yn xx(3:4)], 'EdgeColor', 'r', 'LineWidth', 2 );
    title('ncc')
    fprintf('ncc diff = %f pixels\n', norm([xn yn] - xx(1:2)));
    
    
    subplot(2, 2, 4)
    hold on
    
    threshold = 0.01;
    template = orientation(template, threshold);
    grad_img = orientation(img, threshold);
    
    cosScore = by_range(grad_img, template, xs, ys, @(x, y) cos_score(x, y));
    a = min(cosScore(:));
    b = max(cosScore(:));
    [yn, xn] = find_val(cosScore, b);
    imshow((cosScore - a) / (b - a));
    rectangle('Position', [xn yn xx(3:4)], 'EdgeColor', 'm', 'LineWidth', 2 );
    title('cos')
    fprintf('cos diff = %f pixels\n', norm([xn yn] - xx(1:2)));
    
    
    
end