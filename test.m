%% Lucas Sorin, Emanuella Moura Silva
%%
%% Eye detection algorithm for colored images
%%
%% 2016

% Source file path, a single file will be processed each time
filepath = 'img/tete1.jpg';

% Base image is accessible under "raw_img"
raw_img = imread(filepath);

% Skin detection, bin_img binary : 0 = skin, 1 is not
[bin_img] = generate_skinmap(raw_img);

subplot(1,2,1), imshow(raw_img);
subplot(1,2,2), imshow(bin_img);

% Exchanging 1s & 0s of binary image for further processing
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

% Detection of regions within the binary image, using 8 neighbors
labeledImage = bwlabel(reverseIm, 8);

% Removing the region corresponding to the sides
labeledImage(labeledImage<=1) = 0;
figure,imshow(labeledImage);

% Creating mask for image opening
SE = strel('disk', 1);
% Image opening to remove small regions
labeledImage = imopen(labeledImage,SE);

% Get regions' stats
filtered_stats = regionprops(labeledImage,'Centroid',...
    'MajorAxisLength','MinorAxisLength','Orientation','PixelList','Perimeter');


size(filtered_stats,1) % DEBUG

nbRegion = size(filtered_stats,1);
eyeRegions=[];
nbEyeRegionPair=0;

% For each pair of region, we verify that they fullfil the requirements
% stated in the article. If they do, they are considered eye region

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


% For each potential eye region, analyse the histogram data
% This to avoid eyebrows are other parts to be considered eye regions
for i=1:nbEyeRegionPair*2
    mask = createMaskFromPixelList(eyeRegions(i).PixelList, size(raw_img,1), size(raw_img,2));
    
    maskedRgbImage = bsxfun(@times, raw_img, cast(mask, 'like', raw_img));
    %imshow(maskedRgbImage);
    grayed = rgb2gray(maskedRgbImage);
    %imhist(grayed);
    histogramAnalysis(maskedRgbImage);
end

% Marking eye regions with red spots
spotEyes(raw_img, eyeRegions);


    
