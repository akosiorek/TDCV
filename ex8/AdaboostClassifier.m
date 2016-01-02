classdef AdaboostClassifier < handle
    properties
        weakClassifier
        alpha
        numTries
    end
    methods
        function obj = AdaboostClassifier(numWeakClassifiers)
            obj.weakClassifier = cell(numWeakClassifiers, 1);
            obj.alpha = zeros(numWeakClassifiers, 1);
            obj.numTries = 10;
        end
        function train(obj, samples, labels)
            weights = ones(size(samples, 1), 1);
            for n = 1:numel(obj.weakClassifier)
                weights = weights / sum(weights);
               
                
                weakClf = obj.createWeakClf(samples, labels, weights);
                obj.weakClassifier{n} = weakClf;
                classification = weakClf.test(samples);
                errors = classification ~= labels;
                
                e = sum(errors);
                obj.alpha(n) = 0.5 * log((1-e)/e);
                weights = weights .* exp(labels .* classification * obj.alpha(n)); 
            end 
            
            obj.alpha = obj.alpha / sum(obj.alpha);
        end
        function labels = test(obj, samples)
            
            labels = zeros(size(samples, 1), 1);
            for n = 1:numel(obj.weakClassifier)
                labels = labels + obj.alpha(n) * obj.weakClassifier{n}.test(samples);
            end
            labels = -1 + 2 * (labels > 0);
        end
        function clf = createWeakClf(obj, samples, labels, weights)
            
            best_clf = WeakClassifier();
            min_score = best_clf.train(samples, labels, weights);            
            
            for n = 1:obj.numTries
               clf = WeakClassifier();
               score = clf.train(samples, labels, weights);
               if score < min_score
                   min_score = score;
                   best_clf = clf;
               end
            end
            
            clf = best_clf;
        end
    end
end