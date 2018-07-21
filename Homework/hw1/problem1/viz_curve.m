function viz_curve(C,Xo,Yo)

% input coefficients C  Y=C(1)*X.^n + C(2)*X.^(n-1) +...+ C(n)*X + C(n+1)
% X,Y are original input samples that will be plotted as plusses
%
% jason corso; EECS442, Fall2017

figure;
plot(Xo,Yo,'b+')

X = [1:0.25:10];
Y = zeros(1,length(X));
order = length(C)-1;
for i = 1:length(C)
    Y = Y + C(i)*X.^order;
    order = order - 1;
end
hold on
plot(X,Y,'r')
title(sprintf("order = %d", length(C)-1))

% set axis by force
axis([0 10 0 10]);
