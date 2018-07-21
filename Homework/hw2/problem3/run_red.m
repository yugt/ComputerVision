%
% run_red.m -- Driver for 442 hw2p3.  
% Run clear all; close all first.
% Loads images, executes detector (student implement a function that is
% called) and then executes image stitching.
%
% Many figures are created during the execution; red_stitched1.png is
% created, which needs to be included in the submission.
%
% p-code is provided for other aspects of the assignment that students may
% be asked to implement later or in a different class.
%
% Load Images, Automatically Extract Corners and Match them.
% Stitches two images of a common scene together
%
% Requires Matlab >=2014b

%% Knobs

% Example JJC Red Building
inpath1 = 'red1.jpg';
inpath2 = 'red2.jpg';

%% Load images

im1 = imread(inpath1);
im2 = imread(inpath2);

%% Get correspondences --- this is the 551 approach: manual clicks.

%baseName = regexp(inpath1,'^\D+','match','once');
%pointsPath = sprintf('%s_points%i.mat',baseName,n);
%if exist(pointsPath,'file') 
%    % Load saved points
%    load(pointsPath);
%else
%    % Get correspondences
%    [XY1, XY2] = getCorrespondences(im1,im2,n);
%    save(pointsPath,'XY1','XY2');
%end


[F1,P1] = reduce(double(im1)/255);   % calls detect which calls harris
[F2,P2] = reduce(double(im2)/255);
figure;
subplot(2,2,1); imshow(im1); labelPoints(P1,'+'); title('image 1');
subplot(2,2,2); imshow(im2); labelPoints(P2,'+'); title('image 2');
subplot(2,2,3); imagesc(F1); title('Image 1 HOG Matrix');
subplot(2,2,4); imagesc(F2); title('Image 2 HOG Matrix');

if ~exist('kCorr','var')
    kCorr = 10;
end
M = match(F1,F2,kCorr);
show(im1,P1,im2,P2,M);  title('automatically computed matches')

% saves the corespondences to a png file for submission
fig = gcf;
fig.PaperUnits = 'points';
fig.PaperPosition = [0 0 1600 700];
print(sprintf('red_showcorrespondences_%d.png',kCorr),'-dpng','-r0');

% use M to create the necessary coordinate matches
% XY1 and XY2 are parallel X,Y coordinate arrays for matches
XY1 = ones(kCorr,2);
XY2 = ones(kCorr,2);

for i = 1:kCorr
    XY1(i,:) = P1(M(i,1),:);
    XY2(i,:) = P2(M(i,2),:);
end



%% Compute transforms

% This is given as p-code for 442 since it is an assignment for 551!
H21 = hw3p6b(XY2,XY1); % 2 --> 1
H12 = hw3p6b(XY1,XY2); % 1 --> 2

%% Stitch images from perspective 1

I1(1) = struct('image',im1,'tform',eye(3));
I1(2) = struct('image',im2,'tform',H21'); % stitchImages expects the transpose of H21
im2t = stitchImages(I1(2));

% In bren1.jpg, the balcony in the foreground occludes the lower-left
% portion of the hall, so it's better to stitch in reverse order so
% bren2.jpg displays on top
[imS1, alphaS1] = stitchImages(I1,'order','reverse'); % bren

% For the law images, there's no problem with occulusions, so you can
% switch to natural order, if desired
%[imS1, alphaS1] = stitchImages(I1); % not bren

%% Stitch images from perspective 2

I2(1) = struct('image',im2,'tform',eye(3));
I2(2) = struct('image',im1,'tform',H12'); % stitchImages expects the transpose of H12
im1t = stitchImages(I2(2));
[imS2, alphaS2] = stitchImages(I2);

%% Plot perspective 1 results

figure;
subplot(2,2,1); imshow(im1); labelPoints(XY1,'+'); title('image 1');
subplot(2,2,2); imshow(im2); labelPoints(XY2,'+'); title('image 2');
subplot(2,2,3); imshow(imS1); title('stitched image from perspective 1');
subplot(2,2,4); imshow(im2t); title('image 2 from perspective 1');

%% Plot perspective 2 results

figure;
subplot(2,2,1); imshow(im1); labelPoints(XY1,'+'); title('image 1');
subplot(2,2,2); imshow(im2); labelPoints(XY2,'+'); title('image 2');
subplot(2,2,3); imshow(im1t); title('image 1 from perspective 2');
subplot(2,2,4); imshow(imS2); title('stitched image from perspective 2');

%% Plot both perspectives

figure;
subplot(2,2,1); imshow(im1); labelPoints(XY1,'+'); title('image 1');
subplot(2,2,2); imshow(im2); labelPoints(XY2,'+'); title('image 2');
subplot(2,2,3); imshow(imS1); title('stitched image from perspective 1');
subplot(2,2,4); imshow(imS2);  title('stitched image from perspective 2');

%% Generate png images of the stitched images

% JJC Red
imwrite(imS1,sprintf('red_stitched1_%d.png',kCorr),'png','alpha',alphaS1);
%imwrite(imS2,sprintf('red_stitched2_%d.png',kCorr),'png','alpha',alphaS2);


