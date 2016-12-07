function [ ] = spotEyes( img_orig, eyeRegions )
%spotEyes Marks eye regions with red spots

    if nargin > 2 || nargin < 2
        error('usage: spotEyes(InitialImage, eyeRegions)');
    end;

    figure, imshow(img_orig);
    for i=1:size(eyeRegions,2)
        hold on; % Prevent image from being blown away.
        plot(eyeRegions(i).Centroid(1),eyeRegions(i).Centroid(2),'r+', 'MarkerSize', 5);
    end

end

