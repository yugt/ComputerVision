function [ segment,eqn_labels,ans_labels ] = eqnSegment( label,equality_sign )

MAX_EQN_CHAR=7;
MAX_ANS_CHAR=3;

segment=zeros(size(label));

% some digits are segmented together
% eqn operator pairer
% handwritten printed characters separater

% sort equality signs first

pos=zeros(length(equality_sign),2);
for i=1:length(equality_sign)
    [pos(i,1),pos(i,2)]=find(label==equality_sign(i),1);
end

if nnz(hist(pos(:,2)))>1
    d=(max(pos(:,2))-min(pos(:,2)))/(nnz(hist(pos(:,2)))-1);
    pos(:,2)=round((pos(:,2)-min(pos(:,2)))/d)+1;
    pos=[equality_sign, pos];
    counter=1;
    pos=sortrows(pos,[3 2]);
    pos(1,2)=1;
    for i=2:length(equality_sign)
        if pos(i,3)==pos(i-1,3)
            counter=counter+1;
            pos(i,2)=counter;
        else
            counter=1;
            pos(i,2)=counter;
        end
    end
    pos=sortrows(pos,[2 3]);
    equality_sign=pos(:,1);
end

for i=1:length(equality_sign)
    % left search
%     imshow(label==sign(i));
    [r1,c1]=find(label==equality_sign(i),1);
    [r2,c2]=find(label==equality_sign(i),1,'last');
    mid=floor((r1+r2)/2);
    width=c2-c1;
    height=r2-r1;
    for j=1:MAX_EQN_CHAR
        window=label(mid-2*height:mid+2*height,c1-j*width:c1-(j-1)*width-1);
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
    [r2,~]=find(label==equality_sign(i),1);
    [r1,c1]=find(label==equality_sign(i),1,'last');
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

