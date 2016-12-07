function [ Mask ] = createMaskFromPixelList( PixelList, x_size, y_size )
%createMaskFromPixelList: Creates an x_size X y_size mask from the the pixel list 

    if nargin > 3 || nargin < 3
        error('usage: createMaskFromPixelList( PixelList, x_size, y_size )');
    end;

    %Init matrix
    Mask = zeros(x_size, y_size);
    
    for i=1:size(PixelList,1)
        Mask(PixelList(i,2),PixelList(i,1))=1;
    end
        
end

