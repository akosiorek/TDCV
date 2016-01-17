close all, clear all, clc

x = [506 308 57 47]; % x y width height

img = load_img(0);
patch = img(x(2):x(2)+x(4), x(1):x(1)+x(3), :);

hist = colorHist(patch);
map = probMap(patch, hist);


figure(1)
subplot(2, 1, 1)
bar(hist);
xlim([0 256])

subplot(2, 1, 2)
imshow(map/255)