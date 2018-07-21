function hw5show(image,centers,segmentimage,mask,cmap,handle)

% function hw5show(image,centers,segmentimage)
%
%     EECS 442 Computer Vision;
%     Jason Corso
%
% different behaviors with 2, 3 or 4 parameters.  
%
% if a handle is provided, then these functions try to draw into those axes




if (~isempty(mask))
    
   for i=1:3
        Ii = image(:,:,i);
        Ii(mask~=1) = 1;
        image(:,:,i) = Ii;
   end
    
   % only show these if we do not have the segmentimage
   if isempty(segmentimage)
    figure; imagesc(mask); title('segmentation mask')
    figure; imagesc(image);
   end
end

if ~isempty(segmentimage)
    
    dy = conv2(segmentimage,fspecial('sobel'),'same');
    dx = conv2(segmentimage,fspecial('sobel')','same');
    M = (dx.*dx+dy.*dy)>0;
    for i=1:3
        Ii = image(:,:,i);
        Ii(M) = 0;
        image(:,:,i) = Ii;
    end
    
    if ~isempty(handle)
        axes(handle)
        imagesc(image)
    else
        figure;
        subplot(1,2,1);
        imagesc(image);
        subplot(1,2,2);
        imagesc(segmentimage);
        if ~isempty(cmap)
            colormap(cmap)
        end
    end
    
    return
end


figure;
imagesc(image);
hold on;

if ~isempty(centers)
    for i=1:length(centers)
        plot(centers(i).x,centers(i).y,'g+');
    end
end


