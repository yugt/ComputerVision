% run_red_varyk.m
%
%  442; jason corso
%
% Run the red stitching script, but vary the number of points used in the
% fitting of the homography.
%
%  4,10,20

kCorr = 4;
run_red
close all;

kCorr = 10;
run_red
close all;

kCorr = 20;
run_red
close all;
