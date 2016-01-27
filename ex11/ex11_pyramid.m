close all; clear all; clc;

init_scale = 0.25; 
scale_increments = 2;
xx = [252 213 85 88];

img_path = 'cat_in_paper.jpg';

img = double(imread(img_path)) / 255.0;
bw_img = rgb2gray(img);
imgs = {bw_img img};
% imgs = {bw_img};
% imgs = {img};


for n = 1:numel(imgs)
 
    img = imgs{n};
    
    [y_ssd x_ssd] = scale_pyramid(img, xx, init_scale, scale_increments, ...
        @(x, y) ssd(x, y));
    

    [y_ncc x_ncc] = scale_pyramid(img, xx, init_scale, scale_increments, ...
        @(x, y) ncc(x, y));
    
    threshold = 0.01;
    grad_img = orientation(img, threshold);
    template_fun = @(img, x, y, w, h) gradient_template(img, x, y, w, h, threshold);
    [y_cos x_cos] = scale_pyramid(grad_img, xx, init_scale, scale_increments, ...
        @(x, y) cos_score(x, y), template_fun);
    
    
    figure(n)
    hold on
    imshow(img);
    rectangle('Position', xx, 'EdgeColor', 'r', 'LineWidth', 2 );
    rectangle('Position', [x_ssd y_ssd xx(3:end)], 'EdgeColor', 'g', 'LineWidth', 2 );
    rectangle('Position', [x_ncc y_ncc xx(3:end)], 'EdgeColor', 'c', 'LineWidth', 2 );
    rectangle('Position', [x_cos y_cos xx(3:end)], 'EdgeColor', 'y', 'LineWidth', 2 );
%     legend('groundtruth', 'ssd', 'ncc', 'cos');
end
    