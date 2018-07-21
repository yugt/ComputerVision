function [I, I_gray] = bayer_filter(I)

% function bayer_filter filters an input color image I 
% by Bayer pattern as below, and outputs filtered color 
% image I and gray scaled image I_gray that only contains 
% the intensity of corresponding color at every pixel.
% g | b
% -----
% r | g
% 
% EECS442, Fall 2017

[r,c,~] = size(I);
mask = zeros(2,2,3);
mask(1,1,:) = [0,1,0]; % green
mask(1,2,:) = [0,0,1]; % blue
mask(2,1,:) = [1,0,0]; % red
mask(2,2,:) = [0,1,0]; % green
for i = 1:r
    ii = mod(i-1,2)+1;
    for j = 1:c
        jj = mod(j-1,2)+1;
        for k = 1:3
            I(i,j,k) = I(i,j,k)*mask(ii, jj, k);
        end
    end
end
I_gray = I(:,:,1)+I(:,:,2)+I(:,:,3);

% display the images
%figure; imshow(I);
%figure; imshow(I_gray);