function [ fu_pre ] = wavelet2_inverse( fu,gu_hor,gu_ver,scale )
% ¶þÎ¬Í¼ÏñÄæ±ä»»
%   Detailed explanation goes here
h0 = [0.125,0.375,0.375,0.125];
% h1 = [-0.001953125,-0.01367125,-0.04296875,0.04296875,0.01367125,0.001953125];
h1 = [-0.015625, -0.1094, -0.3438,0.3438,0.1094,0.015625];
L = [0.0078125,0.046875,0.1171875,0.65625,0.1171875,0.046875,0.0078125];
lamda = [1,0.75,0.6875,0.6719,0.6680,0.6670,0.6668];


[m,n] = size(fu);
gu_hor_pre = zeros(m,n);
gu_ver_pre = zeros(m,n);
fu_pre = zeros(m,n);

h0_j_1 = upsample(h0,2^(scale-1));
h1_j_1 = upsample(h1,2^(scale-1));
L_1 = upsample(L,2^(scale-1));
%% gu_hor-pre
additional_sym = n;
for i=1:m 
    sym_wave_func = fliplr(gu_hor(i,:));
    wave_func_sym = [sym_wave_func(end-additional_sym+1:end),gu_hor(i,:),sym_wave_func(1:additional_sym)];    
    temp = conv(h1_j_1,wave_func_sym);
    gu_hor_pre(i,:) = lamda(scale+1)*temp(additional_sym+1+3*2^(scale-1):additional_sym+3*2^(scale-1)+n);
        
    sym_wave_func = fliplr(gu_hor_pre(i,:));
    wave_func_sym = [sym_wave_func(end-additional_sym+1:end),gu_hor_pre(i,:),sym_wave_func(1:additional_sym)];
    temp = conv(L_1,wave_func_sym);
    gu_hor_pre(i,:) = temp(additional_sym+1+3*2^(scale-1):additional_sym+3*2^(scale-1)+n);
end
%% gu_ver_pre
additional_sym = m;
for i=1:n
    sym_wave_func = flipud(gu_ver(:,i));
    wave_func_sym = [sym_wave_func(end-additional_sym+1:end);gu_ver(:,i);sym_wave_func(1:additional_sym)];
    temp = conv(L_1,wave_func_sym);
    gu_ver_pre(:,i) = temp(additional_sym+1+3*2^(scale-1):additional_sym+3*2^(scale-1)+m);
    
    sym_wave_func = flipud(gu_ver_pre(:,i));
    wave_func_sym = [sym_wave_func(end-additional_sym+1:end);gu_ver_pre(:,i);sym_wave_func(1:additional_sym)];
    temp = conv(h1_j_1,wave_func_sym);
    gu_ver_pre(:,i) = lamda(scale+1)*temp(additional_sym+1+3*2^(scale-1):additional_sym+3*2^(scale-1)+m);
end
%% fu_pre
additional_sym = m;
for i=1:m
    sym_scale_func = fliplr(fu(i,:));
    scale_func_sym = [sym_scale_func(end-additional_sym+1:end),fu(i,:),sym_scale_func(1:additional_sym)];
    temp = conv(h0_j_1,scale_func_sym);
    fu_pre(i,:) = temp(additional_sym+1+2^scale:additional_sym+2^scale+n);
end
additional_sym = n;
for i=1:n 
    sym_scale_func = flipud(fu_pre(:,i));
    scale_func_sym = [sym_scale_func(end-additional_sym+1:end);fu_pre(:,i);sym_scale_func(1:additional_sym)];
    temp = conv(h0_j_1,scale_func_sym);
    fu_pre(:,i) = temp(additional_sym+1+2^scale:additional_sym+2^scale+m);
end

fu_pre = fu_pre+gu_hor_pre+gu_ver_pre;
end

