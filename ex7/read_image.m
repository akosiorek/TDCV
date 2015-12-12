function I = read_image(path)
    I = single(rgb2gray(imread(path)))/255;
end