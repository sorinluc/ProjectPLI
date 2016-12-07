function [ peaks ] = histogramAnalysis( image )
%HISTOGRAMANALYSIS Analyses the peaks in histogram data
%   Eye regions should present 2 peaks, while eyebrows should present 1

    if nargin > 1 || nargin < 1
        error('usage: histogramAnalysis( image )');
    end;

    % Verifying if the input image is RGB or grayscale
    [~, ~, numberOfColorChannels] = size(image);
    
    % If RGB, converts to grayscale for histogram analysis
    if numberOfColorChannels > 1
        image = rgb2gray(image);
    end
    
    % Getting histogram count for each gray value
    [counts,~] = imhist(image);
    counts(1) = 0;% Discards the pure black count, created by the mask processing %%TODO think of a more clever approach ?
    nbPixel = sum(counts);
    minPeakProminence = nbPixel/30; % Min step to consider a peak
    
    % Finding peak values within the histogram data
    [peaks,~] = findpeaks(counts, 'MinPeakProminence', minPeakProminence);

end

