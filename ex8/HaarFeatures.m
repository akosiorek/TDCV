classdef HaarFeatures < handle
    properties
        r
        c
        winWidth
        winHeight
        featureType
        features
        minT
        maxT
        alpha
        windowSize
        scale
    end
    methods
        function obj = HaarFeatures(attrs, varargin)
            
            obj.r = attrs(1, :);
            obj.c = attrs(2, :);
            obj.winWidth = attrs(3, :);
            obj.winHeight = attrs(4, :);
            obj.featureType = attrs(5, :);
            obj.alpha = attrs(11, :);
            
            posMean = attrs(6, :);
            posMax = attrs(8, :);
            posMin = attrs(9, :);            
            R = attrs(10, :);
            
            obj.minT = (posMean - abs(posMean - posMin)) .* (R - 5) / 50;
            obj.maxT = (posMean + abs(posMax - posMean)) .* (R - 5) / 50;
            
            
%             posStd = attrs(7, :);
%             obj.error = attrs(12, :);
%             obj.falseNegativeError = attrs(13, :);
%             obj.falsePositiveError = attrs(14, :);
            
            obj.features = {@feature1, @feature2, @feature3, @feature4, @feature5};
            obj.windowSize = 19;
            
            if nargin == 2
                scale = varargin{1};
                obj.r = round(obj.r * scale);
                obj.c = round(obj.c * scale);
                obj.winWidth = round(obj.winWidth * scale);
                obj.winHeight = round(obj.winHeight * scale);
                obj.windowSize = round(obj.windowSize * scale);
                obj.scale = scale;
            end
            
        end
        function response = classify(obj, img)
            img = integral_image(img);
            response = zeros(size(img) - obj.windowSize);
            for y = 1:size(img, 1) - obj.windowSize
                for x = 1:size(img, 2) - obj.windowSize
                    patch = img(y:y+obj.windowSize-1, x:x+obj.windowSize-1);
                    response(y, x) = obj.classifyPatch(patch);
                end
            end
        end
        function f = classifyPatch(obj, patch)
            
            t = zeros(size(obj.r));
            for n = 2:numel(obj.r)
                t(n) = obj.extractFeature(patch, n);
            end
            t = (obj.minT <= t) & (t <= obj.maxT);
            f = obj.alpha * t';
        end
        function f = extractFeature(obj, img, n)
            feature = obj.features{obj.featureType(n)};
            f = feature(img, obj.r(n), obj.c(n), obj.winWidth(n), obj.winHeight(n));
        end
    end
end