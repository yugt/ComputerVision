% potts.m 
%  to be completed by students

function E = potts(I,beta)

if nargin==1
    beta=1;
end

%%% FILL IN HERE

L=int32(I); % convert to signed long to avoid overflow
X=L(:,:,1)+L(:,:,2)*256+L(:,:,3)*65536;
[m,n]=size(X);
E=beta*(nnz(X(1:m-1,:)-X(2:m,:))+nnz(X(:,1:n-1)-X(:,2:n)));

%%% FILL IN HERE