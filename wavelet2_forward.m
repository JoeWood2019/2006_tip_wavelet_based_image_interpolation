function [ fu,gu_hor,gu_ver] = wavelet2_forward( fu_pre,scale )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
h0 = [0.125,0.375,0.375,0.125];
h1 = [0.5,-0.5];
lamda = [1,0.75,0.6875,0.6719,0.6680,0.6670,0.6668];

[m,n] = size(fu_pre);

fu = double(fu_pre);
gu_hor = zeros(m,n);
gu_ver = zeros(m,n);

h0_j_1 = upsample(h0,2^(scale-1));
h1_j_1 = upsample(h1,2^(scale-1));
%% gu_hor
additional_sym = m;
for i=1:m
    sym_scale_func = fliplr(fu(i,:));
    scale_func_sym = [sym_scale_func(end-additional_sym+1:end),fu(i,:),sym_scale_func(1:additional_sym)];
    temp = conv(h1_j_1,scale_func_sym);
    gu_hor(i,:) = temp(additional_sym+1:additional_sym+n)/lamda(scale);
end
%% gu_ver
additional_sym = n;
for i=1:n 
    sym_scale_func = flipud(fu(:,i));
    scale_func_sym = [sym_scale_func(end-additional_sym+1:end);fu(:,i);sym_scale_func(1:additional_sym)];
    temp = conv(h1_j_1,scale_func_sym);
    gu_ver(:,i) = temp(additional_sym+1:additional_sym+m)/lamda(scale);
end

%% fu
additional_sym = m;
for i=1:m
    sym_scale_func = fliplr(fu(i,:));
    scale_func_sym = [sym_scale_func(end-additional_sym+1:end),fu(i,:),sym_scale_func(1:additional_sym)];
    temp = conv(h0_j_1,scale_func_sym);
    fu(i,:) = temp(additional_sym+1+2^(scale-1):additional_sym+2^(scale-1)+n);
end
additional_sym = n;
for i=1:n 
    sym_scale_func = flipud(fu(:,i));
    scale_func_sym = [sym_scale_func(end-additional_sym+1:end);fu(:,i);sym_scale_func(1:additional_sym)];
    temp = conv(h0_j_1,scale_func_sym);
    fu(:,i) = temp(additional_sym+1+2^(scale-1):additional_sym+2^(scale-1)+m);
end

end

