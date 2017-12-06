function [ predict ] = handwrittenPredict( label,handwritten )


load('./Trained/images.mat','-mat','images');
load('./Trained/labels.mat','-mat','labels');

mu = mean(images,2);
images_centered = images - mu;
IM = images_centered*transpose(images_centered);
[V,~] = pcacov(IM);
basis = V(:,1:50);
projection_train = transpose(basis) * images_centered;

pred=zeros(size(handwritten));

counter=0;
for i=1:size(handwritten,1)
    for j=1:size(handwritten,2)
        if handwritten(i,j)>0
%             pred(i,j)=printedDigitRecognize(projection_train,...
%                 imresize(selector(label,handwritten(i,j)),[32 32]), basis, labels, mu);
            pred(i,j)=recognize(selector(label,handwritten(i,j)),mod(counter,10));
            counter=counter+1;
        end
    end
end











base=10.^(size(handwritten,2)-1:-1:0)';
predict=pred*base;

end

