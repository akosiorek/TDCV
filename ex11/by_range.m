function score = by_range(I, T, xs, ys, score_fun)
    
    assert(numel(xs) == numel(ys));
    
    if numel(xs) == 1
        xs = [xs xs];
        ys = [ys ys];
    end
    
    score = zeros(ys(2)-ys(1)+1, xs(2)-xs(1)+1, size(I, 3));
    for z = 1:size(I, 3)
        t = T(:, :, z);
        Ic = I(:, :, z);
        for x = xs(1):xs(2)
            for y = ys(1):ys(2)
                
                p = get_patch(Ic, x, y, size(t));
                score(y - ys(1) + 1, x - xs(1) + 1, z) = score_fun(p, t);

            end 
        end
    end
    
    score = mean(score, 3);
end