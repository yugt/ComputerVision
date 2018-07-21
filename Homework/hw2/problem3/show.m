function show(im1,X1,im2,X2,M)

% function show(index1,X1,index2,X2,M)
%
%     EECS 442;
%     Jason Corso
%

dotr=0;
if size(X1,1) > 2
    dotr=1;
end

% just display detected points on the image
if nargin==2
    
    if dotr==1
        X1 = X1';
    end
    
    figure; 
    imagesc(im1);
    hold on;
    
    plot(X1(1,:),X1(2,:),'r+');
    
    title('show: detected points');
    
    return;
end

% display the points in two images side by side
if nargin==4
    if dotr==1
        X1 = X1';
        X2 = X2';
    end
    figure;
    subplot(1,2,1);
    imagesc(im1);
    hold on;
    plot(X1(1,:),X1(2,:),'r+');
    
    subplot(1,2,2);
    imagesc(im2);
    hold on;
    plot(X2(1,:),X2(2,:),'r+');
    
    return;
end

% display the matches too
if nargin==5
    if dotr==1
        X1 = X1';
        X2 = X2';
    end
    
    figure;
    im = [im1,im2];
    imagesc(im);
    hold on;
    [r,c,b] = size(im1);
    
    plot(X1(1,:),X1(2,:),'r+');
    plot(X2(1,:)+c,X2(2,:),'r+');
    
    for i=1:size(M,1)
        line([X1(1,M(i,1));X2(1,M(i,2))+c],  ...
             [X1(2,M(i,1));X2(2,M(i,2))],'color',rand(1,3),'linewidth',2);
    end
    
    return;
end

fprintf('show does not understand the arguments. see help show\n');


