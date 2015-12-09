

run('../vlfeat-0.9.20/toolbox/vl_setup');

box_img = single(imread('box.pgm'))/255;
scene_img = single(imread('scene.pgm'))/255;

imshow(box_img);

[matched_box, matched_scene] = find_matching_points(box_img, scene_img);

figure(1)
subplot(2, 1, 1)

showMatchedFeatures(box_img, scene_img, matched_box, matched_scene, 'montage');
title('all matched features')
