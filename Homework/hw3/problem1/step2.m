% step2.md for hw3
% jason corso
%



Es = findSSExtrema(Ls);
Ef = findSSExtrema(Lf);
Ec = findSSExtrema(Lc);


% visualizes the original (very many, beware) extrema in the scale-space
vizScaleSpace(Ls,Es,sas)
vizScaleSpace(Lc,Ec,sac)  % probably only safe to call it here
vizScaleSpace(Lf,Ef,saf)


