function Bmap = segNeighbors(svMap)

%%% function Bmap = segNeighbors(svMap)
%  EECS 442 Computer Vision
%
%  Implement the code to compute the adjacency matrix for the superpixel graph
%  captured by svMap
%
%  INPUT:  svMap is an integer image with the value of each pixel being
%           the id of the superpixel with which it is associated
%  OUTPUT: Bmap is a binary adjacency matrix NxN (N being the number of superpixels
%           in svMap).  Bmap has a 1 in cell i,j if superpixel i and j are neighbors.
%           Otherwise, it has a 0.  Superpixels are neighbors if any of their
%           pixels are neighbors.

segmentList = unique(svMap);
segmentNum = length(segmentList);

%%%% IMPLEMENT the calculation of the adjacency

Bmap=zeros(segmentNum,segmentNum);

[row,col]=find(diff(svMap)~=0);
% assert(max(row)<size(svMap,1));
for i=1:length(row)
    Bmap(svMap(row(i),col(i)),svMap(row(i)+1,col(i)))=1;
end
[row,col]=find(diff(svMap,1,2)~=0);
% assert(max(col)<size(svMap,2));
for i=1:length(row)
    Bmap(svMap(row(i),col(i)),svMap(row(i),col(i)+1))=1;
end
[row,col]=find(svMap(1:size(svMap,1)-1,1:size(svMap,2)-1)...
    -svMap(2:size(svMap,1),2:size(svMap,2))~=0);
for i=1:length(row)
    Bmap(svMap(row(i),col(i)),svMap(row(i)+1,col(i)+1))=1;
end
[row,col]=find(svMap(1:size(svMap,1)-1,2:size(svMap,2))...
    -svMap(2:size(svMap,1),1:size(svMap,2)-1)~=0);
for i=1:length(row)
    Bmap(svMap(row(i)+1,col(i)),svMap(row(i),col(i)+1))=1;
end
Bmap=(Bmap+Bmap')>0;