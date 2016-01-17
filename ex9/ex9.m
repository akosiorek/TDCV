clc

train = false;
train = true;


x = [214 204; 314 304];
x = denormalize_points(x);
scale = 1;
num_samples = 20000;
num_stages = 10;
num_trials = 5;
num_images = 50;
spacing = 5;

img = load_img(0, scale);
grid = create_grid(x, spacing);

if train
    A = training(img, x, grid, num_samples, num_stages);
    saveA();
else
    loadA();
end


template_intensity = normalize(extract_points(img, grid));

h = figure(1);
imshow(img)
draw_polygon(x);
print(h, '-dpng', 'result/000.png'); 

H = projective2d(eye(3));
x0 = x;

for i = 1 : num_images
    img = load_img(i, scale);
    
    update = 0;
    for s = 1 : num_stages
        for t = 1 : num_trials
            
            warped_grid = warp_points(grid, H);  
            warped_intensity = normalize(extract_points(img, warped_grid));

            diff = warped_intensity - template_intensity;
            update = -reshape(A{s} * diff, size(x));
            
            H = homography(x0, x + update);
            x = x + update;
        end
    end
    
    imshow(img)
    title(num2str(i));
    draw_polygon(x);
    print(h, '-dpng', sprintf('result/%03d.png', i));    
end
