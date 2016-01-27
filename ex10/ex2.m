close all, clear all, clc

num_images = 50;
max_iter = 3;
x = [506 308 57 47]; % x y width height



img = load_img(0);
patch = img(x(2):x(2)+x(4)-1, x(1):x(1)+x(3)-1, :);

hist = colorHist(patch);
map = probMap(patch, hist);

xs = repmat(1:x(3), [x(4) 1]) - x(3)/2;
ys = repmat((1:x(4))', [1 x(3)]) - x(4)/2;
 
total_time = 0;

for n = 1:num_images
    tic;
    img = load_img(n);
    patch = img(x(2):x(2)+x(4)-1, x(1):x(1)+x(3)-1, :);
    
    disp(x(1:2));
    
    for iter = 1:max_iter
        map = probMap(patch, hist);
        
        denom = sum(sum(map));
        dx = sum(sum(xs .* map)) / denom;
        dy = sum(sum(ys .* map)) / denom;
        delta = round([dx dy]);
        x(1:2) = x(1:2) + delta;
        
        if norm(delta) < 2
            break
        end
    end
    hist = colorHist(patch);
    
    total_time = total_time + toc;
    imshow(img)
    rectangle('Position', x, 'LineWidth', 2)
    drawnow
end
fprintf('FPS = %03f\n', (num_images / total_time));
