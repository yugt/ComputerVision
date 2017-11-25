function [ label ] = superPixelLabel( im )

label=zeros(size(im));
count=1;

degree=zeros(size(im));

% boundary pixels have degree 0
for i=2:size(im,1)-1
    for j=2:size(im,2)-1
        if im(i,j)>0
            degree(i,j)=nnz(im(i-1:i+1,j-1:j+1))-1;
        end
    end
end

while ~isempty(find((degree>0)&(label==0),1))
    [row,col]=find((degree>0)&(label==0),1);
    label(row,col)=count;

    [adjr,adjc]=find(im(row-1:row+1,col-1:col+1)&~label(row-1:row+1,col-1:col+1));
    adj_no_label=(col+adjc-2)*size(im,1)+(row+adjr-2);
    
    while ~isempty(adj_no_label)
        ll=length(adj_no_label);
        for i=1:ll
            row=mod(adj_no_label(i),size(im,1));
            col=(adj_no_label(i)-row)/size(im,1)+1;
            label(row,col)=count;
            [adjr,adjc]=find(im(row-1:row+1,col-1:col+1)&...
                ~label(row-1:row+1,col-1:col+1));
            adj_no_label=[adj_no_label;(col+adjc-2-1)*size(im,1)+(row+adjr-2)];
            adj_no_label=unique(adj_no_label,'stable');
        end
        adj_no_label(1:ll)=[];
    end
    
    count=count+1;
end

end