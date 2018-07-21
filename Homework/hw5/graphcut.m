function [B] = graphcut(segmentimage,segments,keyindex)

% function [B] = graphcut(segmentimage,segments,keyindex
%
%     EECS 442 Computer Vision;
%     Jason Corso
%
% Function to take a superpixel set and a keyindex and convert to a 
%  foreground/background segmentation.
%
% keyindex is the index to the superpixel we wish to use as foreground and
% find its relevant neighbors that would be in the same macro-segment
%
% Similarity is computed based on segments(i).fv (which is a color histogram)
%  and spatial proximity.
%
% segmentimage and segments are returned by the superpixel function
%  segmentimage is called S and segments is called Copt  
%
% OUTPUT:  B is a binary image with 1's for those pixels connected to the
%          source node and hence in the same segment as the keyindex.
%          B has 0's for those nodes connected to the sink.

% compute basic adjacency information of superpixels
%%%%  Note that segNeighbors is code you need to implement
adjacency = segNeighbors(segmentimage);
%debug
%figure; imagesc(adjacency); title('adjacency');

% normalization for distance calculation based on the image size
% for points (x1,y1) and (x2,y2), distance is
% exp(-||(x1,y1)-(x2,y2)||^2/dnorm)
dnorm = 2*prod(size(segmentimage)/2)^2;
% thinking of this like a Gaussian and considering the Std-Dev of the Gaussian 
% to be roughly half of the total number of pixels in the image.  Just a guess

k = length(segments);

capacity = zeros(k+2,k+2);  % initialize the zero-valued capacity matrix
source = k+1;  % set the index of the source node
sink = k+2;    % set the index of the sink node

% this is a single planar graph with an extra source and sink
%
% Capacity of a present edge in the graph (adjacency) is to be defined as the product of
%  1:  the histogram similarity between the two color histogram feature vectors.
%      use the provided histintersect function below to compute this similarity 
%  2:  the spatial proximity between the two superpixels connected by the edge.
%      use exp(-D(a,b)/dnorm) where D is the euclidean distance between superpixels a and b,
%      dnorm is given above.
%
% source gets connected to every node except sink
%  capacity is with respect to the keyindex superpixel
% sink gets connected to every node except source; 
%  capacity is opposite that of the corresponding source-connection (from each superpixel)
%  in our case, the max capacity on an edge is 3; so, 3 minus corresponding capacity
% 
% superpixels get connected to each other based on computed adjacency matrix
%  capacity defined as above. EXCEPT THAT YOU ALSO NEED TO MULTIPLY BY A SCALAR 0.25 for
%  adjacent superpixels.


%%% IMPLEMENT CODE TO fill in the capacity values using the description above.

%debug
%figure; imagesc(capacity); title('capacity');

for i=1:k
    for j=i+1:k
        if adjacency(i,j)>0
            capacity(i,j)=histintersect(segments(i).fv,segments(j).fv)*exp(-D(i,j)/dnorm)/4;
        end
    end
end
capacity=capacity+capacity';

for i=1:k
    capacity(source,i)=histintersect(segments(keyindex).fv,segments(i).fv)...
    *exp(-D(keyindex,i)/dnorm);
end

for i=1:k
    capacity(i,sink)=3-capacity(source,i);
end

    function d=D(a,b)
        dx=segments(a).x_sub-segments(b).x_sub;
        dy=segments(a).y_sub-segments(b).y_sub;
        d=sqrt(dx^2+dy^2);
    end

% x=load('capacity.mat');
% ans=x.capacity-capacity;

% figure
% imagesc(capacity);

% compute the cut (this code is provided to you)
[~,current_flow] = ff_max_flow(source,sink,capacity,k+2);

% extract the two-class segmentation.
%  the cut will separate all nodes into those connected to the
%   source and those connected to the sink.
%  The current_flow matrix contains the necessary information about
%   the max-flow through the graph.
%
% Populate the binary matrix B with 1's for those nodes that are connected
%  to the source (and hence are in the same big segment as our keyindex) in the
%  residual graph.
% 
% You need to compute the set of reachable nodes from the source.  Recall, from
%  lecture that these are any nodes that can be reached from any path from the
%  source in the graph with residual capacity (original capacity - current flow) 
%  being positive.

%%%  IMPLEMENT code to read the cut into B

residual=(capacity-current_flow);
spixels=find(residual(source,:)>0)';
residual=residual(1:k,1:k);
count=length(spixels);
while(true)
    for i=1:length(spixels)
        spixels=unique([spixels; find(residual(spixels(i),:)>0)']);
    end
    if count<length(spixels)
        count=length(spixels);
    else
        break
    end
end

B=zeros(size(segmentimage));
for i=1:length(spixels)
    B=B+(segmentimage==spixels(i));
end
B=(B>0);

end




function c = histintersect(a,b)
    c = sum(min(a,b));
end
