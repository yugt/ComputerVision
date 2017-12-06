function [ segment,eqn_labels,ans_labels ] = eqnSegment( label,equality_sign )

MAX_EQN_CHAR=7;
MAX_ANS_CHAR=3;

segment=zeros(size(label));

% some digits are segmented together
% eqn operator pairer
% handwritten printed characters separater

% sort equality signs first

pos=zeros(length(equality_sign),7);
for i=1:length(equality_sign)
    [pos(i,2),pos(i,3)]=find(label==equality_sign(i),1);
end
pos(:,1)=equality_sign;
pos(:,7)=pos(:,2)+pos(:,3);

if nnz(hist(pos(:,3)))>1 && std(pos(:,3))>10
    d=(max(pos(:,3))-min(pos(:,3)))/(nnz(hist(pos(:,3)))-1);
    pos(:,4)=round((pos(:,3)-min(pos(:,3)))/d)+1;
    pos=sortrows(pos,7);
    firstrow=pos(1,:);
    lastrow=pos(end,:);
    pos=sortrows(pos(2:end-1,:),[4 3]);
    pos=[firstrow; pos; lastrow];
    
    pos(2:end,6)=diff(pos(:,3));
    for i=1:max(pos(:,4))
        ind=pos(:,4)==i;
        temp=pos(ind,:);
        temp=sortrows(temp,[2 3]);
        pos(ind,:)=temp;
    end
    
    counter=1;
    pos(1,5)=1;
    for i=2:length(equality_sign)
        if pos(i,4)==pos(i-1,4) || pos(i,3)-pos(i-1,3)<mean(pos(:,6))
            counter=counter+1;
            pos(i,5)=counter;
            pos(i,4)=pos(i-1,4);
        else
            counter=1;
            pos(i,5)=counter;
            pos(i,4)=pos(i-1,4)+1;
        end
    end
    pos=sortrows(pos,[4 2]);
    counter=1;
    for i=2:length(equality_sign)
        if pos(i,4)==pos(i-1,4)
            counter=counter+1;
            pos(i,5)=counter;
        else
            counter=1;
            pos(i,5)=counter;
        end
    end
    pos=sortrows(pos,[5 4]);
    equality_sign=pos(:,1);
end

for i=1:length(equality_sign)
    % left search
%     imshow(label==sign(i));
    [r1,c1]=find(label==equality_sign(i),10);
    r1=min(r1);
    c1=min(c1);
    [r2,c2]=find(label==equality_sign(i),10,'last');
    r2=max(r2);
    c2=max(c2);
    mid=floor((r1+r2)/2);
    width=c2-c1;
    height=floor(max(diff(pos(:,2)))/4);
    for j=1:MAX_EQN_CHAR
        window=label(max(1,mid-2*height):min(mid+2*height,size(label,1)),...
            max(c1-j*width,1):min((c1-(j-1)*width-1),size(label,2)));
        vals=unique(window(window>0));
        if isempty(vals)
            break
        else
            for k=1:length(vals)
                segment(label==vals(k))=i;
            end
        end
    end
end

eqn_labels=zeros(length(equality_sign),MAX_EQN_CHAR);
for i=1:length(equality_sign)
%     imshow(segment==i)
    u=unique(label(segment==i),'stable');
    eqn_labels(i,1:length(u))=u';
end

ans_labels=zeros(length(equality_sign),MAX_ANS_CHAR);
for i=1:length(equality_sign)
    [r2,~]=find(label==equality_sign(i),10);
    r2=min(r2);
    [r1,c1]=find(label==equality_sign(i),10,'last');
    r1=max(r1);
    c1=max(c1);
    mid=floor((r1+r2)/2);
    height=r1-r2;
    if i<length(equality_sign)
        [~,c2]=find(segment==i+1,1);
    end
    if c1<c2-1 && i<length(equality_sign)
        window=label(mid-2*height:mid+2*height,c1+1:c2-1);
    else
        window=label(mid-2*height:mid+2*height,c1+1:size(label,2));
    end
    vals=unique(window(window>0),'stable');
    for j=1:length(vals)
        ans_labels(i,j)=vals(j);
    end
end




end

