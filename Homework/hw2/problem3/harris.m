function C = harris(dx,dy,Whalfsize)

% function C = harris(dx,dy,Whalfsize)
%
%     EECS 442;
%     Jason Corso
%
%   I is the image (GRAY, DOUBLE)
%   or
%   dx is the horizontal gradient image
%   dy is the vertical gradient image
%
%   If you call it with the Image I, then you need set parameter dy to []
%
%   Whalfsize is the half size of the window.  Wsize = 2*Whalfsize+1
%
%   Corner strength is taken as min(eig) and not the det(T)/trace(T) as in
%   the original harris method.  Just for simplicity
%
%  output
%   C is an image (same size as dx and dy) where every pixel contains the
%   corner strength.  


if (isempty(dy))
   im = dx;
   dy = conv2(im,fspecial('sobel'),'same');
   dx = conv2(im,fspecial('sobel')','same'); 
end


%%%%%%%%% fill in below
% Corner strength is to be taken as min(eig) and not the det(T)/trace(T) as in
%  the original harris method.

C=zeros(size(dx,1),size(dx,2));
for i=1+Whalfsize:size(C,1)-Whalfsize
    for j=1+Whalfsize:size(C,2)-Whalfsize
        Ix=dx(i-Whalfsize:i+Whalfsize,j-Whalfsize:j+Whalfsize);
        Iy=dy(i-Whalfsize:i+Whalfsize,j-Whalfsize:j+Whalfsize);
        H=[sum(sum(Ix.^2)) sum(sum(Ix.*Iy)); sum(sum(Ix.*Iy)) sum(sum(Iy.^2))];
        C(i,j)=min(eig(H));
    end
end

%%%%%%%% done
