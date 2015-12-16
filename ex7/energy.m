function E = energy(R, T, A, M, m, angle_fun)
    
    M = (M * angle_fun(R)' + repmat(T', [size(M, 1), 1])) * A';
%     M = (angle_fun(R, M) + repmat(T', [size(M, 1), 1])) * A';
    
    distances = normalize(M) - m;
    E = sum(sum(distances.^2));
%     k = 1e0;
%     E = E + k * (1 - norm(R))^2;
%     norm(R)
end
