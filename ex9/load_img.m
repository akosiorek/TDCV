 function img = load_img(num, scale)
    path = sprintf('seq/im%03d.pgm', num);
    img = imresize(imread(path), scale);
    img = single(img) / 255;
 end