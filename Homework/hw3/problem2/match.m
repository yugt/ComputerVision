function M = match(F1,F2,k)

% function M = match(F1,F2,k)
%
%     EECS 442;
%     Jason Corso
%
% Wrapper for function to matching extracted feature vectors from a pair
%  of images
%
%  F1 is the feature matrix (rows -dimensions and cols number of points)
%       from image 1
%  F2 feature matrix from image 2
%  k is the number of matches to take (optional)
%
%  M is a k x 2 matrix where k is the number of matches and the first col
%    is the index of the match in F1 and the second col in F2

if nargin==2
    k=12;
end

n1 = size(F1,2);
n2 = size(F2,2);

n = max(n1,n2);
C = zeros(n,n);

for i=1:n1
   C(i,1:n2) = distance(F1(:,i),F2); 
end

A = hungarian(C);
D = ones(n1,1);
I = ones(n1,1);
for i=1:n1
    I(i) = A(i);
    D(i) = C(i,A(i));
end

%for i=1:n1
%   [I(i),D(i)] = matchsingle(F1(:,i),F2);
%end

% now, rank and take just the top $k=5$
[Ds,Di] = sort(D,'ascend');

M=zeros(k,2);
for i=1:k
    M(i,1) = Di(i);
    M(i,2) = I(Di(i));
end



function D = distance(f,F)

n = size(F,2);

ff = repmat(f,[1,n]);

D = ff-F;
D = D.*D;

D = sum(D,1);
D = sqrt(D);



function [m,d] = matchsingle(f,F)

% function [m,d] = matchsingle(f,F)
%
% Wrapper for function to matching an feature vector to a feature matrix
%
%  f is the vector 
%  F is the matrix
%
% m is the matched index
% d is the distance for the match

n = size(F,2);

ff = repmat(f,[1,n]);

D = ff-F;
D = D.*D;

D = sum(D,1);
D = sqrt(D);

[d,m] = min(D);

