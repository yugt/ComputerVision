% jason corso; EECS 442; 504
%
% assume we have X and Y

% E = sum_i [ y_i - [x_i.^2 x_i 1] [a;b;c] ]

A = [X.^2 X ones(length(X),1)];
B = inv(A'*A)*A'*Y;

x = [1:0.25:10];
y = B(1)*x.^2 + B(2)*x + B(3); % The fitted curve (a parabola)

plot(X,Y,'b+'); hold on;
plot(x,y,'r'); hold off;

% set axis by force
axis([0 10 0 10]);
