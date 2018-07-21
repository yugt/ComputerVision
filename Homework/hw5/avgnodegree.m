function deg = avgnodegree(adjacency)
assert(issymmetric(adjacency));
deg=nnz(adjacency)/size(adjacency,1);