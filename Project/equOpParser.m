function [ label, equality_signs, addition_signs, subtraction_signs, multiplication_signs, division_signs ] = equOpParser( label )

% two digits may be connected to each other

equality_signs=zeros(1,max(max(label)));
subtraction_signs=zeros(1,max(max(label)));
division_signs=zeros(1,max(max(label)));
for i=1:max(max(label))
    [row, col]=find(label==i);
    if (max(row)-min(row))<(max(col)-min(col))
        if(max(row)-min(row)<0.2*(max(col)-min(col)))
            d=max(col)-min(col);
            samelabel=unique(label(min(row)-d:max(row)+d,min(col):max(col)));
            samelabel(1)=[];
            if length(samelabel)==1
                subtraction_signs(i)=samelabel(1);
            elseif length(samelabel)==2 %equality_sign suspect
                [row,col]=find(label==samelabel(2));
                if(max(row)-min(row)<0.2*(max(col)-min(col)))
                    equality_signs(i)=samelabel(1);
                end
            elseif length(samelabel)==3
                division_signs(i)=samelabel(1);
            end
            for j=1:length(samelabel)
                label(label==samelabel(j))=i;
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
addition_signs=zeros(1,max(max(label)));
multiplication_signs=zeros(1,max(max(label)));

for i=1:max(max(label))
    [row, col]=find(label==i);
    if (abs((max(row)-min(row))/(max(col)-min(col))-1)<0.1)
%         imshow(label(min(row):max(row),min(col):max(col)));
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
%         disp([(max(row)-min(row)),(max(col)-min(col))])
%         disp(horizon(label(min(row):max(row),min(col):max(col))))
    end
end
addition_signs=unique(addition_signs);
addition_signs(1)=[];
multiplication_signs=unique(multiplication_signs);
multiplication_signs(1)=[];

check=[length(addition_signs) length(subtraction_signs)...
    length(multiplication_signs) length(division_signs) -length(equality_signs)];
assert(sum(check)==0);

end