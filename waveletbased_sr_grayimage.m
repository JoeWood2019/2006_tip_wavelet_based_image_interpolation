function [ output_image ] = waveletbased_sr_grayimage( input_image,k )
% 输入：input_image (灰度图像); 放大倍数 k ; 输出：output_image 灰度图像

% sX=size(input_image);
% 
% % [swa,swh,swv,swd]= swt2(input_image,1,'bior4.4');
% % figure(2);
% % subplot(2,2,1);imshow(uint8(swa/2));title('LL band of image');
% % subplot(2,2,2);imshow(swh);title('LH band of image');
% % subplot(2,2,3);imshow(swv);title('HL band of image');
% % subplot(2,2,4);imshow(swd);title('HH band of image');
% 
% % X = idwt2(swa,swh,swv,swd,'db1',sX);
% % result = uint8(X);
% % figure;
% % imshow(result);
% 
% 
% [LL,LH,HL,HH]=dwt2(input_image,'haar');%bior4.4
% % figure(3);
% % subplot(2,2,1);imshow(uint8(LL/2));title('LL band of image');
% % subplot(2,2,2);imshow(LH);title('LH band of image');
% % subplot(2,2,3);imshow(HL);title('HL band of image');
% % subplot(2,2,4);imshow(HH);title('HH band of image');
% 
% % X = idwt2(LL,LH,HL,HH,'haar',sX);
% % result = uint8(X);
% % figure;
% % imshow(result);
% 
% % image_interp = imresize(input_image,2,'bicubic');
% % figure;
% % imshow(image_interp);
% 
% band_size = size(LL);
% band_size = band_size*k;
% % LH_interp = double(imresize(LH,band_size,'bicubic') + imresize(swh,band_size,'bicubic'))/2;%
% % HL_interp = double(imresize(HL,band_size,'bicubic') + imresize(swv,band_size,'bicubic'))/2;%
% % HH_interp = double(imresize(HH,band_size,'bicubic') + imresize(swd,band_size,'bicubic'))/2;%/2
% % LL_interp = double(imresize(input_image,band_size,'bicubic'))*2;
% 
% LH_interp = double(imresize(LH,band_size,'bicubic'));
% HL_interp = double(imresize(HL,band_size,'bicubic'));
% HH_interp = double(imresize(HH,band_size,'bicubic'));
% LL_interp = double(imresize(LL,band_size,'bicubic'));
% 
% % figure;
% % imshow(uint8(LL_interp/2));
% 
% SX_interp = sX;
% SX_interp(1) = SX_interp(1)*k;
% SX_interp(2) = SX_interp(2)*k;
% 
% output_image = idwt2(LL_interp,LH_interp,HL_interp,HH_interp,'haar',SX_interp);
%%
f_initial = imresize(input_image,k,'bicubic');
gu_hor_init = gu_initial( input_image, 'hor');
gu_ver_init = gu_initial( input_image, 'ver');

for i=1:10
    
end

end

