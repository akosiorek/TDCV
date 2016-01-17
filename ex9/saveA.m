AA = zeros([size(A{1}) numel(A)]);
for i = 1:numel(A)
    AA(:, :, i) = A{i};
end
save('AA.mat', 'AA');