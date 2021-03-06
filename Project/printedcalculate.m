function [ op1,op2,answers ] = printedcalculate(label,operand_left,operand_right,operator)

assert(size(operand_left,1)==size(operand_right,1));
assert(length(operator)==size(operand_left,1));

load('./Trained/images.mat','-mat','images');
load('./Trained/labels.mat','-mat','labels');

mu = mean(images,2);
images_centered = images - mu;
IM = images_centered*transpose(images_centered);
[V,~] = pcacov(IM);
basis = V(:,1:50);
projection_train = transpose(basis) * images_centered;




opleft=zeros(size(operand_left));
opright=zeros(size(operand_right));

counter=0;
for i=1:size(operand_left,1)
    for j=1:max(size(operand_left,2),size(operand_right,2))
        if j<=size(operand_left,2) && operand_left(i,j)>0
            % opleft(i,j)=recognize(selector(label,operand_left(i,j)),mod(counter,10)); %pred to form base
            opleft(i,j)=printedDigitRecognize(projection_train,...
                imresize(selector(label,operand_left(i,j)),[32 32]), basis, labels, mu);
            counter=counter+1;
        end
        if j<=size(operand_right,2) && operand_right(i,j)>0
            % opright(i,j)=recognize(selector(label,operand_right(i,j)),mod(counter,10)); % pred to form base
            opright(i,j)=printedDigitRecognize(projection_train,...
                imresize(selector(label,operand_right(i,j)),[32 32]), basis, labels, mu);
            counter=counter+1;
        end
    end
end



base=10.^(size(opleft,2)-1:-1:0)';
op1=opleft*base;
base=10.^(size(opright,2)-1:-1:0)';
op2=opright*base;


answers=zeros(size(operator));
for i=1:length(operator)
    switch operator(i)
        case 1
            answers(i)=op1(i)+op2(i);
        case 2
            answers(i)=op1(i)-op2(i);
        case 3
            answers(i)=op1(i)*op2(i);
        case 4
            if op2(i)>0
                answers(i)=op1(i)/op2(i);
            else
                answers(i)=0;
            end
        otherwise
            assert(0);
    end
end

end

