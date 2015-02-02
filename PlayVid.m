function interestArray = PlayVid( vid, vw)
%PlayVid Takes in a given video name and an output video name, cuts the
%input video around the first and last golf shots taken to the output video
%file name
%   Detailed explanation goes here

holeDetails = sprintf('The Old Course\nHole 1 - ''Burn''\nPar 4, 355 Yards\nStrike Index 10');
logo = imread('OldLinksLogo.png');

%Find no of frames
nFrames = vid.NumberOfFrames;

%Get crop coordinates and width/height to ensure only processing tee area
yOrigin = 4*(vid.Height/5);
xOrigin = (vid.Width/4)+150;
cropWidth = (vid.Width/2)-150;
cropHeight = floor(vid.Height/5);

%Set framerate same as that coming in
vw.FrameRate = vid.FrameRate;
%Open videowriter for writing edited video
open(vw);

%Create empty array of interest points
interestArray = InterestPoint.empty(0,0);

%Enter loop to process all frames of input video
for i= 1:1:nFrames
currFrame = read(vid, i);

%Crop frame to tee area
cropped = imcrop(currFrame,[xOrigin yOrigin cropWidth cropHeight]);
%Pass cropped image to function to thresh by average
bw = ThreshOnAverage(rgb2gray(cropped));

%objects over 40px removed
bwlarge = bwareaopen(bw, 40, 8);
bw = bw-bwlarge;

%objects under 20px removed
bw = bwareaopen(bw, 20, 8);

%Remove objects touching the border of cropped area
bw = imclearborder(bw);

%Pass modified logical image plus current points of interest array to be
%analysed
interestArray = PointsOfInterest(bw, interestArray, i);

end

%Group close neighbours if they exist in final POI array
interestArray = GroupResults(interestArray);

%Pass the interestPointsa array to find cutting points
[First Last] = FindBallFrames(interestArray, i);

%Loop through between first and last points saving between them to output
%video
for z=First:Last
   frame = read(vid,z);
   frame = addLogoAndText(frame, logo, holeDetails);
   writeVideo(vw, frame);
end

%Flush out the video writer and close the input video stream
clear vid;
close(vw);

end

