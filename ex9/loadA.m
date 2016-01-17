
load('AA.mat')
A = cell(size(AA, 3), 1);
for i = 1:numel(A)
    A{i} = AA(:, :, i);
end