 
function Iout = impulsenoise(img,sigma_n)
Io=im2double(img);
%add noise
% sigma_n=20; %noise std. dev.
rand('seed', 0);
Iout=Io+sigma_n/255*randn(size(Io));
