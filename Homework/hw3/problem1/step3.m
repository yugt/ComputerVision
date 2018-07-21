% step3.md for hw3
% jason corso
%



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
