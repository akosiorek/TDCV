function g = create_grid(x, spacing)
    
    x0 = min(x);
    x1 = max(x);
    [YY, XX] = meshgrid(x0(1):spacing:x1(1), x0(2):spacing:x1(2));
    g = [YY(:) XX(:)];
end