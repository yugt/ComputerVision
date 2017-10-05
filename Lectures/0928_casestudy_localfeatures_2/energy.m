%script to play with the energy.
% E(T,I,w) = sum_w(I(T)-I(.))
close all;
clear all;

I = double(imread('line-test.png'));
size(I)

figure; imagesc(I); colormap gray

% the Window will be 12 by 12.
s = 12

p = [44,60]
u = 3
v = 0

%fprintf('Where shall we compute the energy?')
%p = round(ginput(1))
%u = round(input('What is u?  '))
%v = round(input('What is v?  '))

% compute the image derivatives
Ix = conv2(I,[-1 1],'same');
Iy = conv2(I,[-1 1]','same');

figure; 
subplot(1,2,1); imagesc(Ix); title('Ix'); colormap gray
subplot(1,2,2); imagesc(Iy); title('Iy'); colormap gray

W = zeros(size(I));
s2 = round(s/2);
W(p(2)-s2:p(2)+s2, p(1)-s2:p(1)+s2) = 1;

figure; imagesc(W); colormap gray

% implement the energy function without any for loops
% (not exactly same energy)
E = sum(sum(W.*(Ix.^2)))*u + sum(sum(W.*(Iy.^2)))*v 


u = 0
v = 3

E = sum(sum(W.*(Ix.^2)))*u + sum(sum(W.*(Iy.^2)))*v 
