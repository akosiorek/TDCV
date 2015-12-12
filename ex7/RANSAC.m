function [final_H, best_consensus] = RANSAC(points1, points2, t, T, N)
   
    num_points = size(points1, 1);
    assert(num_points == size(points2, 1))
    
    points1 = generalize(points1);
    points2 = generalize(points2);
    
    
    best_consensus = [];
    consensus_size = 0;
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
%        mean(sqrt(dist))
       consensus_set = dist < t;
       num_inliers = sum(consensus_set);
       
       % c) if the number of inliers is greater than T, reestimate and terminate
       if num_inliers > T
           best_consensus = consensus_set;
           break;
       end
 
       % store best consensus for e)
       if consensus_size < num_inliers
           best_consensus = consensus_set;
       end
       
       % d) rinse and repeat
    end
    
    % e) pick the biggest consensus set and reestimate the model
    
    best_consensus = find(best_consensus > 0);
    points1 = points1(best_consensus, :);
    points2 = points2(best_consensus, :);
    final_H = DLT(points1, points2);       
end

