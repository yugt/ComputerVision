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

[x,y,l]=size(L);
for i=2:x-1
    for j=2:y-1
        local=L(i-1:i+1,j-1:j+1,1:2);
            if local(2,2,1)==max(local(:)) || local(2,2,1)==min(local(:))
                E=[E;[j i 1]];
            end
    end
end

for i=2:x-1
    for j=2:y-1
        for k=2:l-1
            local=L(i-1:i+1,j-1:j+1,k-1:k+1);
            if local(2,2,2)==max(local(:)) || local(2,2,2)==min(local(:))
                E=[E;[j i k]];
            end
        end
    end
end

for i=2:x-1
    for j=2:y-1
        local=L(i-1:i+1,j-1:j+1,l-1:l);
        if local(2,2,2)==max(local(:)) || local(2,2,2)==min(local(:))
            E=[E;[j i l]];
        end
    end
end
%%%%  YOU NEED TO STOP HERE