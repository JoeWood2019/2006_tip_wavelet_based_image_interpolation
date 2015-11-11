function [ output_image ] = waveletbased_sr_grayimage( input_image,k )
% 输入：input_image (灰度图像); 放大倍数 k ; 输出：output_image 灰度图像

% sX=size(input_image);
% 
% [swa,swh,swv,swd]= swt2(input_image,1,'bior4.4');
% % figure(2);
% % subplot(2,2,1);imshow(uint8(swa/2));title('LL band of image');
% % subplot(2,2,2);imshow(swh);title('LH band of image');
% % subplot(2,2,3);imshow(swv);title('HL band of image');
% % subplot(2,2,4);imshow(swd);title('HH band of image');% 
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
input_image = double(input_image);
fu_initial = imresize(input_image,k,'bicubic');
[gu_hor_init,gu_hor_init_map] = gu_initial( input_image, 'hor');
[gu_ver_init,gu_ver_init_map] = gu_initial( input_image, 'ver');
%% ps bound
f_gradient = image_gradient(double(input_image));
w=[0.25,0.5,0.25;0.5,1,0.5;0.25,0.5,0.25];
f_bicubic = imresize(double(input_image),2,'bicubic');
% f_grad_up = upsample(f_gradient,2);
f_grad_up = imresize(f_gradient,2,'box');%fu梯度的上采样
ps_bias = imfilter(f_grad_up,w);
% fu_lo = f_bicubic - abs(ps_bias);
% fu_ho = f_bicubic + abs(ps_bias);
fu_lo = f_bicubic - ps_bias;
fu_ho = f_bicubic + ps_bias;
%% pocs_num loop
[m,n]= size(fu_initial);
pocs_num = 1;
for i=1:pocs_num
    %% pv
    temp = wavelet2_inverse(fu_initial,gu_hor_init,gu_ver_init,1);
    [fu_next,gu_hor_next,gu_ver_next] = wavelet2_forward(temp,1);
    %% ps
%     fu_next = fu_next.*((fu_next - fu_lo) > 0) + fu_lo.*((fu_next - fu_lo) <= 0);
%     fu_next = fu_next.*((fu_next - fu_ho) < 0) + fu_ho.*((fu_next - fu_ho) >= 0);    
    for h=1:m
        for j=1:n
            if fu_ho(h,j) >= fu_lo(h,j)
                if fu_next(h,j) < fu_lo(h,j)
                    fu_next(h,j) = fu_lo(h,j);
                end
                if fu_next(h,j) > fu_ho(h,j)
                    fu_next(h,j) = fu_ho(h,j);
                end
            elseif fu_lo(h,j) >= fu_ho(h,j)
                if fu_next(h,j) < fu_ho(h,j)
                    fu_next(h,j) = fu_ho(h,j);
                end
                if fu_next(h,j) > fu_lo(h,j)
                    fu_next(h,j) = fu_lo(h,j);
                end
            end
        end
    end
    fu_next(2:2:end,2:2:end) = double(input_image);
%  fu_next(1:2:end-1,1:2:end-1) = double(input_image);
    %% pE
    [ gu_hor_init,gu_hor_init_map_next] = gu_extrema_update( gu_hor_next,gu_hor_init_map,'hor' );
    [ gu_ver_init,gu_ver_init_map_next] = gu_extrema_update( gu_ver_next,gu_ver_init_map,'ver' );
    %% 

    gu_hor_init_map = gu_hor_init_map_next;
    gu_ver_init_map = gu_ver_init_map_next;
    
    display(sum(sum(abs(fu_next - fu_initial))));
    display(sum(sum(abs(gu_hor_init - gu_hor_next))));
    display(sum(sum(abs(gu_ver_init - gu_ver_next))));
    
    fu_initial = fu_next;
    
%     gu_hor_init = gu_hor_next;
%     gu_ver_init = gu_ver_next;
    
end

output_image = wavelet2_inverse(fu_initial,gu_hor_init,gu_ver_init,1);
output_image = uint8(output_image);
end

