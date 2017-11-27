% test after run

for k=1:length(equal)
    for j=1:size(operand_left,2)
        if(operand_left(k,j)>0)
            imshow(label~=operand_left(k,j)&label>0);
        end
    end
    for j=1:size(operand_right,2)
        if(operand_right(k,j)>0)
            imshow(label~=operand_right(k,j)&label>0);
        end
    end
    for j=1:size(answers,2)
        if(answers(k,j)>0)
            imshow(label~=answers(k,j)&label>0);
        end
    end
end