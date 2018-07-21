%
% EECS 442 HW3p2
%
% Using SIFT to find matches between feature points in two images.
% Feature points are given in points1.mat and points2.mat, corresponding to
% balloon1.jpg and balloon2.jpg
% You need to fill the missing part in the sift.m
% 
% Siyuan Chen, 2017 Fall

clear
close all

I1 = imread('balloons1.jpg');
I2 = imread('balloons2.jpg');

% point (x,y)
%  +------>  y
%  |
%  |
%  v
%  x
load points1.mat;
load points2.mat;

%%%%%% IMPLEMENT YOUR SIFT FUNCTION %%%%%%
[F1,Wfull1] = sift(I1,points1(:,1),points1(:,2));
[F2,Wfull2] = sift(I2,points2(:,1),points2(:,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Match the points based on feature vectors
k = size(points1,1);
M = match(F1,F2,k);

% Display
color = zeros(k,3);
figure; imshow(I1); hold on;
for i = 1:k
    index = M(i,1);
    color(index,:) = rand(1,3);
    colorcircle([points1(index,2),points1(index,1)],Wfull1(index)/2,color(index,:),16);
end
hold off;

figure; imshow(I2); hold on;
for i = 1:k
    index = M(i,2);
    colorcircle([points2(index,2),points2(index,1)],Wfull2(index)/2,color(M(i,1),:),16);
end
hold off;
