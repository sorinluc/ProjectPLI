function [ ] = histogramAnalysis( image )
%HISTOGRAMANALYSIS Summary of this function goes here
%   Detailed explanation goes here
    [rows, columns, numberOfColorChannels] = size(image);
    
    if numberOfColorChannels > 1
        image = rgb2gray(image);
    end
    
    imhist(image);
    
    return;
end

