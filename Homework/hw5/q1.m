% Q1 example on an image

%% load the image
%im = double(imread('porch1.png'))/255;

im = double(imread('veggie-stand.jpg'))/255;

%im = double(imread('flower1.jpg'))/255;

%im = rand(100,100,3)/20;
%im(40:60,40:60,1) = 1 - im(40:60,40:60,1);

%im = double(imread('flag1.jpg'))/255;


%figure; imagesc(im);


%% first compute the superpixels on the image we loaded
[S,C] = slic(im,144);
cmap = rand(max(S(:)),3);
mainfig = figure; 
subplot(2,3,1); imagesc(im); title('input image')
subplot(2,3,2); imagesc(S);  title('superpixel mask');
colormap(cmap);

lambda=0.5;
subplot(2,3,3); imagesc(ind2rgb(S,cmap)*lambda+im*(1-lambda));  title('superpixel overlay');

%% compute histograms on a superpixel, plot and compare

h_student = histvec(im,S==88,10);
h_correct = j_histvec(im,S==88,10);
subplot(2,3,4); bar(h_student); title('Student Histogram')
subplot(2,3,5); bar(h_correct); title('Solution Histogram')
subplot(2,3,6); bar(abs(h_student-h_correct)); title(sprintf('Error %.2f',sum(abs(h_student-h_correct))))



%% write out the figure to disk for inclusion with writeup

saveas(gcf,'q1_result.png');