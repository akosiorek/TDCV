function p = extract_points(img, grid)
    p = interp2(img, grid(:, 1), grid(:, 2), 'linear');
end