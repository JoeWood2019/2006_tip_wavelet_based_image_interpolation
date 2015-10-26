function [ fu ] = wavelet1_scale_inverse_func( scale_func,scale )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
h0 = [0.125,0.375,0.375,0.125];
scale_func = double(scale_func);
if scale == 1
    temp = conv(h0,scale_func);
    fu = temp(1+2^scale:2^scale+length(scale_func));%注意计算小波卷积时，小波系数起点并不是0
else
    for i=1:scale
        fu_pre = wavelet1_scale_func( scale_func,scale-1 );
        h0_j_1 = upsample(h0,2^(scale-1));
        temp = conv(h0_j_1,fu_pre);
        fu = temp(1+2^scale:2^scale+length(scale_func));%注意计算小波卷积时，小波系数起点并不是0
    end
end

end

