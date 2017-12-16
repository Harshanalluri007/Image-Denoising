
fp=uigetfile('*.tiff');
I=imread(fp);
% if length(size(I))>2
%     I=rgb2gray(I);
% end

Iimnoise = imnoise(I,'gaussian');
[m, n, p]=size(I);
for i=1:m
    for j=1:n
        for k=1:p
        if Iimnoise(i,j,k)>0 || Iimnoise(i,j,k)<40
            Ic(i,j,k)=Iimnoise(i,j,k);
        else
            Ic(i,j,k)=0;
        end
        if Iimnoise(i,j,k)>40 || Iimnoise(i,j,k)<125
            Ib(i,j,k)=Iimnoise(i,j,k);
        else
            Ib(i,j,k)=0;
        end
        if Iimnoise(i,j,k)>125 || Iimnoise(i,j,k)<255
            Ia(i,j,k)=Iimnoise(i,j,k);
        else
            Ia(i,j,k)=0;
        end
        end
    end
end


figure
subplot 221;imshow(Iimnoise)
subplot 222;imshow(edge(rgb2gray(Ia),'sobel'));
subplot 223;imshow(edge(rgb2gray(Ib),'sobel'));
subplot 224;imshow(edge(rgb2gray(Ic),'sobel'));



figure;
subplot(221);imshow(I);title('Input Image');
J1 = impulsenoise(I,10);
J2 = impulsenoise(I,10);
J3 = impulsenoise(I,10);

I1 = SADCT(J2);
subplot(222);imshow(I1);title('SA DCT');
I2=BM3D(J3);
subplot(223);imshow(I);title('BM3D');
I3 = Proposed(J3);
subplot(224);imshow(I3);title('Proposed');



psnrcal

disp('-----------------------------------')
disp('Method      PSNR    MAE     SSIM   ')
disp('----------------------------------')
fprintf('SA-DCT      %.2f   %.2f   %.2f\n',PSNR(1),MAE(1),SSIM(1));
fprintf('BM3D        %.2f   %.2f   %.2f\n',PSNR(2),MAE(2),SSIM(2));
fprintf('Proposed    %.2f   %.2f   %.2f\n',PSNR(3),MAE(3),SSIM(3));
disp('-----------------------------------')


