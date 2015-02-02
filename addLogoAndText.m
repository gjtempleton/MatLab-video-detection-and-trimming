function [ newFrameImg ] = addLogoAndText( frame, logo, text )
%addLogoAndText Takes a given image, logo and string and superimposes the logo
%and text to the image's upper left corner
%   NOTE: image must be larger than logo

[frameH, frameW, z] = size(frame);
[logoH, logoW, z] = size(logo);
hDiff = frameH - logoH;
wDiff = frameW - logoW;

%Pad the logo image to the same size as the frame with zeros
logo = padarray(logo, [hDiff wDiff 0], 0, 'post');

%Set the area corresponding to the logo's area in the frame to all 0s
for i=1:logoH
   for j=1:logoW
      frame(i,j,:) = 0;
   end
end

%Add the logo and hole detail text
newFrameImg = imadd(frame, logo);
newFrameImg = insertText(newFrameImg,[0 (logoH+10)], text, 'BoxColor', 'white', 'FontSize',20);

end

