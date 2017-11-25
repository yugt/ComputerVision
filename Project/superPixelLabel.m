function [ label ] = superPixelLabel( im )

imshow(im)

label=zeros(size(im));
count=100;

degree=zeros(size(im));

for i=2:size(im,1)-1
    for j=2:size(im,2)-1
        if im(i,j)>0
            degree(i,j)=nnz(im(i-1:i+1,j-1:j+1))-1;
        end
    end
end

imshow(degree/max(max(degree)));



while ~isempty(find((degree>0)&(label==0),1))
    label(find((degree>0)&(label==0),1))=count;
    count=count+1;
    f=find((degree>0)&(label==0),1);
    row=mod(f,size(im,1));
    col=(f-row)/size(im,1);
    
end



for i=2:size(im,1)-1
    for j=2:size(im,2)-1
        if im(i,j)
            if nnz(im(i-1:i+1,j-1:j+1))>1
                if nnz(label(i-1:i+1,j-1:j+1))>0
                    label(i,j)=max(max(label(i-1:i+1,j-1:j+1)));
                else
                    label(i,j)=count;
                    count=count+1;
                end
            else
                im(i,j)=0;
            end
        end
    end
end

imshow(label/max(max(label)));

imshow(im);

end

