function [E] = findSSExtrema(L)

% Given the scale space layers image L (DoG Scale Space)
%  find local extrema and report them.
% jason corso; 442
%
% E is an N by 3 matrix for N extrema, X, Y, Layer columns
%
% Extrema points are locally minimal or maximal in a 3x3x3 window in space and scale.
%
% You may not use the imregionalmax function in Matlab directly, but instead need to implement yourself (to gain the experience of working with scale spaces of images).

%%%%  YOU NEED TO WRITE THIS CODE
E=[];
regmax=imregionalmax(L,26);
[x,y,l]=size(regmax);


for i=1:x
    for j=1:y
        for k=1:l
            if regmax(i,j,k) && L(i,j,k)>0.01 %0.04 good when no answers
                E=[E;[j i k]];
            end
        end
    end
end
disp(size(E))

%%%%  YOU NEED TO STOP HERE