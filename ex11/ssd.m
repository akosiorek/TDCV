function score = ssd(patch, template)
    score = sum(sum((patch - template).^2));
end