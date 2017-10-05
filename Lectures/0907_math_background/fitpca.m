%
% jason corso; EECS 442; 504
% Byungsu Min
%
% assume we have X and Y

% Each column of D indicates a point
D = [X Y]';

% first we have to make a data matrix from all of the points
% x is just 2D mean of given points
x = sum(D,2)/size(D,2);
DMinusMean = D - x*ones(1, size(D,2));
Dscatter = DMinusMean*DMinusMean';
size(Dscatter)

% V is left singular matrix (so, every column is an eigenvector of A)
[V,v] = eigs(Dscatter,2);
v

m1 = V(1,2)/V(1,1); % Slope of major axis
m2 = V(2,2)/V(2,1); % Slope of minor axis

% y-intercept of each axis
b1 = x(2) - x(1)*m1;
b2 = x(2) - x(1)*m2;

plot(X,Y,'b+'); hold on;
plot([0; 10],[b1,m1*10+b1],'r');
plot([0; 10],[b2,m2*10+b2],'r'); hold off;
