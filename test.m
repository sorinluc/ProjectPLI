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

L = bwlabel(bin_img, 4);

reverseL = L;

rows = size(L, 1);
cols = size(L, 2);

for i = 1:rows
    for j = 1:cols
        if L(i,j) == 0
            reverseL(i,j) = 1;
        else
            reverseL(i,j) = 0;
        end
    end
end

imshow(reverseL)

