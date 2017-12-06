function [ label ] = printResults( label,answers,handwritten,equality_signs )

assert(length(handwritten)==length(answers));

x=[1     1     0     0     0     0     0     1     1;...
1     1     1     0     0     0     1     1     1;...
0     1     1     1     0     1     1     1     0;...
0     0     1     1     1     1     1     0     0;...
0     0     0     1     1     1     0     0     0;...
0     0     1     1     1     1     1     0     0;...
0     1     1     1     0     1     1     1     0;...
1     1     1     0     0     0     1     1     1;...
1     1     0     0     0     0     0     1     1];




for i=1:length(equality_signs)
    if answers(i)~=handwritten(i)
        [row, col]=find(label==equality_signs(i));
        width=max(col)-min(col);
        upbd=min(row)-floor((max(row)-min(row))/2);
        window=label(upbd:upbd+width,min(col):max(col));
        cross=window+uint16(imresize(x,size(window)));
        label(upbd:upbd+width,min(col):max(col))=cross;
    end
end

end