function [final_H, p1, p2] = RANSAC(points1, points2, t, T, N)
   
    num_points = size(points1, 1);
    assert(num_points == size(points2, 1))
    
    points1 = padarray(points1, [0 1], 1, 'post');
    points2 = padarray(points2, [0 1], 1, 'post');
    
    
    best_consensus = [];
    size_consensus = 0;
    for n = 1:N
        
       % a) randomly select a sample from data and instansiate model
       sample_size = randi([4 num_points]);
       sample_index = randsample(num_points, sample_size);
       
       sample1 = points1(sample_index, :);
       sample2 = points2(sample_index, :);
       
       H = DLT(sample1, sample2);
       
       % b) determine the set of data points that are within a distance threshold t of the
       % model
       
       
       dist = distance(points1, points2, H);
       mean(sqrt(dist))
       consensus_set = dist < t;
       num_inliers = sum(consensus_set);
       
       % c) if the number of inliers is greater than T, reestimate and terminate
       if num_inliers > T
           [final_H, p1, p2] = get_result(points1, points2, consensus_set);
           return
       end
 
       % store best consensus for e)
       if size_consensus < num_inliers
           best_consensus = consensus_set;
       end
       
       % d) rinse and repeat
    end
    
    % e) pick the biggest consensus set and reestimate the model
    [final_H, p1, p2] = get_result(points1, points2, best_consensus);
       
end


function [H, p1, p2] = get_result(p1, p2, consensus)
    p1 = p1(consensus, :);
    p2 = p2(consensus, :);
    H = DLT(p1, p2);
    
    p1 = normalize(p1);
    p2 = normalize(p2);
end

function dist = distance(p1, p2, H)
   
    p2 = normalize((H * p2')');
    dist = p2 - p1(:, 1:2);
    dist = sum(dist.^2, 2);
end

function p = normalize(p)
    
   p = p(:, 1:2) ./ repmat(p(:, 3), [1 2]); 
end