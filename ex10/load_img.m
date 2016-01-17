function img = load_img(num, varargin)

    scale = 1;
    if nargin == 2
        scale = varargin{1}
    end

    num = num + 140;
    path = sprintf('sequence/2043_%06d.jpeg', num);
    img = imresize(imread(path), scale);
%     img = single(img) / 255;
 end