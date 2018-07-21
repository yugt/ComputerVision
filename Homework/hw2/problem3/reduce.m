function [F,Xout] = reduce(im)

% function [F,Xout] = reduce(im)
%
%     EECS 442;
%     Jason Corso
%
% Wrapper for function to detect and describe interest points in image
%
%  index is the index for the image
%
%  output
%  F is a kxn matrix of reduced features
%         n is the number of features
%         k is the dimensionality of each feature
%  Xout (optional) are the feature point locations
%

%figure; imagesc(im); title('reduce im');
X = detect(rgb2gray(im));
n = size(X,1);


F = cell(1,n);

for i = 1:n
   %fprintf('X,Y %f,%f\n',X(i,1),X(i,2));
   F(1,i) = {hog(im,X(i,1),X(i,2),32)}; 
end

F = cell2mat(F);

if nargout == 2
    Xout = X;
end
