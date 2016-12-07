function [ ROI ] = selectEllipse( image )
%SELECTELLIPSE Creates a drawable ellipse to manually select image region
%   For debug purpose

    if nargin > 1 || nargin < 1
        error('usage: selectEllipse( image )');
    end;

    h_im = imshow(image);
    
    e = imellipse(gca, [55 10 120 120]);
    e.wait();
    BW = createMask(e,h_im);
    
    ROI = image;
    ROI(BW==0) = 0;
    
    figure, imshow(ROI);

end

