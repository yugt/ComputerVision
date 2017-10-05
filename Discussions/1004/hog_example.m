% 
% EECS 442 Discussion
% Histogram of oriented gradients
%
% Siyuan Chen, 10/04/2017
%

Im = imread('patch.png');
Im = im2double(Im);
figure; imshow(Im);

nwin_x=4; %set here the number of HOG windows: 4*4
nwin_y=4;
Bin=8;    %set here the number of histogram bins: 8

[r,c]=size(Im); % r num of lines ; c num of columns
H=zeros(nwin_x*nwin_y*Bin,1); % descriptor with a size of 128*1
step_x=floor(c/nwin_x);  % window size
step_y=floor(r/nwin_y);

% calculate gradients(magnitude and angle)
% ^ y
% |
% |_____> x
%
hx = [1,0,-1];
hy = -hx';
grad_xr = conv2(Im,hx,'same');
grad_yu = conv2(Im,hy,'same');
angles=atan2(grad_yu,grad_xr);  % -pi~pi
magnit=((grad_yu.^2)+(grad_xr.^2)).^.5;
figure; imagesc(magnit);

cont=0; % count # of subregions
for n=0:nwin_y-1
    for m=0:nwin_x-1
        
        cont=cont+1;
        
        % get the magnitude and angles in the current window(subregion)
        angles2=angles(n*step_y+1:(n+1)*step_y , m*step_x+1:(m+1)*step_x); % 25*25
        magnit2=magnit(n*step_y+1:(n+1)*step_y , m*step_x+1:(m+1)*step_x); % 25*25
        v_angles=angles2(:); % column vector 625*1
        v_magnit=magnit2(:); % column vector 625*1
        
        % assembling the histogram with 8 bins; 45 degrees for every bin
        H2=zeros(Bin,1);
        for b = 1:Bin
            ang_upper = -pi + b*2*pi/Bin;
            ang_lower = -pi + (b-1)*2*pi/Bin;
            for k=1:size(v_angles,1)
                if v_angles(k)<ang_upper && v_angles(k)>=ang_lower
                    H2(b)=H2(b)+v_magnit(k);
                end
            end
        end
                
        H2=H2/(norm(H2)+0.01);        
        H((cont-1)*Bin+1 : cont*Bin , 1)=H2;  % concatenate the histograms of every window
    end
end