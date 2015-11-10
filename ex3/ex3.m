function ex3
    
   plotN = 2;
   plotM = 1;
   path = 'sample2.jpg';
   img = double(rgb2gray(imread(path))) / 255.0;
   
   figure(1)
   subplot(plotN, plotM, 1)
   imshow(img)
   title('original image')
   
   
   n = 4;
   s0 = 1;
   k = 1.4;
   alpha = 0.04;
   t = 0.1;
   
   
   corners = harris(img, n, s0, k, alpha, t);
   [x, y] = ind2sub(size(corners), find(corners>0));
   subplot(plotN, plotM, 2)
   imshow(corners>0);
   title('corners')
    
    
end