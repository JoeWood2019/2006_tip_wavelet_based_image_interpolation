function [ scale_func ] = wavelet1_scale_func( signal,scale )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
h0 = [0.125,0.375,0.375,0.125];
signal = double(signal);
if scale == 1
    temp = conv(h0,signal);
    scale_func = temp(1+2^(scale-1):2^(scale-1)+length(signal));
else
    scale_func_pre = wavelet1_scale_func( signal,scale-1 );
    h0_j_1 = upsample(h0,2^(scale-1));
    temp = conv(h0_j_1,scale_func_pre);
    scale_func = temp(1+2^(scale-1):2^(scale-1)+length(signal));%注意计算小波卷积时，小波系数起点并不是0
end
end

