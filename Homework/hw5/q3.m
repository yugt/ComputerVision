% Q3 example on an image

%% load the image
%im = double(imread('porch1.png'))/255;

%im = double(imread('veggie-stand.jpg'))/255;

im = double(imread('flower1.jpg'))/255;

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

%% next compute the feature reduction for the segmentation (histograms)
C = reduce(im,C,S);


%% next compute the graph cut, given a key index (foreground)

% retrieve a keyindex from the user? set the keyindex by hand if you want,
% but then turn off bkfu
keyindex = 80;
bkfu = 0;
if (bkfu)
    temp = figure();
    lambda = 0.25; 
    imagesc(ind2rgb(S,cmap)*lambda+im*(1-lambda));
    fprintf('Please click on the superpixel you want to be the\n   key on which to base the foreground extraction.\n\n')
    pt = ginput(1);
    close(temp);
    keyindex = S(floor(pt(2)),floor(pt(1)));
    figure(mainfig)
end
B_student = graphcut(S,C,keyindex);
B_correct = j_graphcut(S,C,keyindex); 


D = abs(B_student-B_correct);
Dsum = full(sum(sum(D)));

subplot(2,3,4); imagesc(B_student); title('Student Graph-Cut')
subplot(2,3,5); imagesc(B_correct); title('Solution Graph-Cut')
subplot(2,3,6); imagesc(D); title(sprintf('Error %.2f',Dsum))


%% write out the figure to disk for inclusion with writeup

saveas(gcf,'q3_result.png');