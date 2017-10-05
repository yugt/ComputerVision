% assume we have X and Y
%
% jason corso; EECS 442; 504
% fitline script

% E = sum_i [ y_i - [x_i 1] [m;b] ]

% Set up the data matrix
A = [X ones(length(X),1)];

% Solve by the Moore-Penrose Pseudoinverse
B = inv(A'*A)*A'*Y;

% The fitted line is: y=mx+b
m = B(1);
b = B(2);

% Plot the result
plot(X,Y,'b+'); hold on;
plot([0; 10],[b,m*10+b],'r'); hold off;
