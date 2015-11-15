function ex4()

	run('../vlfeat-0.9.20/toolbox/vl_setup');
    run('../matconvnet-1.0-beta16/matlab/vl_setupnn');
    
    objects = {'pot.jpg', 'shell.jpg'};
    test_imgs = {'test_pot1.jpg', 'test_pot2.jpg'; 'test_shell1.jpg', 'test_shell2.jpg'};
    
   
    m = 2;
    n = 3;
    
    
    figure(1) % original images with SIFT features
    figure(2) % matched SIFT features
    figure(3) % matched SIFT inliers

    for i = 1:size(test_imgs, 1)
        
        object = load_img(objects{i}, 1);
        [f_obj, d_obj] = vl_sift(object);
        
        offset = (i-1)*n;
        figure(1)
        subplot(m, n, 1 + offset);
        imshow(object/255)
        plot_descriptors(f_obj, d_obj, 50);
        title(objects{i})
        
        for j = 1:size(test_imgs, 2)
            test_img = load_img(test_imgs{i, j}, 1);
            [f, d] = vl_sift(test_img);
            
            figure(1)
            subplot(m, n, 1 + j + offset);
            imshow(test_img/255);            
            plot_descriptors(f, d, 50);
            title(test_imgs{i, j});
            
            
            [matches, scores] = vl_ubcmatch(d_obj, d);
            
            [matched_obj, matched_test] = match_points(f_obj, f, matches);
            
            figure(2)
            subplot(2, 2, (i-1)*2 + j)
            showMatchedFeatures(test_img, object, matched_obj, matched_test, 'montage');
            
            
            figure(3)
            subplot(2, 2, (i-1)*2 + j)
            [~, inlier_obj, inlier_test] = estimateGeometricTransform(matched_obj, matched_test, 'similarity');
            showMatchedFeatures(test_img, object, inlier_obj, inlier_test, 'montage');
            
        end
    end

  
    
    cellSize = 8;
    scales = [0.1:0.05:0.3];
    figure(4) % HOG features
    figure(5) % bounding boxes

    for i = 1:size(test_imgs, 1)
        
        object = load_img(objects{i}, 0.125);
        [im, hog_obj] = extract_hog(object, cellSize);
        
        offset = (i-1)*n;
        figure(4)
        subplot(m, n, 1 + offset);
        imshow(im)
        title(objects{i})
        
        for j = 1:size(test_imgs, 2)
            best_score = 0;
            for s = scales
                test_img = load_img(test_imgs{i, j}, s);
                [im, hog_test] = extract_hog(test_img, cellSize);

                scores = vl_nnconv(hog_test, hog_obj, []);
                max_score = max(max(scores));
                
                if max_score > best_score
                    best_score = max_score;
                    best_scores = scores;
                    best_im = im;
                    best_hog = hog_test;
                    best_img = test_img;
                end
            end
            
            
            figure(4)
            subplot(m, n, 1 + j + offset);
            imshow(best_im);            
            title(test_imgs{i, j});
            
            
            
            [y0, x0] = ind2sub(size(best_scores), find(best_scores == best_score));
            pos = [x0 y0 size(hog_obj, 2) size(hog_obj, 1)] * cellSize;
            

            
            figure(5)
            subplot(2, 2, (i-1)*2 + j);
            imshow(best_img/255);
            rectangle('Position', pos, 'EdgeColor', 'r', 'LineWidth', 3);
            text(pos(1), pos(2)+pos(4)/2, num2str(max_score), 'Color', 'g');
        end
    end

end


function I = load_img(path, scale)
    I = imread(path);
    I = imresize(I, scale);
    I = single(rgb2gray(I));
end

function plot_descriptors(f, d, num)
   
    perm = randperm(size(f,2)) ;
	sel = perm(1:num);
    h1 = vl_plotframe(f(:,sel));
    h2 = vl_plotframe(f(:,sel));
    h3 = vl_plotsiftdescriptor(d(:, sel), f(:, sel));   
    set(h1,'color','k','linewidth', 3);
    set(h2,'color','y','linewidth', 2);
    set(h3,'color','g');
end

function [x1, x2] = match_points(f1, f2, matches)
   
    x2 = f1(1:2, matches(1, :))';
    x1 = f2(1:2, matches(2, :))';    
end


function [im, hog] = extract_hog(img, cellSize)
    hog = vl_hog(img, cellSize);
    im = vl_hog('render', hog);
end