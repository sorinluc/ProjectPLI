function [ ROI ] = selectEllipse( image )
%SELECTELLIPSE Summary of this function goes here
%   Detailed explanation goes here
    h_im = imshow(image);
    
    e = imellipse(gca, [55 10 120 120]);
    e.wait();
    BW = createMask(e,h_im);
    
    ROI = image;
    ROI(BW==0) = 0;
    
    figure, imshow(ROI);

end

