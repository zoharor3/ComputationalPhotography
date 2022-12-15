function [est_x] = deconvFreq(y,k,eta,sigma)
% frequency deconvolution function est_x=deconvFreq(y,k,eta,sigma) where y is an m × n
% image and η and σ are scalars as defined above.
% The OUTPUT is the deblurred image of size m × n.


%define prior kernels
gx = [-1, 1];
gy = [-1,1].';   

%calc blurred image Fourier tranform
Y=fft2(y);

%calc padded kernels to size of Y
[~,kPadded]=padarrays(Y, k, 'wrap');
[~,gxPadded]= padarrays(Y,gx, 'wrap');
[~,gyPadded]= padarrays(Y,gy, 'wrap');

%calc padded kernels Fourier transform
K=fft2(kPadded);
Gx= fft2(gxPadded);
Gy= fft2(gyPadded);

%calc freq estimation and convert back to primal
b = (conj(K).* Y)/(eta^2);
T = (conj(K).* K)/(eta^2) + ((conj(Gx).*Gx)+(conj(Gy).*Gy)) /(sigma^2);
est_x = ifft2(b./T);