function E = energy(R, T, A, M, m)
    
    R = rotation_euler(R);
    M = (M * R' + repmat(T', [size(M, 1), 1])) * A';
    distances = normalize(M) - m;
    E = sum(sum(distances.^2, 2));
end