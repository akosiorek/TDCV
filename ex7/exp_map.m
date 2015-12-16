function R = exp_map(R)
      
   theta = norm(R);
    if theta < sqrt(eps)
        R = eye(3);
        return
    end
    
    O = zeros(3);
    O(1, 2) = -R(3);
    O(1, 3) = R(2);
    O(2, 1) = R(3);
    O(2, 3) = -R(1);
    O(3, 1) = -R(2);
    O(3, 2) = R(1);
    
    R = eye(3) + sin(theta) / theta * O + (1 - cos(theta)) / theta^2 * O^2;
end