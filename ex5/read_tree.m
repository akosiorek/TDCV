function [nodes, leafs] = read_tree(filename)
   
    file = fopen(filename);

    N = textscan(file, '%d', 1);
    raw_nodes = textscan(file, '%d %d %d %d %d %d %d %d %d %d %d', N{1});
    nodes = to_array(N{1}, raw_nodes);
    
    nodes(:, 7) = transform_channel(nodes(:, 7));
    nodes(:, 10) = transform_channel(nodes(:, 10));
    
    M = textscan(file, '%d', 1);
    raw_leafs = textscan(file, '%d %f %f', M{1});
    leafs = to_array(M{1}, raw_leafs);

    fclose(file);
end


function A = to_array(N, cell_array)
    A = zeros(N, numel(cell_array));
    for i = 1:numel(cell_array)
        A(:, i) = cell_array{i};
    end
end

function c = transform_channel(c)
   c(c == 3) = 2;
   c = c + 1;
end