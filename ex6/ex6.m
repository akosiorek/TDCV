
close all, clear all, clc

run('../vlfeat-0.9.20/toolbox/vl_setup');

box_img = single(imread('box.pgm'))/255;
scene_img = single(imread('scene.pgm'))/255;

[matched_box, matched_scene] = find_matching_points(box_img, scene_img);

figure(1)
subplot(3, 1, 1)

showMatchedFeatures(box_img, scene_img, matched_box, matched_scene, 'montage');
title('all matched features')


subplot(3, 1, 2)
% [H, matched_box, matched_scene] = RANSAC(matched_box, matched_scene, 10, 25, 20000)
[H, matched_box, matched_scene] = adaptive_RANSAC(matched_box, matched_scene, 10)
showMatchedFeatures(box_img, scene_img, matched_box, matched_scene, 'montage');
title('consensus features')


subplot(3, 1, 3)
transform = projective2d(H');
scene_img = imwarp(scene_img, transform);
imshow(scene_img)
title('warped image')

