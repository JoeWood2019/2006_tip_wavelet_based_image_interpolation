clear all;
close all;
clc;

k=2;%放大倍数
%% 输入图像
image_gnd = imread('gnd.bmp');
gnd_size = size(image_gnd);
image = zeros([gnd_size(1:2)/k,gnd_size(3)]);
image_size_gray = size(image(:,:,1));
image_gnd_ycbcr = rgb2ycbcr(uint8(image_gnd));
image_gnd_gray= image_gnd_ycbcr(:,:,1);
for i=1:3
    image(:,:,i) = imresize(image_gnd(:,:,i),image_size_gray);
end
image_ycbcr = rgb2ycbcr(uint8(image));
input_image = image_ycbcr(:,:,1);
% figure(1);
% imshow(uint8(input_image));

% Y = waveletbased_sr_grayimage( input_image,k );
%% 小波和小波逆变换测试
scale = 1;
% fu = wavelet1_scale_func( input_image(1,:),scale );
% gu = wavelet1_wavelet_func(input_image(1,:),scale );
% f_inv = wavelet1_inverse_func(gu,fu,scale);

% a=wavelet1_scale_func( input_image(1,:),scale-1 );
% figure;
% subplot(2,1,1);
% plot(a);
% subplot(2,1,2);
% plot(f_inv);

% [ fu,gu_hor,gu_ver] = wavelet2_forward(input_image,scale );
% image_out = wavelet2_inverse( fu,gu_hor,gu_ver,scale );
% figure;
% imshow(uint8(image_out));
% imwrite(uint8(image_out),'h1_changed_nolamda.png','png');
%% tip2006方法测试
% gu_hor_init = gu_initial( input_image, 'hor');

% tic;
% result = waveletbased_sr_grayimage( input_image,k );
% toc;
% display(toc - tic);
% figure;
% imshow(input_image);
% figure;
% imshow(result);
% figure;
% imshow(image_gnd_gray);

%% 尝试MATLAB自带swt

% wname = 'rbio2.2';
% [Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wname); 
% subplot(221); stem(Lo_D); 
% title('Decomposition low-pass filter'); 
% subplot(222); stem(Hi_D); 
% title('Decomposition high-pass filter'); 
% subplot(223); stem(Lo_R); 
% title('Reconstruction low-pass filter'); 
% subplot(224); stem(Hi_R); 
% title('Reconstruction high-pass filter'); 

[swa,swh,swv,swd]= swt2(input_image,1,'rbio2.2');
figure;
subplot(2,2,1);imshow(uint8(swa/2));title('LL band of image');
subplot(2,2,2);imshow(swh);title('LH band of image');
subplot(2,2,3);imshow(swv);title('HL band of image');
subplot(2,2,4);imshow(swd);title('HH band of image');% 

