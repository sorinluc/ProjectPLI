function [ Mask ] = createMaskFromPixelList( PixelList, x_size, y_size )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
        
    Mask = zeros(x_size, y_size);
    
    for i=1:size(PixelList,1)
        Mask(PixelList(i,2),PixelList(i,1))=1;
    end
        
end

