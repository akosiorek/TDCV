function x = normalize(x)
    x = (x - mean(x(:))) / std(x(:));
end