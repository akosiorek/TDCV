function p = rotation_quaternion(R, p)
   
%     size(p)
    p = padarray(p', [1 0], 0, 'pre'); % to quaternion
    q = R;
    q(2:end) = -q(2:end); % conjugate quaternion
%     p = multiply(q, multiply(R, p));
    p = quatmultiply(quatmultiply(R', p'), q')';
    p = p(2:end, :)';    
%     size(p)
end


function w = multiply(q, p)
   
    w = zeros(size(p));
    w(1, :) = q(1, :) * p(1, :) - q(2:end, :)' * p(2:end, :);
    w(2, :) = q(1, :) * p(2, :) + q(2, :) * p(1, :) - q(3, :) * p(4, :) + q(4, :) * p(3, :);
    w(3, :) = q(1, :) * p(3, :) + q(2, :) * p(4, :) + q(3, :) * p(1, :) - q(4, :) * p(2, :);
    w(4, :) = q(1, :) * p(4, :) - q(2, :) * p(3, :) + q(3, :) * p(2, :) + q(4, :) * p(1, :);
    
    
end