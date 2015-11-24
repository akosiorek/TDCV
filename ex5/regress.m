function [px, py] = regress(img, x, y, trees)
   
    px = 0;
    py = 0;
    for n = 1:numel(trees)
        [ox, oy] = trees{n}.classify(img, x, y);
        px = px + ox;
        py = py + oy; 
    end
    px = px / numel(trees);
    py = py / numel(trees);
end