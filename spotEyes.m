function [ ] = spotEyes( InitialImage, eyeRegions )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    imshow(InitialImage);
    for i=1:size(eyeRegions,2)
        hold on; % Prevent image from being blown away.
        plot(eyeRegions(i).Centroid(1),eyeRegions(i).Centroid(2),'r+', 'MarkerSize', 5);
    end

end

