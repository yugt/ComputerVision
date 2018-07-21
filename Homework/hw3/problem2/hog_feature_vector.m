function [feature] = hog_feature_vector(Ix, Iy)
%
% EECS 442 Computer Vision
% Chenliang Xu and Jason Corso
%
% The given code finds the HOG feature vector for an image (a feature region). 
%
% HOG feature vector/descriptor can then be used for detection of any
% particular object. The Matlab code provides the exact implementation of
% the formation of HOG feature vector as detailed in the paper "Pedestrian
% detection using HOG" by Dalal and Triggs
%
% INPUT => Ix Iy (horizontal and vertical derivatives of input image)
% OUTPUT => HOG feature vector for that particular image

% Modified by Chenliang Xu.
%   Change Bi-Linear to Tri-Linear Interpolation for Binning Process.
%   Change Iterations and Angle Computation.

rows=size(Ix,1);
cols=size(Ix,2);

angle=atan2(Iy, Ix);
magnitude=sqrt(Ix.^2 + Iy.^2);

% figure,imshow(uint8(angle));
% figure,imshow(uint8(magnitude));

% Remove redundant pixels in an image. 
angle(isnan(angle))=0;
magnitude(isnan(magnitude))=0;

feature=[]; %initialized the feature vector

% Iterations for Blocks
for i = 0: rows/8 - 2
    for j= 0: cols/8 -2
        %disp([i,j])
        
        mag_patch = magnitude(8*i+1 : 8*i+16 , 8*j+1 : 8*j+16);
        %mag_patch = imfilter(mag_patch,gauss);
        ang_patch = angle(8*i+1 : 8*i+16 , 8*j+1 : 8*j+16);
        
        block_feature=[];
        
        %Iterations for cells in a block
        for x= 0:3
            for y= 0:3
                angleA =ang_patch(4*x+1:4*x+4, 4*y+1:4*y+4);
                magA   =mag_patch(4*x+1:4*x+4, 4*y+1:4*y+4); 
                histr  =zeros(1,8);
                
                %Iterations for pixels in one cell
                for p=1:4
                    for q=1:4
%                       
                        alpha= angleA(p,q);
                        
                        % Binning Process (Tri-Linear Interpolation)
                        if alpha>135 && alpha<=180
                            histr(8)=histr(8)+ magA(p,q)*(1-(157.5+45-alpha)/360);
                            histr(1)=histr(1)+ magA(p,q)*(1-abs(157.5-alpha)/360);
                            histr(2)=histr(2)+ magA(p,q)*(1-abs(112.5-alpha)/360);
                        elseif alpha>90 && alpha<=135
                            histr(1)=histr(1)+ magA(p,q)*(1-abs(157.5-alpha)/360);
                            histr(2)=histr(2)+ magA(p,q)*(1-abs(112.5-alpha)/360);                 
                            histr(3)=histr(3)+ magA(p,q)*(1-abs(67.5-alpha)/360);
                        elseif alpha>45 && alpha<=90
                            histr(2)=histr(2)+ magA(p,q)*(1-abs(112.5-alpha)/360);
                            histr(3)=histr(3)+ magA(p,q)*(1-abs(67.5-alpha)/360);
                            histr(4)=histr(4)+ magA(p,q)*(1-abs(22.5-alpha)/360);
                        elseif alpha>0 && alpha<=45
                            histr(3)=histr(3)+ magA(p,q)*(1-abs(67.5-alpha)/360);
                            histr(4)=histr(4)+ magA(p,q)*(1-abs(22.5-alpha)/360);
                            histr(5)=histr(5)+ magA(p,q)*(1-abs(-22.5-alpha)/360);
                        elseif alpha>-45 && alpha<=0
                            histr(4)=histr(4)+ magA(p,q)*(1-abs(22.5-alpha)/360);
                            histr(5)=histr(5)+ magA(p,q)*(1-abs(-22.5-alpha)/360);
                            histr(6)=histr(6)+ magA(p,q)*(1-abs(-67.5-alpha)/360);
                        elseif alpha>-90 && alpha<=-45
                            histr(5)=histr(5)+ magA(p,q)*(1-abs(-22.5-alpha)/360);
                            histr(6)=histr(6)+ magA(p,q)*(1-abs(-67.5-alpha)/360);
                            histr(7)=histr(7)+ magA(p,q)*(1-abs(-112.5-alpha)/360);
                        elseif alpha>-135 && alpha<=-90
                            histr(6)=histr(6)+ magA(p,q)*(1-abs(-67.5-alpha)/360);
                            histr(7)=histr(7)+ magA(p,q)*(1-abs(-112.5-alpha)/360);
                            histr(8)=histr(8)+ magA(p,q)*(1-abs(-157.5-alpha)/360);
                        elseif alpha>=-180 && alpha<=-135
                            histr(7)=histr(7)+ magA(p,q)*(1-abs(-112.5-alpha)/360);
                            histr(8)=histr(8)+ magA(p,q)*(1-abs(-157.5-alpha)/360);
                            histr(1)=histr(1)+ magA(p,q)*(1-(157.5+45+alpha)/360);
                        end
                        
                
                    end
                end
                block_feature=[block_feature histr]; % Concatenation of Four histograms to form one block feature
                                
            end
        end
        % Normalize the values in the block using L1-Norm
        block_feature=block_feature/sqrt(norm(block_feature)^2+.01);
               
        feature=[feature block_feature]; %Features concatenation
    end
end

feature(isnan(feature))=0; %Removing Infinitiy values

% Normalization of the feature vector using L2-Norm
feature=feature/sqrt(norm(feature)^2+.001);
for z=1:length(feature)
    if feature(z)>0.2
         feature(z)=0.2;
    end
end
feature=feature/sqrt(norm(feature)^2+.001); 