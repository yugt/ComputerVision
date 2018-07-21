function vizBlobs(im,E,sa)


n = size(E,1);

[r,c,b] = size(im);

figure; imagesc(im);
hold on;

for i = 1:length(sa)
    E_ = E(E(:,3)==i,:);
    plot(E_(:,1),E_(:,2),'r+');
    for c=1:size(E_,1)
        colorcircle([E_(c,1),E_(c,2)],2.5*sa(i),[1 0 0],16);
    end
end

set(gca,'XTickLabel','')
set(gca,'YTickLabel','')