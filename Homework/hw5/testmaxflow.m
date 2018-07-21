% test maxflow

nnodes = 8;
capacity = zeros(nnodes);

source = 7;
sink = 8;

capacity(source,1) = 5;
capacity(source,2) = 4;
capacity(source,3) = 9;
capacity(1,2) = 3;
capacity(1,4) = 2;
capacity(1,5) = 1;
capacity(2,1) = 2;
capacity(2,3) = 2;
capacity(2,5) = 6;
capacity(2,6) = 5;
capacity(3,2) = 5;
capacity(3,6) = 6;
capacity(4,5) = 2;
capacity(6,5) = 3;
capacity(6,2) = 1;
capacity(4,sink) = 6;
capacity(5,sink) = 8;
capacity(6,sink) = 5;

[max_flow,current_flow] = ff_max_flow(source,sink,capacity,nnodes)

saturated = (capacity ~= 0) & ((capacity-current_flow)==0);
[a,b] = find(saturated);