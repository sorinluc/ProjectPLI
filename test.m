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


imshowpair(img, fimg, 'montage');


rows = size(fimg, 1);
cols = size(fimg, 2);


cov = eye(3, 3);
bin_img = zeros(rows, cols);


for i = 1:rows
    for j = 1:cols
        lambda_s = (fimg(i,j,:) * cov * fimg(i,j,:)');
        if lambda_s <= t
           bin_img(i, j) = 1; 
        end
    end
end
L = bwlabel(bin_img);
