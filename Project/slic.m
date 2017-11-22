function [S,Copt] = slic(image,k)

% function [S,Copt] = slic(image,numsegs)
%     EECS 442 Computer Vision;
%     Jason Corso
%
% Implementation of Achanta et al. "SLIC Superpixels Compared 
%  to State-of-the-art Superpixel Methods" PAMI 2011.
% Notation is directly from this paper when possible.
%
% k is the number of segments
% S is an index image with a unique id associated with each segments
% Copt is the structure array describing the segment information
%    it is an optional output
%    See lines 34-44 of this code to understand what is represented
%    by the superpixel Copt structure


[r,c,b] = size(image);
N = r*c;
SD = floor(sqrt(N/k));

%fprintf('r=%d,c=%d,N=r*c=%d\n',r,c,N);
%fprintf('S=%d\n',S);

% convert the image to Lab space
I = RGB2Lab(image);
IL = I(:,:,1);   %[min(min(IL)) max(max(IL))]
Ia = I(:,:,2);   %[min(min(Ia)) max(max(Ia))]
Ib = I(:,:,3);   %[min(min(Ib)) max(max(Ib))]
dy = conv2(IL,fspecial('sobel'),'same');
dx = conv2(IL,fspecial('sobel')','same');

% set up how we will store the cluster centers
C = struct( 'index',{}...         
           ,'l'    ,{}... % mean L in Lab
           ,'a'    ,{}... % mean a in Lab
           ,'b'    ,{}... % mean b in Lab
           ,'x'    ,{}... % mean x
           ,'y'    ,{}... % mean y
           ,'x_sub',{}... % subpixel x
           ,'y_sub',{}... % subpixel y
           ,'fv'   ,{}... % a feature vector that will get used later
          );
            
% initialize the seed points
i=1;
for y=floor(SD/2):SD:r
    for x=floor(SD/2):SD:c
        C(i).index = i;
        C(i).x = x;
        C(i).y = y;
        C(i).l = IL(y,x);
        C(i).a = Ia(y,x);
        C(i).b = Ib(y,x);
        i = i + 1;
    end
end
clear i x y;

% assert length(centers) = k
k = length(C);

% recenter seed points
M = dx.*dx+dy.*dy;
for i = 1:k
    minr = max(1,C(i).y-1);
    minc = max(1,C(i).x-1);
    maxr = min(r,C(i).y+1);
    maxc = min(c,C(i).x+1);
    g = M(minr:maxr,minc:maxc);
    
    [~,ix] = min(g(:));
    [y,x] = ind2sub([3 3],ix);
    y = C(i).y+y-2;
    x = C(i).x+x-2;
    C(i).x = x;
    C(i).y = y;
    C(i).l = IL(y,x);
    C(i).a = Ia(y,x);
    C(i).b = Ib(y,x);
end

% initialize other variables
% label l
S = ones(r,c)*-1;
% distance
d = inf(r,c);
% residual error
E = 1e20;
% m -- scalar weight on the distance function
m = 20;
m2overS2 = m*m/(SD*SD);   % m^2 / S^2

% main loop of algorithm
for iteration=1:12
    
    % loop over cluster centers
    for i = 1:k
        
        minr = max(1,C(i).y-SD);
        minc = max(1,C(i).x-SD);
        maxr = min(r,C(i).y+SD);
        maxc = min(c,C(i).x+SD);
        
        % this is how big di will ultimately be
        %D = zeros(maxr-minr+1,maxc-minc+1);
        
        li = I(minr:maxr,minc:maxc,1);
        ai = I(minr:maxr,minc:maxc,2);
        bi = I(minr:maxr,minc:maxc,3);
        [xi,yi] = meshgrid(minc:maxc,minr:maxr);
        
        dc2 = (li-C(i).l).*(li-C(i).l) + ...
              (ai-C(i).a).*(ai-C(i).a) + ...
              (bi-C(i).b).*(bi-C(i).b) ; 
        
        ds2 = (xi-C(i).x).*(xi-C(i).x) + ...
              (yi-C(i).y).*(yi-C(i).y) ;
        ds2 = ds2*m2overS2;  
        
        % D is actually squared distance from paper
        D = dc2+ds2;
        
        % update records of membership
        [updates_r,updates_c] = find(D < d(minr:maxr,minc:maxc));
        updates_i = sub2ind(size(D),updates_r,updates_c);
        
        % indices into the bigger image records
        updates_R = minr + updates_r - 1;
        updates_C = minc + updates_c - 1;
        updates_I = sub2ind([r,c],updates_R,updates_C);
        
        d(updates_I) = D(updates_i);
        S(updates_I) = i;
        
    end
    
    % update the clusters and compute the residual error
    err = 0;
    for i = 1:k
       
        pixels = find(S==i);
        [pixels_r,pixels_c] = ind2sub([r,c],pixels);
        
        new_y = mean(pixels_r);
        new_x = mean(pixels_c);
        new_l = mean(IL(pixels));
        new_a = mean(Ia(pixels));
        new_b = mean(Ib(pixels));
        
        err = err + hypot(new_y-C(i).y,new_x-C(i).x);
        
        C(i).x_sub = new_x;
        C(i).y_sub = new_y;
        C(i).x = min(max(1,round(new_x)),c);
        C(i).y = min(max(1,round(new_y)),r);
        C(i).l = new_l;
        C(i).a = new_a;
        C(i).b = new_b;
        
    end
    
    % check residual
    if (E-err) < 1
       break;
    else
        E = err;
    end
    
end


% finish
if nargout==2
    Copt = C;
end
