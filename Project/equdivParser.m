function [ label,equality_signs ] = equdivParser( label )

% two digits may be connected to each other

equality_signs=[];
for i=1:max(max(label))
    [row, col]=find(label==i);
    if (max(row)-min(row))<(max(col)-min(col))
        if(max(row)-min(row)<0.2*(max(col)-min(col)))
            d=max(col)-min(col);
            samelabel=unique(label(min(row)-d:max(row)+d,min(col):max(col)));
            samelabel(1)=[];
            if length(samelabel)==2 %equality_sign suspect
                [row,col]=find(label==samelabel(2));
                if(max(row)-min(row)<0.2*(max(col)-min(col)))
                    equality_signs=[equality_signs samelabel(1)];
                end
            end
            for j=1:length(samelabel)
                label(label==samelabel(j))=i;
            end
        end
    end
end

newlabel=unique(label);
newlabel(1)=[];
for i=1:length(newlabel)
    label(label==newlabel(i))=i;
    equality_signs(equality_signs==newlabel(i))=i;
end

% for i=1:max(max(label))
%     [row, col]=find(label==i);
%     if (max(row)-min(row))<(max(col)-min(col))
%         imshow(label(min(row):max(row),min(col):max(col)));
%     end
% end

disp(length(equality_signs));

end