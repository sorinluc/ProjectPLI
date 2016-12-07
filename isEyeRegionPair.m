function [ eyeRegionPair ] = isEyeRegionPair( x, y )
%isEyeRegionPair: Verifies if the given pair of region is an eye pair
    % Based on human eye features
    
    if nargin > 2 || nargin < 2
        error('usage: isEyeRegionPair( x, y )');
    end;
    
    eyeRegionPair = 0;

    % 1st region features
    x_a = x.MajorAxisLength;
    x_b = x.MinorAxisLength;
    x_theta = x.Orientation;
    x_center = x.Centroid;
    
    % 2nd region features
    y_a = y.MajorAxisLength;
    y_b = y.MinorAxisLength;
    y_theta = y.Orientation;
    y_center = y.Centroid;
    
    % Useful in case of unvalid values for features
    if isnan(x_center(1)) || isnan(y_center(1))
        return
    end
    
    dist_xy = pdist([x_center;y_center],'euclidean');
    
    % Verifying that the regions met the expectations
    if (1 < x_a/x_b < 3) && (1 < y_a/y_b < 3)
        if abs(x_theta-y_theta) < 20
            if ((((x_a+y_a)/2) < dist_xy) && (dist_xy < (4*(x_a+y_a)/2)))
                eyeRegionPair = 1;
                %fprintf('worked with dist = %d\n', dist_xy);
            end
        end
    end
    
end

