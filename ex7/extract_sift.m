function [key, feature] = extract_sift(img)
 
    [key, feature] = vl_sift(img);
    key = key(1:2, :)';
end
    