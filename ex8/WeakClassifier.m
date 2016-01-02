classdef WeakClassifier < handle
    properties
        dimension
        threshold
    end
    methods
        function error = train(obj, samples, labels, weights)
            
            sumWeights = sum(weights);
            error = realmax;
            while error >= 0.5 * sumWeights;
                
                obj.dimension = randi(2);
                obj.threshold = rand() * max(abs(samples(:, obj.dimension)));
                
                classification = obj.test(samples);
                error = sum(weights(classification ~= labels));
            end
        end
        function labels = test(obj, samples)
            labels = abs(samples(:, obj.dimension)) < obj.threshold;
            labels = -1 + 2 * labels;
        end
    end
end