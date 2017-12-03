function [ label, equality_signs, addition_signs, subtraction_signs, multiplication_signs, division_signs ] = equOpParser( label )

% two digits may be connected to each other

equality_signs=zeros(max(max(label)),1);
subtraction_signs=zeros(max(max(label)),1);
division_signs=zeros(max(max(label)),1);
for i=1:max(max(label))
    [row, col]=find(label==i);
    if (max(row)-min(row))<(max(col)-min(col))
        if(max(row)-min(row)<0.2*(max(col)-min(col)))
            d=max(col)-min(col);
            samelabel=unique(label(min(row)-d:max(row)+d,min(col):max(col)));
            samelabel(1)=[];
            [samelabel,type]=opParser(label,samelabel);
            switch type
                case 1
                    subtraction_signs(i)=samelabel(1);
                case 2
                    equality_signs(i)=samelabel(1);
                case 3
                    division_signs(i)=samelabel(1);
            end
            for j=2:length(samelabel)
                label(label==samelabel(j))=samelabel(1);
            end
        end
    end
end

newlabel=unique(label);
newlabel(1)=[];
equality_signs=unique(equality_signs);
equality_signs(1)=[];
subtraction_signs=unique(subtraction_signs);
subtraction_signs(1)=[];
division_signs=unique(division_signs);
division_signs(1)=[];



for i=1:length(newlabel)
    label(label==newlabel(i))=i;
    equality_signs(equality_signs==newlabel(i))=i;
    subtraction_signs(subtraction_signs==newlabel(i))=i;
    division_signs(division_signs==newlabel(i))=i;
end

% for i=1:max(max(label))
%     [row, col]=find(label==i);
%     if (max(row)-min(row))<(max(col)-min(col))
%         imshow(label(min(row):max(row),min(col):max(col)));
%     end
% end

% disp(length(equality_signs));
addition_signs=zeros(max(max(label)),1);
multiplication_signs=zeros(max(max(label)),1);

x=zeros(1,max(max(label)));
for i=1:max(max(label))
    [row, col]=find(label==i);
    if (abs((max(row)-min(row))/(max(col)-min(col))-1)<0.1)
%         imshow(label(min(row):max(row),min(col):max(col)));
        im0=imresize(selector(label,i),[32 32]);
        im1=rot90(im0,1);
        im2=rot90(im0,2);
        im3=rot90(im0,3);
        im4=fliplr(im0);
        im5=flipud(im0);
        im6=im0';
        im7=im2';
        s=[nnz(im0~=im1) nnz(im0~=im2) nnz(im0~=im3) nnz(im0~=im4)...
            nnz(im0~=im5) nnz(im0~=im6) nnz(im0~=im7);...
            nnz(im1~=im0) nnz(im1~=im2) nnz(im1~=im3) nnz(im1~=im4)...
            nnz(im1~=im5) nnz(im1~=im6) nnz(im1~=im7);...
            nnz(im2~=im0) nnz(im2~=im1) nnz(im2~=im3) nnz(im2~=im4)...
            nnz(im2~=im5) nnz(im2~=im6) nnz(im2~=im7);...
            nnz(im3~=im0) nnz(im3~=im1) nnz(im3~=im2) nnz(im3~=im4)...
            nnz(im3~=im5) nnz(im3~=im6) nnz(im3~=im7);...
            nnz(im4~=im0) nnz(im4~=im1) nnz(im4~=im2) nnz(im4~=im3)...
            nnz(im4~=im5) nnz(im4~=im6) nnz(im4~=im7);...
            nnz(im5~=im0) nnz(im5~=im1) nnz(im5~=im2) nnz(im5~=im3)...
            nnz(im5~=im4) nnz(im5~=im6) nnz(im5~=im7);...
            nnz(im6~=im0) nnz(im6~=im1) nnz(im6~=im2) nnz(im6~=im3)...
            nnz(im6~=im4) nnz(im6~=im5) nnz(im6~=im7);...
            nnz(im7~=im0) nnz(im7~=im1) nnz(im7~=im2) nnz(im7~=im3)...
            nnz(im7~=im4) nnz(im7~=im5) nnz(im7~=im6)];
        x(i)=sum(sum(s));
        if sum(sum(s))<8192
            [row,col]=find(label(min(row):max(row),min(col):max(col)));
            hr=hist(row);
            hc=hist(col);
            if min(hr)/max(hr)<0.2 && min(hc)/max(hc)<0.2
                % suspect of plus sign
                addition_signs(i)=i;
            else
                hr=hist(row+col);
                hc=hist(row-col);
                if min(hr)/max(hr)<0.2 && min(hc)/max(hc)<0.2
                    % suspect of times sign
                    multiplication_signs(i)=i;
                end
            end
        end
%         disp([(max(row)-min(row)),(max(col)-min(col))])
%         disp(horizon(label(min(row):max(row),min(col):max(col))))
    end
end
addition_signs=unique(addition_signs);
addition_signs(1)=[];
multiplication_signs=unique(multiplication_signs);
multiplication_signs(1)=[];
histogram(x);

check=[length(addition_signs) length(subtraction_signs)...
    length(multiplication_signs) length(division_signs) -length(equality_signs)];
disp(check)
assert(sum(check)==0);

end