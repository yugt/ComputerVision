function vizScaleSpace(L,E,sa)

% visualize a scale space (assume all layers same size)
%
% jason corso; 442
%
% L is the scale space (required)
%
% E,sa are the extrema locations in scale space and the corresponding
% scales (both optional)

bE = 0;
if nargin > 1
    bE = 1;
end

[r,c,l] = size(L);

figure;
colormap gray

for i = 1:l
    subplot(l,1,l-i+1);
    imagesc(L(:,:,i))
    mn = min(min(L(:,:,i)));
    mx = max(max(L(:,:,i)));
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
   
    if bE==1
        hold on
        E_ = E(E(:,3)==i,:);
        plot(E_(:,1),E_(:,2),'r+');
        for c=1:size(E_,1)
           colorcircle([E_(c,1),E_(c,2)],2.5*sa(i),[1 0 0],16);
        end
    end
    
    title(sprintf('Layer %d (Range: %.1f--%.1f)',i,mn,mx))
end