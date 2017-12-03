function [ samelabel,type ] = opParser( label, samelabel )

if length(samelabel)>3
    type=3;
elseif length(samelabel)==3
    [row1,~]=find(label==samelabel(1));
    [row2,~]=find(label==samelabel(2));
    [row3,~]=find(label==samelabel(3));
    areas=[nnz(row1) nnz(row2) nnz(row3)];
    if median(areas)/max(areas)>0.8
        type=2;
    else
        type=3;
    end
elseif length(samelabel)==2
	[row,col]=find(label==samelabel(2));
	if(max(row)-min(row)<0.2*(max(col)-min(col)))
        type=2;
    else
        type=1;
    end
elseif length(samelabel)==1
    type=1;
end

end