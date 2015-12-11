function [final_H, p1, p2] = adaptive_RANSAC(points1, points2, t)
   
    num_points = size(points1, 1);
    assert(num_points == size(points2, 1))
    
    points1 = generalize(points1);
    points2 = generalize(points2);
    
    N = realmax;
    sample_count = 0;
    
    
    best_consensus = [];
    consensus_size = 0;
    while N >= sample_count;
        
       % a) randomly select a sample from data and instansiate model
       sample_size = randi([4 num_points])
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
       
       
       jaccard = num_inliers / num_points;
       N = log(0.01) / log(1 - jaccard^sample_size);
       sample_count = sample_count + 1;
       
%        % store best consensus for e)
       if consensus_size < num_inliers
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