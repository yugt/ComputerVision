%%%%%%%%% Training part %%%%%%%%%%%
images = loadMNISTImages('train-images-idx3-ubyte');
labels = loadMNISTLabels('train-labels-idx1-ubyte');
 
% We are using display_network from the autoencoder code
% display_network(images(:,1:400)); % Show the first 100 images
% disp(labels(1:20));

n=10;
k=10;
mu=mean(images,2);
[basis,eval]=eig(images*images');
[eval,permutation]=sort(diag(eval),'descend');
basis=basis(:,permutation);
% display_network(basis(:,1:10));
basis=normc(basis);
training=basis(:,1:n)'*(images-mu*ones(1,size(images,2)));
reconstruct=basis(:,1:n)*training+mu*ones(1,size(training,2));
% display_network(reconstruct(:,1:100));