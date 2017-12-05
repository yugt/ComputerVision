function [ label ] = denoise( label )


area=zeros(max(max(label)),1);

for i=1:size(area,1)
    area(i,:)=nnz(label==i);
end

m=mean(area);

for i=1:size(area,1)
    if area(i)<0.1*m
        label(label==i)=0;
    end
end

end