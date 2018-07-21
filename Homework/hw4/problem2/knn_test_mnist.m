%%%%%%%%% Testing on Training Dataset MNIST %%%%%%%%%%%
test=images(:,1:500);
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
end
fprintf('error rate on MNIST is %d\n',nnz(guess-labels(1:size(test,2)))/size(test,2))
