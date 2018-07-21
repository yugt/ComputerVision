function [XY1, XY2] = getCorrespondences(im1,im2,n)
%
% Syntax:       [XY1, XY2] = getCorrespondences(im1,im2,n);
%               
% Inputs:       im1 and im2 are images
%               
%               n is the # of correspondences to get
%               
% Outputs:      XY1 and XY2 are n x 2 matrices containing (x,y) coordinates
%               of each correspondence in the respective image
%

% Conveinence function for adding point labels
addLabels = @(xy,str) text(xy(:,1),xy(:,2), ...
                           sprintf('+%s',str), ...
                          'Color','r', ...
                          'HorizontalAlignment','center', ...
                          'VerticalAlignment','middle');

% Display images
fig = figure;
ax(1) = subplot(1,2,1); imshow(im1);
ax(2) = subplot(1,2,2); imshow(im2);

% Get points from user
x = zeros(n,2);
y = zeros(n,2);
for i = 1:n
    for j = 1:2
        subplot(1,2,j);
        title(ax(1 + ~(j - 1)),'');
        title(ax(j),sprintf('%i points left to pick',n + 1 - i));
        [xij, yij] = ginput(1);
        x(i,j) = xij;
        y(i,j) = yij;
        addLabels([xij, yij],num2str(i));
    end
end
title(ax(2),'');
close(fig);

% Return points
XY1 = [x(:,1), y(:,1)];
XY2 = [x(:,2), y(:,2)];
