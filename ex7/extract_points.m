function extract_points(I0, N, M0, m0, d0)
% ex2
consensus_points = zeros([N+1 size(M0)]);
consensus_points(end, :, :, :) = M0;
% h = figure(1);
for n = 1:N
    fprintf('Processing image %02d\n', n);
    img_path = sprintf('img_sequence/%04d.png', n);

    I = read_image(img_path);
    [m, d] = extract_sift(I);
    matches = vl_ubcmatch(d0, d);
    matched0 = m0(matches(1, :), :);
    matched = m(matches(2, :), :);    

    
    [H, ~, inliers] = estimateGeometricTransform(matched, matched0, 'projective');
    H = H.T';
    consensus = find(all(ismember(matched0, inliers), 2));
%     [H, consensus] = RANSAC(matched0, matched, 10, 25, 1000);
%     H = H / H(3, 3);
    matched = matched(consensus, :);
    
    
%     showMatchedFeatures(I0, I, matched0, matched, 'montage');
%     name = sprintf('0 - %02d', n);
%     title(name)
%     print(h, '-dpng', name)
    
    m = size(consensus, 1);
    consensus_points(n, 1:m, 1) = matches(1, consensus);
    matched = normalize(generalize(matched) * H');
    consensus_points(n, 1:m, 2:end) = matched;
    

end

save('consensus.mat', 'consensus_points')
end