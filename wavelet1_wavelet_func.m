function [ wave_func ] = wavelet1_wavelet_func( signal,scale )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
h1 = [0.5,-0.5];
lamda = [1,0.75,0.6875,0.6719,0.6680,0.6670,0.6668];

h1_j_1 = upsample(h1,2^(scale-1));
if scale ==1
    scale_func = double(signal);
else
    scale_func = wavelet1_scale_func( signal,scale-1);
end

additional_sym = length(signal);
sym_signal = fliplr(scale_func);
scale_func_sym = [sym_signal(end-additional_sym+1:end),scale_func,sym_signal(1:additional_sym)];

temp = conv(h1_j_1,scale_func_sym);
wave_func = temp(additional_sym+1:additional_sym+length(signal));%注意计算小波卷积时，小波系数起点并不是0
wave_func=wave_func/lamda(scale+1);
end

