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
    
    A = zeros(2 * N, 9);
    
    for n = 1:N
        A(2*n - 1, 4:6) = - X2(n, 3) * X1(n, :);
        A(2*n - 1, 7:9) = X2(n, 2) * X1(n, :);
        A(2*n, 1:3) = X2(n, 3) * X1(n, :);
        A(2*n, 7:9) = X2(n, 1) * X1(n, :);
    end
    
    [~, ~, V] = svd(A);
    
    h = V(:, end);
    H = reshape(h, 3, 3); 
end