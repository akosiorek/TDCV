function score = by_points(I, T, xs, ys, score_fun)
    
    assert(numel(xs) == numel(ys));

    score = zeros(numel(xs), size(I, 3));
    for z = 1:size(I, 3)
        t = T(:, :, z);
        Ic = I(:, :, z);
        for k = 1:numel(xs)

                p = get_patch(Ic, xs(k), ys(k), size(t));
                score(k, z) = score_fun(p, t);
        end
    end
    
    score = mean(score, 2);
end