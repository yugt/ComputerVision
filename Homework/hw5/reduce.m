function segments = reduce(image, segments, segmentimage)

% function segments = reduce(image,segments, segmentimage)
%
%     EECS 442 Computer Vision;
%     Jason Corso
%
% Wrapper for function to compute feature descriptors on the segments
%

bins = 10;

for i=1:length(segments)

    segments(i).fv = histvec(image,segmentimage==i,bins);

end

