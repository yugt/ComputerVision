% 442 HW3 Run Detection Code on Testing Images
% run_3_2.m


%% rings part a
% this loads the concentric rings and generates a corner response
im = double(imread('rings.png'))/255;
re = harris(im,[],3);
figure; imagesc(re);
imwrite(re,'response_rings.png');

