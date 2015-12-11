function H = DLT(X1, X2)
% H = DLT(X1, X2)
%
%   X1, X2 - matrices with points from two different images, such that
%            points are stored as rows and X1(i, :) ~ X2(i, :)
%
%
    
    N = size(X1, 1);
    assert(N == size(X2, 1))
    assert(N >= 4)
    
    T = normalization_matrix(X1);
    U = normalization_matrix(X2);
    
    X1 = X1 * T';
    X2 = X2 * U';
    
    A = zeros(2 * N, 9);
    
    for n = 1:N
        A(2*n - 1, 4:6) = - X1(n, 3) * X2(n, :);
        A(2*n - 1, 7:9) = X1(n, 2) * X2(n, :);
        A(2*n, 1:3) = X1(n, 3) * X2(n, :);
        A(2*n, 7:9) = - X1(n, 1) * X2(n, :);
    end
    
    [~, ~, V] = svd(A);
    
    h = V(:, end);
    H = reshape(h, 3, 3)'; 
    
    H = T^-1 * H * U;
end 

function U = normalization_matrix(X)
    
    U = eye(3);
    U(1:2, 3) = -mean(X(:, 1:2))';
    s = (mean(sqrt(sum((X * U').^2, 2))) / sqrt(2))^-1;
    U = s * U;
end