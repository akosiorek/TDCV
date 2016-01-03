clear all; close all; clc;

load('data/Classifiers.mat')
faceDetector = HaarFeatures(classifiers, 1);
windowSize = faceDetector.windowSize;

img = single(rgb2gray(imread('data/faceC.jpg')));
img = imresize(img, 2);
for i = 1:4
    img = imresize(img, 0.7);

    figure(1)
    subplot(2, 1, 1)
    imshow(img/255)

    subplot(2, 1, 2)

    response = faceDetector.classify(img);
    imshow(response/max(response(:)))

    index = find(response == max(max(response)));
    [r, c] = ind2sub(size(response), index);

    subplot(2, 1, 1)
    rectangle('Position', [r(1) c(1) windowSize windowSize], 'LineWidth', 2, 'EdgeColor', 'r')
    pause
end
