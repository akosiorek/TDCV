function [matched1, matched2] = find_matching_points(img1, img2)
   
    [key1, desc1] = vl_sift(img1);
    [key2, desc2] = vl_sift(img2);
    [matches, scores] = vl_ubcmatch(desc1, desc2);
    
    [matched1, matched2] = match_points(key1, key2, matches);   
end

function [x1, x2] = match_points(f1, f2, matches)
   
    x1 = f1(1:2, matches(1, :))';
    x2 = f2(1:2, matches(2, :))';    
end