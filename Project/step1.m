close all;
clear all;
clc

rng(0);
%%%% Load images

imDir='./main/';
myFiles = dir(fullfile(imDir,'*.png')); %gets all png files in struct
angles=30*rand(1,length(myFiles));
% test=zeros(1,length(myFiles));
for k = 100:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(imDir, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    Iraw=imcomplement(rgb2gray(imread(fullFileName)));
    Irotated=imbinarize(imrotate(Iraw,angles(k)),0.01);
%     imshow(Irotated);
    % all of your actions for filtering and plotting go here
%     test(k)=horizon(Irotated,0.001);
    Iorthogonal=imrotate(Iraw,-horizon(Iraw),'bilinear');
    label=superPixelLabel(imbinarize(Iorthogonal',0.01))';
    [label,equal,add,minus,times,divide]=equOpParser(label);
    segment=eqnSegment(label,equal);
%     Ibw=(imbinarize(Iraw,0.1));
%     label=superPixelLabel(Ibw);
%     [row_start,col_start]=find(Ibw,1,'first');
%     [row_end,col_end]=find(Ibw,1,'last');
    % imrotate works well for rotated images
    % but non-rotated images shouldn't be rotated.
%     Icrop=imresize(Iorthogonal(row_start:row_end,col_start:col_end),0.5);
%     imshow(Icrop)
end
