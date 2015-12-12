function [M, m] = get_points_for_frame(data, n)
   
    M = squeeze(data(end, :, :));
    consensus = data(n, :, 1);
    num_points = nnz(consensus);
    consensus = consensus(1:num_points);
    m = squeeze(data(n, 1:num_points, 2:end));
    M = M(consensus, :);
end