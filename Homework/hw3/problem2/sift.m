function [F,Wfull] = sift(im,x,y)

% function [F,Wfull] = sift(im,x,y)
%
%     EECS 442 HW3p2
%     Siyuan Chen, 2017 Fall
%
%  Compute the histogram of oriented gradidents on image (im) 
%  for a given list of points (x1,y1; x2,y2;...) (image coordinates, i.e. x downwards, y rightwards)
%  
%  Input: image im, x coordinates (x1,x2,...), y coordinates (y1,y2,...) 
%
%  Output: 1. feature matrix [F] with size l*n, where l is the length of feature
%  vector and n is the number of points
%          2. width/height of feature region [Wfull]. The region is a quare of
%          Wfull*Wfull. [Wfull] is n*1 colomn vector corresponding to the size of n
%          feature regions.
%


%%%%%%%%% FILL WITH YOUR CODE HERE %%%%%%%
%% Scale selection
% Use DoG select the scale for every feature point.
[L, sa]=DoGScaleSpace(rgb2gray(im));
Wfull=zeros(size(x,1),1);
for i=1:size(x,1)
    [~,I]=max(L(x(i),y(i),:));
    Wfull(i)=2*floor(sa(I))+3;
%     window_x=x(i)-floor(sa(I))-1:x(i)+floor(sa(I))+1;
%     window_y=y(i)-floor(sa(I))-1:y(i)+floor(sa(I))+1;
end


%% Orientation assignment (optional)
% Find the dominant orientation of the features and rotate the feature
% region accordingly.


%% Compute descriptors from hog
% You could use function hog_feature_vector.m to calculate the
% histograms.
%
% Calculate feature vectors for RGB channels separately and then
% concatenate them into a single vector as the descriptor. For example, if the feature
% vectors for RGB channels are 1*len (row vectors), then the descriptor of the feature
% point should be 1*(3*len) (a row vector).
% 
% Note: rescale the feature regions to be the same size before calling hog_feature_vector(Ix, Iy)
%       or it may return vectors with different lengths.
% 

F = cell(1,length(x));  % feature matrix

Ix=zeros(size(im));
Iy=zeros(size(im));
for i=1:3
    Ix(:,:,i)=conv2(im(:,:,i),[1,0,-1],'same');
    Iy(:,:,i)=conv2(im(:,:,i),[-1;0;1],'same');
end


for i = 1:length(x)
    
   % Fill your code here
   
   sIx=imresize(Ix(x(i)-(Wfull(i)-1)/2:x(i)+(Wfull(i)-1)/2,y(i)-(Wfull(i)-1)/2:y(i)+(Wfull(i)-1)/2,:),[16 16]);
   sIy=imresize(Iy(x(i)-(Wfull(i)-1)/2:x(i)+(Wfull(i)-1)/2,y(i)-(Wfull(i)-1)/2:y(i)+(Wfull(i)-1)/2,:),[16 16]);
   
    
   F(1,i) = {% descriptor of ith feature point
       [hog_feature_vector(sIx(:,:,1),sIy(:,:,1));...
       hog_feature_vector(sIx(:,:,2),sIy(:,:,2));...
       hog_feature_vector(sIx(:,:,3),sIy(:,:,3))]};
end

F = cell2mat(F);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       

