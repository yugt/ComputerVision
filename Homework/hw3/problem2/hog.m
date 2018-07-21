function v = hog(im,x,y,Wfull)

% function v = hog(im,x,y,Wfull)
%
%     EECS Foundation of Computer Vision;
%     Chenliang Xu and Jason Corso
%
%  Compute the histogram of oriented gradidents on image (im) 
%   for a given location (x,y) and scale (Wfull)
%  
%  v is the output column vector of the hog.  
%
%  Use Lowe IJCV 2004 Sections 5 and 6 to (1) adapt to local rotation
%    and (2) compute the histogram.  Use the parameters in the paper
%    Within the window a 4 by 4 array of histograms of oriented gradients 
%    with 8 discretized orientations per bin.  Do it separately per color channel
%    and then concatenate the resulting vectors.
%    Each v should be 3*128 dimensions = 3*4*4*8.
%

v = zeros(3,1152); 

%%%%%%%%  fill in below

%% Orientation Assignment
margin_long = Wfull/2;
margin_short = Wfull/2-1;

sm = im(y-margin_long-1:y+margin_short+1, ...
    x-margin_long-1:x+margin_short+1, :);
gm = rgb2gray(sm);
dy = conv2(gm,[-1 0 1]','same');
dx = conv2(gm,[-1 0 1],'same');
dy = dy(2:end-1, 2:end-1);
dx = dx(2:end-1, 2:end-1);

mag = sqrt(dx.^2+dy.^2);
ang = atan2(dy, dx);

angd = 18-floor(ang/10); % map 180~-180 to 36 bins

cnts = zeros(36,1);
for i=1:36
    cnts(i) = sum(mag(angd==i));
end
[~,idx] = max(cnts);

theta = (18-idx)*10+5;


%% HOG Descriptor
for i=1:3

    cm = im(y-Wfull:y+Wfull, x-Wfull:x+Wfull, i);
    
    dy = conv2(cm,[-1 0 1]','same');
    dx = conv2(cm,[-1 0 1],'same');
    
    % rotate
    dy = imrotate(dy, -theta, 'crop', 'bilinear');
    dx = imrotate(dx, -theta, 'crop', 'bilinear');
    
    dy = dy(1+margin_long:end-1-margin_long, ...
        1+margin_long:end-1-margin_long);
    dx = dx(1+margin_long:end-1-margin_long, ...
        1+margin_long:end-1-margin_long);
    
    % Approximation
    v(i,:) = hog_feature_vector(dx, dy);
    
end

v = v(:);






function [feature] = hog_feature_vector(Ix, Iy)
% The given code finds the HOG feature vector for any given image. HOG
% feature vector/descriptor can then be used for detection of any
% particular object. The Matlab code provides the exact implementation of
% the formation of HOG feature vector as detailed in the paper "Pedestrian
% detection using HOG" by Dalal and Triggs

% INPUT => im (input image)
% OUTPUT => HOG feature vector for that particular image

% Example: Running the code
% >>> im = imread('cameraman.tif');
% >>> hog = hog_feature_vector (im);

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

% toc;       








%%%%%%%%  fill in above





