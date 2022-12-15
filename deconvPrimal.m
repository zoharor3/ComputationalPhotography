function est_x=deconvPrimal(y,k,eta,sigma,is_cyclic)
% Primal deconvolution function est_x=deconvPrimal(y,k,eta,sigma,is_cyclic) where y is an m × n
% image and η and σ are scalars as defined above. is_cyclic is a binary variable denoting if convolution with
% k, gx, gy are cyclic or not. For is_cyclic=0 and a filter of size mf , nf the convolution uses only m−mf +1×
% n − nf + 1 central pixels, and for is_cyclic=1 the convolution uses n × m pixels.
% The OUTPUT is the deblurred image of size m × n.

[m,n] = size(y);

% prior
gx = [-1 ,1];
gy = [-1,1].';

% derivative matrices
Gx = sparse(getConvMat(gx, m, n, is_cyclic));
Gy = sparse(getConvMat(gy, m, n, is_cyclic));

% convolution matrix
A = sparse(getConvMat(k, m, n, is_cyclic));

% Utillity calculations
GxtGx = sparse(Gx.'*Gx);
GytGy = sparse(Gy.'*Gy);
AtA = sparse(A.'*A);
P = sparse((AtA+(eta/sigma)^2*(GxtGx+GytGy)));

% column stack
Ycs = sparse(y(:));

% solving the linear system equations
est_x = full(reshape(sparse(P\(A.'*Ycs)), m,n));