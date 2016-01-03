classdef HaarFeatures < handle
    properties
        r
        c
        winWidth
        winHeight
        featureType
        features
        posMean
        posStd
        posMax
        posMin
        R
        alpha
        error
        falseNegativeError
        falsePositiveError
        windowSize
    end
    methods
        function obj = HaarFeatures(attrs)
            obj.r = attrs(1, :);
            obj.c = attrs(2, :);
            obj.winWidth = attrs(3, :);
            obj.winHeight = attrs(4, :);
            obj.featureType = attrs(5, :);
            
            obj.posMean = attrs(6, :);
            obj.posStd = attrs(7, :);
            obj.posMax = attrs(8, :);
            obj.posMin = attrs(9, :);
            
            obj.R = attrs(10, :);
            obj.alpha = attrs(11, :);
            obj.error = attrs(12, :);
            obj.falseNegativeError = attrs(13, :);
            obj.falsePositiveError = attrs(14, :);
            
            obj.features = {@feature1, @feature2, @feature3, @feature4, @feature5} 
            obj.windowSize = 19
        end
        function response = classify(obj, img)
            img = integral_image(img);
            response = zeros(size(img) - obj.windowSize);
            for r = 1:size(img, 1) - obj.windowSize
                for c = 1:size(img, 2) - obj.windowSize
                    patch = img(r:r+obj.windowSize-1, c:c+obj.windowSize-1);
                    response(r, c) = obj.classifyPatch(patch);
                end
            end
        end
        function f = classifyPatch(obj, patch)
            
            f = 0;
            for n = 2:numel(obj.r)
                minT = (obj.posMean(n) - abs(obj.posMean(n) - obj.posMin(n))) * (obj.R(n) - 5) / 50;
                maxT = (obj.posMean(n) + abs(obj.posMax(n) - obj.posMean(n))) * (obj.R(n) - 5) / 50;
                t = obj.extractFeature(patch, n);
                t = (minT <= t) && (t <= maxT);
                f = f + obj.alpha(n) * t;
            end
        end
        function f = extractFeature(obj, img, n)
            feature = obj.features{obj.featureType(n)};
            f = feature(img, obj.r(n), obj.c(n), obj.winWidth(n), obj.winHeight(n));
        end
    end
end