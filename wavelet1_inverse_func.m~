function [ scale_func_pre ] = wavelet1_inverse_func( wave_func,scale_func,scale )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
h1 = [-0.001953125,-0.01367125,-0.04296875,0.04296875,0.01367125,0.001953125];
lamda = [1,0.75,0.6875,0.6719,0.6680,0.6670,0.6668];

h1_j_1 = upsample(h1,2^(scale-1));

temp = conv(h1_j_1,wave_func);
wave_func_pre = lamda(scale+1)*temp(1+3*2^(scale-1):3*2^(scale-1)+length(wave_func));
scale_func_pre = wavelet1_scale_inverse_func( scale_func,scale ) + wave_func_pre;
end

