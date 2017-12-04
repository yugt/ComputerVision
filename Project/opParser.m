function [ samelabel,type ] = opParser( label, samelabel )

type=-1;
if length(samelabel)>3
    type=3;
elseif length(samelabel)==3
    areas=[nnz(label==samelabel(1))...
        nnz(label==samelabel(2))...
        nnz(label==samelabel(3))];
    if median(areas)/max(areas)>0.8
        type=2;
    else
        type=3;
    end
elseif length(samelabel)==2
	[row,col]=find(label==samelabel(2));
	if max(row)-min(row)+1<0.2*(max(col)-min(col)+1) &&...
            abs(nnz(label==samelabel(1))-nnz(label==samelabel(2)))<...
            0.2*(nnz(label==samelabel(1))+nnz(label==samelabel(2)))
        type=2;
    elseif nnz(label==samelabel(2))<0.2*nnz(label==samelabel(1))
        type=1;
    end
elseif length(samelabel)==1
    type=1;
end

end