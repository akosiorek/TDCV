function [y, x] = find_val(img, val)
    [y, x] = ind2sub(size(img), find(img == val));
end