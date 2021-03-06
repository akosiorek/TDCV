function ex2
    
   %% 1. Median Filtering
   img = read_lena();
   
   p = 0.05;
   
   % 1b
   gaus_img = add_noise(img, p, 'gaus');
   pepper_img = add_noise(img, p, 'pepper');
   
   % 1a implemented in median_filter
   gaus_median = median_filter(gaus_img, 3);
   pepper_median = median_filter(pepper_img, 3);
   
   gaus_gaus = smooth_gaus(gaus_img, 3);
   pepper_gaus = smooth_gaus(pepper_img, 3);
   
   
   
   titles = {'gaus noise', 'pepper noise', 'gaus smoothed', 'gaus smoothed', 'median smoothed', 'median smoothed'}; 
   imgs = {gaus_img, pepper_img, gaus_gaus, pepper_gaus, gaus_median, pepper_median};
   
   % 1c: median filter works best for salt&pepper, gaussian for gaussian 
   figure()
   for i = 1:numel(imgs)
       subplot(3, 2, i)
       imshow(imgs{i})
       title(titles{i})
   end
   
   %% Bilateral Filtering
   sigmas = [1 5 9];
   img = read_lena();
   
   sigma_r = 0.1;
   figure()
   for i = 1:numel(sigmas)
       sigma_d = sigmas(i);
       % 2a implemented in bilateral_filter
       % 2b below
       bim = bilateral_filter(img, sigma_d, sigma_r);
       gim = smooth_gaus(img, sigma_d);
       subplot(3, 2, 2*i-1)
       imshow(bim)
       title(strcat('bilateral, sigma = ', int2str(sigma_d)))
       
       subplot(3, 2, 2*i)
       imshow(gim)
       title(strcat('gaussian, sigma = ', int2str(sigma_d)))
   end
   
   % bilateral vs gaussian:
   % bilateral as convolution mask
   % domain vs range filter
   
    
end

function lena = read_lena()
   lena = double(imread('lena.gif'))/255;
end

function f = smooth_gaus(img, sigma)
    
    gx = gaus(sigma);
    gy = gx';
   
    f = convolution(convolution(img, gx, 'none'), gy, 'none');
end