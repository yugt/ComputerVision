% Q2 example on an image

%% load the image
im = double(imread('porch1.png'))/255;

%im = double(imread('veggie-stand.jpg'))/255;

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

A_student = segNeighbors(S);
A_correct = j_segNeighbors(S);


subplot(2,3,4); imagesc(A_student); title('Student Adjacency')
subplot(2,3,5); imagesc(A_correct); title('Solution Adjacency')
D = abs(A_student-A_correct);
Dsum = full(sum(sum(D)));
subplot(2,3,6); imagesc(D); title(sprintf('Error %.2f',Dsum))



%% write out the figure to disk for inclusion with writeup

saveas(gcf,'q2_result.png');