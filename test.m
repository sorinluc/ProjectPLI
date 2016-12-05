raw_img = imread('blah.jpg');
img = im2double(raw_img);
%imshow(img);
% Do gamma-corretion.
% TODO.


% Convert to TSL.
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);


nr = R./sqrt(R.^2 + G.^2 + B.^2);
ng = G./sqrt(R.^2 + G.^2 + B.^2);
nb = B./sqrt(R.^2 + G.^2 + B.^2);


fimg = cat(3,nr,ng,nb);

%imshowpair(img, fimg, 'montage');


rows = size(fimg, 1);
cols = size(fimg, 2);


cov = [1,0,0;0,1,0;0,0,1];
bin_img = zeros(rows, cols);


%for i = 1:rows
 %   for j = 1:cols
  %      c = [fimg(i,j,1), fimg(i,j,2), fimg(i,j,3)];
   %     lambda_s = c * cov * c';
    %    if lambda_s <= t
     %      bin_img(i, j) = 1; 
      %  end
 %   end
%end

[~,bin_img] = generate_skinmap('tete2.jpg');

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
    'MajorAxisLength','MinorAxisLength','Orientation')

nbRegion = size(stats,1);

nbEyeRegionPair=0;

for i=1:nbRegion
    for j=1:nbRegion
        if (i~=j) && (isEyeRegionPair(stats(i), stats(j)))
            nbEyeRegionPair = nbEyeRegionPair+1;
            if nbEyeRegionPair == 1
                eyeRegions = [stats(i),stats(j)];
            else
                eyeRegions(nbEyeRegionPair,1) = stats(i); % Consider pre-allocation
                eyeRegions(nbEyeRegionPair,2) = stats(j);
            end
        end
    end
end

eyeRegions
            
