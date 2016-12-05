filepath = 'img/zidane.jpg'

raw_img = imread(filepath);
img = im2double(raw_img);
%imshow(img);
% Do gamma-corretion.
% TODO.


% Convert to TSL.
%R = img(:, :, 1);
%G = img(:, :, 2);
%B = img(:, :, 3);


%nr = R./sqrt(R.^2 + G.^2 + B.^2);
%ng = G./sqrt(R.^2 + G.^2 + B.^2);
%nb = B./sqrt(R.^2 + G.^2 + B.^2);


%fimg = cat(3,nr,ng,nb);

%imshowpair(img, fimg, 'montage');


%rows = size(fimg, 1);
%cols = size(fimg, 2);


%cov = [1,0,0;0,1,0;0,0,1];
%bin_img = zeros(rows, cols);


%for i = 1:rows
 %   for j = 1:cols
  %      c = [fimg(i,j,1), fimg(i,j,2), fimg(i,j,3)];
   %     lambda_s = c * cov * c';
    %    if lambda_s <= t
     %      bin_img(i, j) = 1; 
      %  end
 %   end
%end

[~,bin_img] = generate_skinmap(filepath);

reverseIm = bin_img;

rows = size(bin_img, 1);
cols = size(bin_img, 2);

for i = 1:rows
    for j = 1:cols
        if bin_img(i,j) == 0
            reverseIm(i,j) = 1;
        else
            reverseIm(i,j) = 0;
        end
    end
end

labeledImage = bwlabel(reverseIm, 8);

labeledImage(labeledImage<=1) = 0;
imshow(labeledImage);  

stats = regionprops(labeledImage,'Centroid',...
    'MajorAxisLength','MinorAxisLength','Orientation','PixelList','Perimeter');
filtered_stats = [];

for i=1:size(stats,1)
    if (stats(i).MajorAxisLength - stats(i).MinorAxisLength) >= 2
        % filter small iritating elements
        size(filtered_stats,1)
        if size(filtered_stats,1)==0
            filtered_stats = stats(i);
        else
            filtered_stats = [filtered_stats; stats(i)];
        end
    end
end

size(filtered_stats,1)
size(stats,1)
nbRegion = size(filtered_stats,1);
eyeRegions=[];

nbEyeRegionPair=0;

for i=1:nbRegion
    for j=i:nbRegion
        if (i~=j) && (isEyeRegionPair(filtered_stats(i), filtered_stats(j)))
            nbEyeRegionPair = nbEyeRegionPair+1;
            if nbEyeRegionPair == 1
                eyeRegions = [filtered_stats(i),filtered_stats(j)];
            else
                eyeRegions = [eyeRegions,filtered_stats(i),filtered_stats(j)]; % Consider pre-allocation
            end
        end
    end
end

imshow(raw_img);
for i=1:nbEyeRegionPair*2
    hold on; % Prevent image from being blown away.
    plot(eyeRegions(i).Centroid(1),eyeRegions(i).Centroid(2),'r+', 'MarkerSize', 5);
end
%hold off;

for i=1:nbEyeRegionPair*2
    mask = createMaskFromPixelList(eyeRegions(i).PixelList, size(raw_img,1), size(raw_img,2));
    
    maskedRgbImage = bsxfun(@times, raw_img, cast(mask, 'like', raw_img));
    imshow(maskedRgbImage);
    grayed = rgb2gray(maskedRgbImage);
    %imhist(grayed);
    histogramAnalysis(maskedRgbImage);
end

spotEyes(raw_img, eyeRegions);


    
