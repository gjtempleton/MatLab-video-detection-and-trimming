function [ threshed ] = ThreshOnAverage( image )
%ThreshOnAverage Takes a given grayscale image and creates a logical image
%thresholded based on the average intensity
%   Detailed explanation goes here

%Create the averaging kernel
kernelSize =5;
kernW = (kernelSize-1)/2;

[h,w] = size(image);
average = [h, w];
threshed = false (h, w);
%Pad the image to allow all elements of the passed image to be averaged
image = padarray(image, [2 ,2 ]);

%Loop through the entire image calculating the average of the 5x5 kernel
%around it and perform comparison
for i=kernW+1:w-kernW

    for j=kernW+1:h-kernW
        total =0.0;
        for k =i-kernW:i+kernW
           
            for m=j-kernW:j+kernW
                total = total + double(image(m,k));
            end
        end
        %Averasge the calculated total
        averageVal = total/25;
        average(j,i) = averageVal;
        %Calculate the difference
        diff = image(j,i) - averageVal;
        %If the difference between the average and the intensity of the
        %pixel is greater than 25 turn it to 1, otherwise stays 0
        if diff>25
           threshed((j-kernW),(i-kernW)) = true; 
        end
    
    end    
end


