function [X,Sout] = detect(im,Whalfsize,method,nonmaxR,nonmaxT,border,bsmooth)

% function detect(im,Whalfsize)
%
%     EECS 442;
%     Jason Corso
%
% Wrapper for function to detect interest points in the image
%
%
%  Will run harris or dog detector depending on arguments.
%    run as X = detect(index,Whalf) will just run harris.
%    run as [X,S] = detect(index,Whalf,'dog') will run dog
%      S is the output scale of a point
%
%  index is the index for the image
%  Whalfsize is the half size of the window.  Wsize = 2*Whalfsize+1
%
%  output
%  X is a 2xn matrix of corners locations where n is induced by the data
%         top row is the horizontal,x coordinate (column, not row)
%  Sout (optional) is the scale of the detected points if the method can do it


if nargin == 1
    Whalfsize=7;
    method = 'harris';
    nonmaxR = 5;
    nonmaxT = 100;
    border = 32;   % need border of 32 if using with the hog code.
    bsmooth = false;
end


X = [];

if strcmp(method,'harris')
 
    dy = conv2(im,fspecial('sobel'),'same');
    dx = conv2(im,fspecial('sobel')','same');
        
    %%% YOU ARE PROVIDING THIS FUNCTION
    C = harris(dx,dy,Whalfsize);
    
    % smooth corner response, mostly in testing synthetic scenarios
    if bsmooth
        C = conv2(C,fspecial('gaussian',[5 5],1),'same');
    end
    %min(C(:))
    %max(C(:))
    %figure; imagesc(mat2gray(C)); title('corner response')
    
    [Xr,Xc] = nonmaxsuppts(C,nonmaxR,nonmaxT);
    size(Xr)
    %prune border
    nb = border; 
    [r,c] = size(im);
    by = Xr > nb & Xr < r-nb;
    bx = Xc > nb & Xc < c-nb;
    Xr = Xr(by & bx);
    Xc = Xc(by & bx);
    
    X = [Xc Xr];

elseif strcmp(method,'dog')
    
    [X,S] = dog(im);
    
    if (nargout == 2)
        Sout = S;
    end
end

