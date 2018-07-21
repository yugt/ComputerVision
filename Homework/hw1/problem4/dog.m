% DoG vs. LoG
%
% EECS 442 Discussion
% 09/20/2017
% Siyuan Chen

close all;

I = im2double(imread('dog.jpg'));
figure; imshow(I);
title('Original');

% Create kernels
sigma1 = 3;
sigma2 = sigma1 * sqrt(2);
G1 = fspecial('gaussian', round(2*sigma1)+1, sigma1);
G2 = fspecial('gaussian', round(2*sigma2)+1, sigma2);
L = fspecial('laplacian');

% Do convolution
J1 = zeros(size(I));
J2 = zeros(size(I));
J3 = zeros(size(I));
for i = 1:3
    J1(:,:,i) = conv2(I(:,:,i),G1,'same');
    J2(:,:,i) = conv2(I(:,:,i),G2,'same');
    J3(:,:,i) = conv2(J1(:,:,i),L,'same');
end
D = (J2-J1)*50;

% Display
figure; imshow(J1);
title(sprintf("sigma = %.2f",sigma1));
figure; imshow(J2);
title(sprintf("sigma = %.2f",sigma2));
figure; imshow(D);
title("DoG");
figure; imshow(J3*50);
title("LoG");
