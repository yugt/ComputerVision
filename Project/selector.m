function [ window ] = selector( label,index )

[row, col]=find(label==index);

window=label(min(row):max(row),min(col):max(col))>0;

end

