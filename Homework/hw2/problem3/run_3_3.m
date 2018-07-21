% 442 HW3 Run Detection Code on Testing Images
% run_3_3.m


% rings part b
% this code will call harris, it does post-processing to extract corners
% from the corner response image
X = detect(im,1,'harris',1,0.1,5,false);
show(im,X)
fig = gcf;
fig.PaperUnits = 'points';
fig.PaperPosition = [0 0 150 150];
print('detect_rings.png','-dpng','-r0');
