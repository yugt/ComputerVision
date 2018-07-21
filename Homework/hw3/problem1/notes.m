% notes.md for hw3
% jason corso
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


[Ls,sas] = DoGScaleSpace(rgb2gray(Isun),7);
[Lf,saf] = DoGScaleSpace(rgb2gray(Ifly),7);
[Lc,sac] = DoGScaleSpace(rgb2gray(Icir),7);

% visualizes the original (very many, beware) extrema in the scale-space
vizScaleSpace(Ls)
vizScaleSpace(Lc)
vizScaleSpace(Lf)


Es = findSSExtrema(Ls);
Ef = findSSExtrema(Lf);
Ec = findSSExtrema(Lc);


% visualizes the original (very many, beware) extrema in the scale-space
vizScaleSpace(Ls,Es_,sas)
vizScaleSpace(Lc,Ec_,sac)
vizScaleSpace(Lf,Ef_,saf)


Es_ = filterBlobs(rgb2gray(Isun),Ls,Es,sas);
Ef_ = filterBlobs(rgb2gray(Ifly),Lf,Ef,saf);
Ec_ = filterBlobs(rgb2gray(Icir),Lc,Ec,sac);


% visualizes the filtered extrema in the scale-space
vizScaleSpace(Ls,Es_,sas)
vizScaleSpace(Lc,Ec_,sac)
vizScaleSpace(Lf,Ef_,saf)


% visualizes the filtered extrema (the final blobs) on the image
vizBlobs(Isun,Es_,sas)
vizBlobs(Ifly,Ef_,saf)
vizBlobs(Icir,Ec_,sac)
