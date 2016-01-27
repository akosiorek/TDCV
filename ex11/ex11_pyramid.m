close all; clear all; clc;

init_scale = 0.125; 
scale_increments = 4;
retain_best = 0.02;
xx = [252 213 85 88];

img_path = 'cat_in_paper.jpg';

img = double(imread(img_path)) / 255.0;
bw_img = rgb2gray(img);
% imgs = {bw_img img};
imgs = {bw_img};





for n = 1:numel(imgs)
 
    img = imgs{n};
    
    [y_ssd x_ssd] = scale_pyramid(img, xx, init_scale, scale_increments, ...
        retain_best, @(x, y) ssd(x, y));
    

    [y_ncc x_ncc] = scale_pyramid(img, xx, init_scale, scale_increments, ...
        retain_best, @(x, y) ncc(x, y));
    
    
    figure(n)
    hold on
    imshow(img);
    rectangle('Position', xx, 'EdgeColor', 'r', 'LineWidth', 2 );
    rectangle('Position', [x_ssd y_ssd xx(3:end)], 'EdgeColor', 'g', 'LineWidth', 2 );
    rectangle('Position', [x_ncc y_ncc xx(3:end)], 'EdgeColor', 'b', 'LineWidth', 2 );
    legend('groundtruth', 'ssd', 'ncc');
end
    