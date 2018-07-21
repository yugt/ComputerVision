%%%%%%%% Testing on Test Dataset SVHN %%%%%%%%%%%
load digitStruct.mat
countdigits=zeros(length(digitStruct),1);
for i = 1:length(digitStruct)
    countdigits(i)=length(digitStruct(i).bbox);
end
test=zeros(size(basis,1),sum(countdigits));
correct=zeros(sum(countdigits),1);

for i = 1:length(digitStruct)
    im = imread([digitStruct(i).name]);
    for j = 1:length(digitStruct(i).bbox)
        [height, width] = size(im);
        aa = max(digitStruct(i).bbox(j).top+1,1);
        bb = min(digitStruct(i).bbox(j).top+digitStruct(i).bbox(j).height, height);
        cc = max(digitStruct(i).bbox(j).left+1,1);
        dd = min(digitStruct(i).bbox(j).left+digitStruct(i).bbox(j).width, width)-1;
        rim=(imresize(rgb2gray(im(aa:bb, cc:dd, :)),[28 28]));
        index=sum(countdigits(1:i))-countdigits(i)+j;
        for m=1:28
            test(28*m-27:m*28,index)=double(rim(:,m))./128-1;
        end
%         test(:,index)=(imresize(im ,[size(basis,1) 1]));
        correct(index)=mod(digitStruct(i).bbox(j).label,10);
%         fprintf('%d\n',digitStruct(i).bbox(j).label );

    end
end

mu=mean(test,2);
weights=basis(:,1:n)'*(test-mu*ones(1,size(test,2)));
guess=zeros(size(test,2),1);
for i=1:size(test,2)
    distance=[zeros(1,size(training,2));labels'];
    for j=1:size(training,2)
        distance(1,j)=norm(training(:,j)-weights(:,i));
    end
%     distance=vecnorm(training-(weights(:,i)*ones(1,size(training,2))),2,1)
    [~,permutation]=sort(distance(1,:));
    distance=distance(:,permutation);
    guess(i)=mode(distance(2,1:k));
    if(mod(i,24)==0)
        disp(i)
    end
end

resultdigit=guess-correct;
disp(nnz(resultdigit)/size(correct,1))
resultnumber=zeros(size(countdigits,1),1);
for i=1:size(countdigits)
    resultnumber(i)=countdigits(i)-nnz(resultdigit(sum(countdigits(1:i))-countdigits(i)+1:sum(countdigits(1:i))));
end
disp(1-sum(resultnumber==countdigits)/300)
find(resultnumber==countdigits,9)