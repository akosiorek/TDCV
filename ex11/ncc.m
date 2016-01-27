function score = ncc(patch, template)
    
    patch = patch - mean(patch(:));
    patch = patch / norm(patch(:));
    template = template - mean(template(:));
    template = template / norm(template(:));
    score = sum(sum(patch .* template));
end