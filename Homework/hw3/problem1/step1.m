% step1.md for hw4
% jason corso; 442
%


Isun = double(imread('./sunflowers.png'))/255;
Ifly = double(imread('./drosophila_brainbow.png'))/255;

%Icir = double(imread('./circles.png'))/255;
Icir = zeros(100,100);
radius = 25;
[X,Y] = meshgrid(1:100,1:100);
XYD = sqrt((X-50).^2 + (Y-50).^2);
mask1 =  XYD < radius;
Icir(mask1) = 1;
Icir = repmat(Icir,[1,1,3]);


% you need to implement this.  
[Ls,sas] = DoGScaleSpace(rgb2gray(Isun),7);
[Lf,saf] = DoGScaleSpace(rgb2gray(Ifly),7);
[Lc,sac] = DoGScaleSpace(rgb2gray(Icir),7);

% visualizes the original (very many, beware) extrema in the scale-space
vizScaleSpace(Ls)
vizScaleSpace(Lc)
vizScaleSpace(Lf)


