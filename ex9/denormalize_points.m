function x = denormalize_points(x)
   if size(x, 1) == 2
        x = [
             x(1, 1) x(1, 2);
             x(2, 1) x(1, 2);
             x(2, 1) x(2, 2);
             x(1, 1) x(2, 2);             
            ];
    end
end