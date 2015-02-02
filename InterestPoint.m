classdef InterestPoint
    %InterestPoint Class to store details about POIs
    %   Detailed explanation goes here
    
    properties
        x = 0.0;
        y = 0.0;
        w = 0.0;
        h = 0.0;
        count = 0;    
        fFrame = 0;
        lFrame = 0;
        keep = false;
    end
    
    methods
       
        function ip = InterestPoint(xVal, yVal, hVal, wVal, f)
            ip.x = xVal;
            ip.y = yVal;
            ip.h = hVal;
            ip.w = wVal;
            ip.count = 1;
            ip.fFrame = f;
            ip.lFrame = f;
            ip.keep = false;
        end

        function xVal = get.x (obj)
            xVal = obj.x;
        end
        
        function yVal = get.y (obj)
            yVal = obj.y;
        end
        
        function hVal = get.h (obj)
            hVal = obj.h;
        end
        
        function wVal = get.w (obj)
            wVal = obj.w;
        end
        
        function countVal = get.count (obj)
            countVal = obj.count;
        end
        
        function fVal = get.fFrame (obj)
            fVal = obj.fFrame;
        end
        
        function lVal = get.lFrame (obj)
            lVal = obj.lFrame;
        end 
        
        function keepVal = get.keep (obj)
           keepVal = obj.keep;
        end
               
         function obj = increment(obj)
            obj.count = obj.count + 1;
         end
        
         function obj = setCount (obj, count)
          obj.count = count;  
         end
        
         function obj = changeFirstFrame(obj, fFrame)
            obj.fFrame = fFrame;
        end
        
        function obj = changeLastFrame(obj, lFrame)
            obj.lFrame = lFrame;
        end
        
        function obj = keepIt (obj, keepIt)
          obj.keep = keepIt;  
        end
        
        function obj = changePos (obj, x, y, w, h)
          obj.x = x;
          obj.y = y;
          obj.w = w;
          obj.h = h;
        end
        
    end
    
end

