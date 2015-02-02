function [ first, last ] = FindBallFrames( interestArray, maxFrame )
%FindBallFrames Takes an array of InterestPoints and the no of frames in the
%video these are from to calculat the points where the first and last ball
%left the frame
%   Detailed explanation goes here

first = maxFrame;
last = 0;
padding = 80;
n = length(interestArray);

removeArray = [];

for k=1:n

    if interestArray(k).count < 150
       removeArray (end+1) = k; 
    end
end

interestArray(removeArray) = [];

for j=1:length(interestArray)
   if interestArray(j).lFrame<first
      first = interestArray(j).lFrame; 
   end
   if interestArray(j).lFrame>last
      last = interestArray(j).lFrame;
   end
end

first = first-padding;
if first<1
    first=1;
end
last = last + padding;
if last> maxFrame
    last=maxFrame;
end

end

