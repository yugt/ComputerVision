function v = histvec(image,mask,b)

% function v = histvec(image,mask,b)
%
%     EECS 442 Computer Vision;
%     Jason Corso
%
%  For each channel in the image, compute a b-bin histogram (uniformly space
%  bins in the range 0:1) of the pixels in image where the mask is true. 
%  Then, concatenate the vectors together into one column vector (first
%  channel at top).
%
%  mask is a matrix of booleans the same size as image.
% 
%  normalize the histogram of each channel so that it sums to 1.
%
%  You CAN use the hist function.
%  You MAY loop over the channels.

chan = size(image,3);

c = 1/b;       % bin offset
x = c/2:c:1;   % bin centers


%%%%% IMPLEMENT below this line into a 3*b by 1 vector  v
%%  3*b because we have a color image and you have a separate 
%%  histogram per color channel
v=[];
% positions=[mod(find(mask),size(mask,1)),floor(find(mask)/size(mask,1))];
[row,col]=find(mask);
for i=1:chan
    vv=zeros(length(row),1);
    for j=1:length(row)
        vv(j)=image(row(j),col(j),i);
    end
    N=hist(vv,x);
    v=[v; N'/sum(N)];
end