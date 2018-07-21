% potts_load.m
% jason corso; 442

load 'potts_data.mat'

E1 = potts(I1);
E2 = potts(I2);

figure(1); imagesc(I1); title(sprintf("I1, E = %d", E1));
figure(2); imagesc(I2); title(sprintf("I2, E = %d", E2));