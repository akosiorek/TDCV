function H = homography(x1, x2)
    
    if x1 == x2
        H = projective2d(eye(3));
        return
    end
    
    
   x1 = single(x1);
   x2 = single(x2);
   [H, ~, ~] = estimateGeometricTransform(x1, x2, 'projective');
end