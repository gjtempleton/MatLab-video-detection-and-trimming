function [InterestPoints] = PointsOfInterest( bw, CurrentPoints, currFrame )
%PointsOfInterest updates the POI array passed to it based upon current frame image and POIs in it 
%   Detailed explanation goes here

%Get regions within bw
[B,L] = bwboundaries(bw, 'noholes');
%Get stats of all regions
stats = regionprops(L,'all');

%Create new empty array
InterestPoints = InterestPoint.empty(0,0);
FoundIndexes = [];

margin =5;

%Convert logical image to grayscale image
%bwimage = mat2gray(bw);

%Loop through stats
    for i=1:length(stats)
        
       outline = B(i);
       matr = outline{1,1};
        
       %Pass the outline matrix to create an expanded bounding box
       box = BoxIt(matr, currFrame);
     
      %check if point has already been identified 
      for j=1:length(CurrentPoints)
            %If the new point is within mthe margin of an old point and
            %roughly the same width, assume it is the same pointOfInterest
            %so iterate its count
           if CurrentPoints(j).keep == false
            if (((box.x >= CurrentPoints(j).x - margin) && (box.x <= CurrentPoints(j).x + margin)) && ((box.y >= CurrentPoints(j).y - margin) && (box.y <= CurrentPoints(j).y + margin+2)) && (box.w>=3))              
                CurrentPoints(j) = CurrentPoints(j).increment();
                CurrentPoints(j) = CurrentPoints(j).changePos(box.x, box.y, box.w, box.h); 
                CurrentPoints(j) = CurrentPoints(j).changeLastFrame(currFrame); 
                FoundIndexes(end+1) = i;
             break;
            end  
           end
      end
    end
    
stats(FoundIndexes) = []; 
B (FoundIndexes) = [];

shapes = [stats.Eccentricity];
orientation = [stats.Orientation];

keepers = find(shapes > 0.5 & shapes<0.9);
   
  for l=1:length(keepers)
      
        keep = true;
        outline = B(keepers(l));
        
        eccentricity = shapes(keepers(l));
        orient = orientation(keepers(l));
        
        if eccentricity>0.8 && abs(orient) <70
            keep = false;
        end
        
       matr = outline{1,1};
       np = BoxIt(matr, currFrame);
       
    if np.w >= 4 && keep==true
       InterestPoints(end + 1) = np; 
    end

% pointCell = [np.x, np.y, np.w, np.h];
% bwimage = insertShape(bwimage, 'rectangle', pointCell, 'LineWidth', 2, 'Color', 'red');

       
  end
   
for k=1:length(CurrentPoints)    
    
    fFrame = CurrentPoints(k).fFrame;    
    lFrame = CurrentPoints(k).lFrame;
    timeSinceSeen = currFrame - lFrame;
    timeSeen = lFrame - fFrame;
    
    toKeep = CurrentPoints(k).keep;
    
    %Times by two to account for sampling 1 out of 2 frames
    count = CurrentPoints(k).count;
    
    propThere = count / timeSeen ;
    
    
   if(timeSinceSeen<40 || (propThere > 0.7 && count > 10) || toKeep == true) 

      if timeSinceSeen > 100 && toKeep == false
          CurrentPoints(k) = CurrentPoints(k).keepIt(true);
      end
       
      InterestPoints(end + 1) = CurrentPoints(k); 
      
  end
% The below section was used for debugging, to add boxes for the current array of found POIs
% coloured to give the devlopers an indicator of the status of each POI
% and its likely fate in the final array
%pointCell = [CurrentPoints(k).x, CurrentPoints(k).y, CurrentPoints(k).w, CurrentPoints(k).h];
%if CurrentPoints(k).keep == true && count>=150
%       
% bwimage = insertShape(bwimage, 'rectangle', pointCell, 'LineWidth', 2, 'Color', 'cyan');
% elseif CurrentPoints(k).keep == true
%     bwimage = insertShape(bwimage, 'rectangle', pointCell, 'LineWidth', 2, 'Color', 'magenta');
% 
% elseif lFrame == currFrame
%     bwimage = insertShape(bwimage, 'rectangle', pointCell, 'LineWidth', 2, 'Color', 'green');
% elseif propThere > 0.7 && count > 10 
% 
%        bwimage = insertShape(bwimage, 'rectangle', pointCell, 'LineWidth', 2, 'Color', 'blue');
% else
%     bwimage = insertShape(bwimage, 'rectangle', pointCell, 'LineWidth', 2, 'Color', 'red');
% end
%       
%end   
%bwimage = insertText(bwimage, [20, 70], currFrame);
%imshow(bwimage);

end
