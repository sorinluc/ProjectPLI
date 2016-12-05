function [ peaks ] = histogramAnalysis( image )
%HISTOGRAMANALYSIS Summary of this function goes here
%   Detailed explanation goes here
    [~, ~, numberOfColorChannels] = size(image);
    
    if numberOfColorChannels > 1
        image = rgb2gray(image);
    end
    [counts,~] = imhist(image);
    counts(1) = 0;
    nbPixel = sum(counts);
    minPeakProminence = nbPixel/30
    counts
    
    [peaks,locs] = findpeaks(counts, 'MinPeakProminence', minPeakProminence);
    peaks
end

