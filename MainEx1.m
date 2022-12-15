load('data.mat');
%% Analysis
% section 1
% estimating the variance of the derivatives, sigma
gx=conv2(x,[-1, 1],'same');
gy=conv2(x,[-1; 1],'same');
sigma = sqrt(0.5*(mean(gy.^2,"all") + mean(gx.^2, "all")));

% estimating the variance of the image noise, eta
eta1 = std(conv2(x, k1, "valid")-y1, 1, 'all');
eta2 = std(conv2(x, k2, "valid")-y2, 1, 'all');
eta3 = std(conv2(x, k3, "valid")-y3, 1, 'all');
eta = mean([eta1, eta2, eta3]);

%% section 2 
% debluring the images
% section 2.1
% deconvolution in the primal domain

% primal domain with is_cyclic=0:
is_cyclic = 0;
im111 = deconvPrimal(y1, k1, eta, sigma, is_cyclic);
im112 = deconvPrimal(y2, k2, eta, sigma, is_cyclic);
im113 = deconvPrimal(y3, k3, eta, sigma, is_cyclic);

% primal domain with is_cyclic=1:
is_cyclic = 1;
im121 = deconvPrimal(y1, k1, eta, sigma, is_cyclic);
im122 = deconvPrimal(y2, k2, eta, sigma, is_cyclic);
im123 = deconvPrimal(y3, k3, eta, sigma, is_cyclic);

% frequency domain:
im131 = deconvFreq(y1, k1, eta, sigma);
im132 = deconvFreq(y2, k2, eta, sigma);
im133 = deconvFreq(y3, k3, eta, sigma);


%% create the image array 
imArray1 = [y1, y2, y3; ...
            im111, im112, im113; ...
            im121, im122, im123; ...
            im131, im132, im133];

%% show and save the results
figure;
imshow(imArray1);
imwrite(imArray1, 'ex1_q2.png');
%% section 3
% deblurring with diffrenet kernels

% Image 1
im211 = deconvPrimal(y1, k1, eta, sigma, 0);
im212 = deconvPrimal(y1, k2, eta, sigma, 0);
im213 = deconvPrimal(y1, k3, eta, sigma, 0);

% Image 2
im221 = deconvPrimal(y2, k1, eta, sigma, 0);
im222 = deconvPrimal(y2, k2, eta, sigma, 0);
im223 = deconvPrimal(y2, k3, eta, sigma, 0);

% Image 3
im231 = deconvPrimal(y3, k1, eta, sigma, 0);
im232 = deconvPrimal(y3, k2, eta, sigma, 0);
im233 = deconvPrimal(y3, k3, eta, sigma, 0);

% Create the image array and save the result
imArray2 = [im211, im212, im213; ...
            im221, im222, im223; ...
            im231, im232, im233];

figure;
imshow(imArray2);
imwrite(imArray2, 'ex1_q3.png');

%% section 4 
% deblurring with different etas

% image 1 with kernel 1
im311 = deconvPrimal(y1, k1, 10 * eta, sigma, 0);
im312 = deconvPrimal(y1, k1, eta, sigma, 0);
im313 = deconvPrimal(y1, k1, 0.1 * eta, sigma, 0);

% image 2 with kernel 2
im321 = deconvPrimal(y2, k2, 10 * eta, sigma, 0);
im322 = deconvPrimal(y2, k2, eta, sigma, 0);
im323 = deconvPrimal(y2, k2, 0.1 * eta, sigma, 0);

% image 3 with kernel 3
im331 = deconvPrimal(y3, k3, 10 * eta, sigma, 0);
im332 = deconvPrimal(y3, k3, eta, sigma, 0);
im333 = deconvPrimal(y3, k3, 0.1 * eta, sigma, 0);

% create the image array and save the result
imArray3 = [im311, im312, im313; ...
            im321, im322, im323; ...
            im331, im332, im333];

figure;
imshow(imArray3);
imwrite(imArray3, 'ex1_q4.png');