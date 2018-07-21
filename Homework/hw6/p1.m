% HW6, EECS 442 by Jason Corso
% Kyle Min (kylemin@umich.edu)
% let's implement the simple 2-layer nn
% just fill in the blanks

% to reproduce the same result
rng(0);

% load the data
if ~exist('data', 'var')
    data = loadMNISTImages('data/train-images.idx3-ubyte');
    labels = loadMNISTLabels('data/train-labels.idx1-ubyte') + 1;
    tdata = loadMNISTImages('data/t10k-images.idx3-ubyte');
    tlabels = loadMNISTLabels('data/t10k-labels.idx1-ubyte') + 1;
    
    rp = randperm(size(data, 2));
    data = data(:, rp(1:10000));
    labels = labels(rp(1:10000));
    
    trp = randperm(size(tdata, 2));
    tdata = tdata(:, trp(1:1000));
    tlabels = tlabels(trp(1:1000));
end

% network setting
[dim, num_data] = size(data);
[~, num_tdata] = size(tdata);
num_epoch = 100;
batch_size = 500;
num_hidden_1 = 50;
num_output = 10;

% basic setting
% xaxier's method
r1 = sqrt(6) / sqrt(dim + num_hidden_1);
w1 = rand(num_hidden_1, dim)*2*r1 - r1;
b1 = zeros(num_hidden_1, 1);

r2 = sqrt(6) / sqrt(num_hidden_1 + num_output);
w2 = rand(num_output, num_hidden_1)*2*r2 - r2;
b2 = zeros(num_output, 1);

lr_w = 2; % learning rate for w term
lr_b = 2; % learning rate for b term
gam = 0.5;

% loss/acc history
loss_list = zeros(num_epoch, 1);
acc_list = zeros(num_epoch, 1);
tloss_list = zeros(num_epoch, 1);
tacc_list = zeros(num_epoch, 1);

for i = 1 : num_epoch
    rp = randperm(num_data);
    
    for j = 1 : batch_size : (num_data - batch_size + 1)
        % random batch
        x = data(:, rp(j:j+batch_size-1));
        l = labels(rp(j:j+batch_size-1));
        
        %%%%%%%%%%%%%%
        % feed forward
        %%%%%%%%%%%%%%
        
        % FILL THIS UP WITH YOUR CODE
        % get the output of the first layer with sigmoid activation function
        % the output of the second layer should only be activated with exp()
        f1 = sigmoid(w1*x+b1); % 50 x 500 matrix
        f2 = exp(w2*f1+b2);    % 10 x 500 matrix
        % FILL THIS UP WITH YOUR CODE
        
        % FILL THIS UP WITH YOUR CODE
        % get the score
        % each row vector should indicate the probability for each digit
        s = f2./sum(f2);      % 10 x 500 matrix
        % FILL THIS UP WITH YOUR CODE
        
        % compute the error
        I = sub2ind(size(s), l', 1:batch_size);
        p = zeros(size(s));
        p(I) = 1; % assign 1 only on where 'labels' indicate
        err2 = (s - p)/batch_size;
        
        %%%%%%%%%%%%%%%%%%
        % back propagation
        %%%%%%%%%%%%%%%%%%
        
        grad2_w = err2 * f1';
        grad2_b = sum(err2, 2);
        c1 = w2' * err2;
        err1 = c1 .* f1 .* (1-f1);
        
        grad1_w = err1 * x';
        grad1_b = sum(err1, 2);
        
        % FILL THIS UP WITH YOUR CODE
        % update the weights.
        % each weight and bias should be updated
        % with its gradient and lr_w and lr_b
        w2 = w2-lr_w*grad2_w;
        b2 = b2-lr_b*grad2_b;
        w1 = w1-lr_w*grad1_w;
        b1 = b1-lr_b*grad1_b;
        % FILL THIS UP WITH YOUR CODE
    end
    
    % decay
    if ~mod(i, 40)
        lr_w = lr_w * gam;
        lr_b = lr_b * gam;
    end
    
    % FILL THIS UP WITH YOUR CODE
    % record the training loss and accuracy
    loss_list(i) = -sum(log(s(I)))/batch_size;
    [~, pred_labels] = max(s);
    acc_list(i) = nnz(l==pred_labels')/batch_size;
    % FILL THIS UP WITH YOUR CODE
    
    
    % FILL THIS UP WITH YOUR CODE
    % get the test output
    tf1 = sigmoid(w1*tdata+b1);
    tf2 = exp(w2*tf1+b2);
    ts = tf2./sum(tf2);
    % FILL THIS UP WITH YOUR CODE
    
    % get the test result and record it
    I = sub2ind(size(ts), tlabels', 1:num_tdata);
    tloss_list(i) = -sum(log(ts(I)))/num_tdata;
    [~, tpred_labels] = max(ts);
    
    % FILL THIS UP WITH YOUR CODE
    % record the test accuracy
    tacc_list(i) = nnz(tpred_labels==tlabels')/num_tdata;
    % FILL THIS UP WITH YOUR CODE
end

plot(1:num_epoch, loss_list, 'b-'); hold on;
plot(1:num_epoch, tloss_list, 'r-');
xlabel('Iteration'); ylabel('loss');
legend('training', 'test'); figure;
plot(1:num_epoch, acc_list, 'b-'); hold on;
plot(1:num_epoch, tacc_list, 'r-');
xlabel('Iteration'); ylabel('accuracy');
legend('training', 'test');
