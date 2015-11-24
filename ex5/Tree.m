classdef Tree < handle
   properties
       nodes
       leafs
   end
   methods
       function obj = Tree(varargin)
           if nargin > 0
            obj.read(varargin{1});
           end
       end
       function read(obj, filename)
           [obj.nodes, obj.leafs] = read_tree(filename);
       end
       function [px, py] = classify(obj, img, x, y)
           idx = 1;
           leaf = false;
           while ~leaf
               
               if obj.choose(idx, img, x, y)
                   idx = obj.nodes(idx, 2);
               else
                   idx = obj.nodes(idx, 3);
               end
               
               if idx < 1
                   leaf = true;
                   idx = abs(idx);
               end
               
               idx = idx + 1;
           end
           px = obj.leafs(idx, 2);
           py = obj.leafs(idx, 3);
           
       end
       function f = feature(~, img, x, y, z, s)
           o = floor(s/2);
          
           Y = size(img, 1);
           X = size(img, 2);
           
           x1 = min(max(x-o, 1), X);
           y1 = min(max(y-o, 1), Y);
           x2 = min(max(x+o, 1), X);
           y2 = min(max(y+o, 1), Y);

           f = img(y2, x2, z) + img(y1, x1, z);
           f = f - img(y2, x1, z) - img(y1, x2, z);
       end
       function c = choose(obj, idx, img, x, y)
         
           info = obj.nodes(idx, 4:11);
           t = info(1);
           x0 = x + info(2);
           y0 = y + info(3);
           z0 = info(4);
           x1 = x + info(5);
           y1 = y + info(6);
           z1 = info(7);
           s = info(8);

            f0 = obj.feature(img, x0, y0, z0, s);
            f1 = obj.feature(img, x1, y1, z1, s);    
            c = (f0 - f1) < t;
       end
   end 
end
    
    

