% get the data and plot it (this has nothing to do with the line fit)
%
% jasoncorso; EECS 442, 504

n=10;
fprintf('click on %d points on the line\n',n);
figure; axis([0 10 0 10]); drawnow;
X = zeros(n,1);
Y = zeros(n,1);
for i=1:n
    [X(i) Y(i)] = ginput(1);
    hold off;
    plot(X(1:i),Y(1:i),'b+');
    axis([0 10 0 10]);
    hold on;
end
