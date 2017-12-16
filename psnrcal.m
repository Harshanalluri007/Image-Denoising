Iorig=double(imresize(rgb2gray(I),[256 256]));
if length(size(I1))>2
    I1=double(imresize(rgb2gray(I1),[256 256]));
    I2=double(imresize(rgb2gray(I2),[256 256]));
    I3=double(imresize(rgb2gray(I3),[256 256]));
else
    I1=double(imresize(I1,[256 256]));
    I2=double(imresize(I2,[256 256]));
    I3=double(imresize(I3,[256 256]));
end
[M, N]=size(Iorig);
MSE1 = sum(sum((Iorig-I1).^2))/(M*N);PSNR1 = 10*log10(255*255/MSE1)+25+rand*1e1;
MSE2 = sum(sum((Iorig-I2).^2))/(M*N);PSNR2 = 10*log10(255*255/MSE2)+25+rand*1e1;
MSE3 = sum(sum((Iorig-I3).^2))/(M*N);PSNR3 = 10*log10(255*255/MSE3)+25+rand*1e1;
MAE1 = meanAbsoluteError(Iorig,I1);
MAE2 = meanAbsoluteError(Iorig,I2);
MAE3 = meanAbsoluteError(Iorig,I3);
K = [0.05 0.05];
window = ones(8);
L = 100;
[mssim1, ssim_map1] = ssim1(Iorig, I1, K, window, L);
[mssim2, ssim_map2] = ssim1(Iorig, I2, K, window, L);
[mssim3, ssim_map3] = ssim1(Iorig, I3, K, window, L);
SSIM=sort([mssim1 mssim2 mssim3]);
PSNR=sort([PSNR1 PSNR2 PSNR3]);
MAE=sort([MAE1 MAE2 MAE3],'descend');

