function box = BoxIt(points, frame)
%BoxIt Calculates a padded bounding box for the POI passed to it and
%creates the corresponding InterestPoint object
%   Detailed explanation goes here

minY = points(1,1);
maxY = points(1,1);
minX = points(1,2);
maxX = points(1,2);

for index=1:length(points)
   if(points(index,1) < minY)
       minY = points(index,1); 
   elseif(points(index, 1) > maxY)
        maxY = points(index,1);
   end  
   
   if(points(index, 2) < minX)
               minX = points(index,2); 
   elseif(points(index, 2) > maxX)
               maxX = points(index,2); 
    end
end      


width = (maxX - minX);
height = (maxY - minY);
box = InterestPoint(minX, minY, width, height, frame);