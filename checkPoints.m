function InterestPoints = checkPoints( newPoints, oldPoints, currFrame )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

InterestPoints = InterestPoint.empty(0,0);

margin =3;
if(isempty(oldPoints))
    
    InterestPoints = newPoints;

elseif(isempty(newPoints))

    InterestPoints = oldPoints;

else
    
    for i=1:length(newPoints)
        old = false;
      for j=1:length(oldPoints)
        timeDiff = currFrame - oldPoints(j).lFrame;
        if timeDiff<100
       if ((newPoints(i).x >= oldPoints(j).x - margin) && (newPoints(i).x <= oldPoints(j).x + margin)) && ((newPoints(i).y >= oldPoints(j).y - margin) && (newPoints(i).y <= oldPoints(j).y + margin)) && ((newPoints(i).w >= oldPoints(j).w - margin) && (newPoints(i).w <= oldPoints(j).w + margin))
          oldPoints(j) = oldPoints(j).increment();
          oldPoints(j) = oldPoints(j).changeLastFrame(currFrame);
          old = true;
          break;
       end   
        end
      end
      if old == false
         InterestPoints(end + 1) = newPoints(i);
         
      end
    end
    
for k=1:length(oldPoints)    
    
    fFrame = oldPoints(k).fFrame;    
    lFrame = oldPoints(k).lFrame;
    timeSinceSeen = currFrame - lFrame;
    timeSeen = lFrame - fFrame;
    
    %Times by two to account for sampling 1 out of 2 frames
    count = oldPoints(k).count*2;
    
    propThere = timeSeen / count;
    
    
%   if(timeSinceSeen<100 || propThere < 3) 
%    if ~(timeSeen<50 && timeSinceSeen>200)
      InterestPoints(end + 1) = oldPoints(k); 
%    end

%   end
end
end