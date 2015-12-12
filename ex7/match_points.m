function [x1, x2] = match_points(k1, k2, d1, d2)
    
    [matches, scores] = vl_ubcmatch(d1, d2);
    x1 = k1(1:2, matches(1, :))';
    x2 = k2(1:2, matches(2, :))';    
end