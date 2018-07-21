function [L,sa] = DoGScaleSpace(im,levels)

%
%  Regarding different parameters, the paper gives some empirical data which 
%  can be summarized as, number of octaves = 4, number of scale levels = 5, 
%  initial sigma=1.6*2^0.5, k=2^0.5 etc as optimal values.
%
%
%  Contrary to the Lowe DoG Scale Space, this does not separate the scales
%  into octaves, for simplicity.
%
%  im is a grayscale double image
%  levels are the number of levels you want in the scale-space
% 
%  L is the r x c x levels response DoG scale space
%  sa is a levels x 1 vector of sigma's corresponding to each layer in the scale space.

if nargin<2
    levels=25;
end

% initial conditions are given to you.  
%  s1 is the sigma of the first Gaussian
%  k is the multiplier per level
%  sa is the vector of each sigma per level
k  = 1.1;
s1 = 4*k;   % 1.6 is too small
sa = cumprod( [s1 ones(1,levels)*k] );

% you need to populate this array.  Each i-level (:,:,i) corresponds to a level of the scale space, which is the difference of two Guassian-filtered images (sigma and k*sigma)

L = zeros([size(im) levels]);

%%%% YOU NEED TO FILL IN THE CODE BELOW 
for i=1:levels
    L(:,:,i)=imgaussfilt(im,sa(i+1))-imgaussfilt(im,sa(i));
end
%%%% YOU NEED TO STOP HERE

end
