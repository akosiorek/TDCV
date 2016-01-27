function score = cos_score(p, t)
    index = ~(isnan(p) | isnan(t));
    diff = p - t;
    score = 1 - sum(sum(abs(diff(index)))) / sum(sum(~isnan(t)));
end