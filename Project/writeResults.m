function [] = writeResults( opleft,op,opright,answer )

fileID = fopen('./TestCases/result.txt','a');

s='';
for i=1:length(op)
    switch op(i)
        case 1
            s='+';
        case 2
            s='-';
        case 3
            s='*';
        case 4
            s='/';
    end
    fprintf(fileID,'%d%s%d%s%d\n',opleft(i),s,opright(i),'=',answer(i));
end



fclose(fileID);


end