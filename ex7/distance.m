function dist = distance(p1, p2, H)
   
    p2 = normalize(p2 * H');
    dist = p2 - p1(:, 1:2);
    dist = sum(dist.^2, 2);
end