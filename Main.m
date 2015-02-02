function [  ] = Main( directory )
%UNTITLED Finds all .mp4 videos in a given folder and processes them,
%cutting them down to the period between the first and last shots
%   Detailed explanation goes here

directoryString = [directory, '/*.mp4'];
%Finds the list of all .mp4 files in the directory
videos = dir (directoryString);
for i=1:length(videos)
    thisFileName = videos(i).name;
    fileNameLength = length(thisFileName);
   outputName = [thisFileName(1:(fileNameLength-4)), 'Output'];
    inputVid=VideoReader([directory,'\',thisFileName]);
    outputVid=VideoWriter([directory,'\',outputName], 'MPEG-4');
   PlayVid(inputVid, outputVid);
end

end

