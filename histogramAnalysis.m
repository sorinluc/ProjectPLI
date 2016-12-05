function [ peaks ] = histogramAnalysis( image )
%HISTOGRAMANALYSIS Summary of this function goes here
%   Detailed explanation goes here
    [~, ~, numberOfColorChannels] = size(image);
    
    if numberOfColorChannels > 1
        image = rgb2gray(image);
    end
    [counts,~] = imhist(image)
    
    [peaks,locs] = findpeaks(counts, 'MinPeakProminence', 500);
    peaks
end

