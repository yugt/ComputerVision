function [ op_left,op_right,operators ] = digitOpSeparate( eqns,add,minus,times,divide )

operators=zeros(size(eqns,1),1);
op_left=zeros(size(eqns));
op_right=zeros(size(eqns));


for i=1:size(eqns,1)
    right=0;
    for j=1:size(eqns,2)
        if eqns(i,j)==0
            break
        elseif any((add==eqns(i,j)))
            operators(i)=1;
            right=1;
        elseif any((minus==eqns(i,j)))
            operators(i)=2;
            right=1;
        elseif any((times==eqns(i,j)))
            operators(i)=3;
            right=1;
        elseif any((divide==eqns(i,j)))
            operators(i)=4;
            right=1;
        else
            % digits
            if right==0
                op_left(i,j)=eqns(i,j);
            else
                op_right(i,j)=eqns(i,j);
            end
        end
    end
end

op_left(:,~any(op_left,1))=[];
op_right(:,~any(op_right,1))=[];




end

