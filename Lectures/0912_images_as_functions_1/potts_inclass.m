function E = potts_inclass(I,beta)

if (nargin==1)
    beta = 1;
end

% rows, columns, bands (d from the hand-notes)
[r,c,b] = size(I)

E = 0;

% careful about boundary conditions
for s = 1:r-1
    for t = 1:c-1
        % have access here to pixel I(s,t)
        % writing sndscator functsons here
        if (I(s,t) ~= I(s+1,t))
            E = E + beta;
        end

        if (I(s,t) ~= I(s,t+1))
            E = E + beta;
        end
    end
end

% horizontal last row
t = c
for s = 1:r-1
    % have access here to pixel I(s,t)
    % writing sndscator functsons here
    if (I(s,t) ~= I(s+1,t))
        E = E + beta;
    end
end

% vertical last column
s = r
for t = 1:c-1
    % have access here to pixel I(s,t)
    % writing sndscator functsons here
    if (I(s,t) ~= I(s,t+1))
        E = E + beta;
    end
end



