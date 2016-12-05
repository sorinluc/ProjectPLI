function [ eyeRegionPair ] = isEyeRegionPair( x, y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    eyeRegionPair = 0;

    x_a = x.MajorAxisLength;
    x_b = x.MinorAxisLength;
    x_theta = x.Orientation;
    x_center = x.Centroid;
    
    y_a = y.MajorAxisLength;
    y_b = y.MinorAxisLength;
    y_theta = y.Orientation;
    y_center = y.Centroid;
    
    if isnan(x_center(1)) || isnan(y_center(1))
        return
    end
    
    dist_xy = pdist([x_center;y_center],'euclidean');
    
    if (1 < x_a/x_b < 4) && (1 < y_a/y_b < 4) % Warning 3 should be the value
        if abs(x_theta-y_theta) < 20
            if ((((x_a+y_a)/2) < dist_xy) && (dist_xy < (4*(x_a+y_a)/2)))
                eyeRegionPair = 1;
                fprintf('worked with dist = %d\n', dist_xy);
            end
        end
    end
    
end

