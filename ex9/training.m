function A = training(img, x, grid, num_samples, num_stages)
    
   displacement_range = 3;

   template_intensity = extract_points(img, grid);
   template_intensity = normalize(template_intensity);
   
   I = zeros(size(grid, 1), num_samples);
   P = zeros(8, num_samples);
   A = cell(num_stages, 1);
   
   
   bar = waitbar(0, 'Training...');
   current_step = 0;
   num_steps = num_stages * num_samples;
   
   for s = 1:num_stages
       stage_displacement = displacement_range * (num_stages + 1 - s);
       fprintf('Training stage %d with displacement range = %d\n', s, stage_displacement);
       for n = 1:num_samples
           
           nans = true; 
           while nans
               d = 2 * stage_displacement * rand(size(x)) - stage_displacement;
               H = homography(x, x + d);
               warped_grid = warp_points(grid, H);
               warped_intensity = extract_points(img, warped_grid);

               warped_intensity = normalize(warped_intensity) ...
                   + 0.1 * randn(size(warped_intensity));


               I(:, n) = -(template_intensity - warped_intensity);
               P(:, n) = d(:);

               nans = nnz(isnan(warped_intensity)) > 0;
               if nans
                   fprintf('Found NaNs\n');
               end
           end
           
   
           current_step = current_step + 1;
           
           if mode(current_step, 100)
               waitbar(current_step/num_steps, bar);
           end
       end
       A{s} = P * I' * (I * I')^-1;
   end 
   close(bar);
   fprintf('Training finished\n');
end