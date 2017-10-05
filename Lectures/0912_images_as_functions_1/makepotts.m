% to create the data for the assignment only

I0 = ones(12,12);

I1 = imresize(repmat([1:4]',1,12),[12,12],'nearest')*63;

I2 = I1
I2(1:6,7:12) = I1(1:6,7:12)';
I2(7:12,1:6) = I1(7:12,1:6)';

I3 = checkerboard(3,2,2);

figure; imagesc(I0); colormap(gray);
figure; imagesc(I1); colormap(gray);
figure; imagesc(I2); colormap(gray);
figure; imagesc(I3); colormap(gray);

save potts_data.mat
