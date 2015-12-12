function E = energy(R, T, A, M, m, angle_fun)
    
    M = (angle_fun(R, M)+ repmat(T', [size(M, 1), 1])) * A';
    k = 0.005;
    M = M + k * (1 - norm(R)^2);
    distances = normalize(M) - m;
    E = sum(sum(distances.^2, 2));
end