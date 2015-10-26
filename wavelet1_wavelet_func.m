function [ wave_func ] = wavelet1_wavelet_func( signal,scale )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
h1 = [0.5,-0.5];
lamda = [1,0.75,0.6875,0.6719,0.6680,0.6670,0.6668];

h1_j_1 = upsample(h1,2^(scale-1));
if scale ==1
    scale_func = signal;
else
    scale_func = wavelet1_scale_func( signal,scale-1);
end
wave_func = filter(h1_j_1,1,scale_func);
wave_func = wave_func/lamda(scale+1);
end

