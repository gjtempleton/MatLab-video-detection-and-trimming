function [ finalInterestArray ] = GroupResults( interestArray )
%GroupResults Groups close neighbour POIs together and therefore updates count,
%fFrame and lFrame - performs this recursively
%   Detailed explanation goes here

n = length(interestArray);
margin = 5;
removedSomething = false;

for m=1:(n-1)
if m<=n
   x = interestArray(m).x;
   y = interestArray(m).y;
   for l=(m+1):n
       if l <= n
       xDiff = abs(interestArray(l).x - x);
       yDiff = abs(interestArray(l).y - y);
       
       if ((xDiff<=margin) && (yDiff<=margin))
           countSum = interestArray(m).count + interestArray(l).count;
           newFFrame = min([interestArray(m).fFrame interestArray(l).fFrame]);
           newLFrame = max([interestArray(m).lFrame interestArray(l).lFrame]);
           interestArray(m) = interestArray(m).setCount(countSum);
           interestArray(m) = interestArray(m).changeFirstFrame(newFFrame);
           interestArray(m) = interestArray(m).changeLastFrame(newLFrame);
           interestArray(l) = [];
           %Drops down recursively if a merging is performed, comes up
           %through layers again when called on array with no merges to be
           %made
           interestArray = GroupResults(interestArray);
           n = length(interestArray);
           
           
       end
       end
       
   end
end
end
finalInterestArray = interestArray;
end

