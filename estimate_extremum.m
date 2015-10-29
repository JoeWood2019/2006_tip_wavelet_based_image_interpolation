function [ pos_extre,val_extre] = estimate_extremum( signal )
% 输入信号signal，目前尺度下的小波极值位置extrema_posi
%   Detailed explanation goes here
scale_num = 4;
result = zeros(length(signal),1);
extrema_value = zeros(length(signal),scale_num-1);
extrema_value_candi = zeros(length(signal),scale_num);
wavelet_signal = zeros(length(signal),scale_num);
for i=1:scale_num
    wavelet_signal(:,i) = wavelet1_wavelet_func( signal,i);
    extrema_value_candi(:,i) = find_extremum(wavelet_signal(:,i));
end

for i=2:scale_num
    extrema_value(:,i-1) = find_the_same_extrema_cross_scale(wavelet_signal(:,1),wavelet_signal(:,i),extrema_value_candi(:,1),extrema_value_candi(:,i));
end
%% 筛选出所有的尺度下均存在的极值点
all_scale_flag = ones(length(signal),1);
for i=1:scale_num-1
    all_scale_flag = all_scale_flag.*extrema_value(:,i);
end
all_scale_flag = (all_scale_flag ~= 0);

for i=1:scale_num-1
    extrema_value(:,i) = extrema_value(:,i).*all_scale_flag;
end

J=[1,2,3];
p=fittype('poly1');
for i=1:length(signal)
    if all_scale_flag(i) ~= 0
        linear_reg_result = polyfit(J,log2(extrema_value(i,:)),1);
        result(i) = 2^(linear_reg_result(2));
    end
end
result = real(result);
result(1) = wavelet_signal(1,1);
result(end) = wavelet_signal(end,1);


k=sum(result(2:end-1) ~= 0);
pos_extre=zeros(k+2,1);
val_extre=zeros(k+2,1); 
j=1;
pos_extre(j) = 1;
val_extre(j) = result(1);
for i=2:length(signal)-1
    if result(i) ~= 0
        j=j+1;
        pos_extre(j) = i;
        val_extre(j) = result(i);
    end
end
pos_extre(end) = length(signal);
val_extre(end) = result(end);

% figure;
% for i=1:5
%     subplot(5,1,i);
%     plot(wavelet_signal(:,i));
% end
% figure;
% for i=1:5
%     subplot(5,1,i);
%     plot(extrema_value_candi(:,i));
% end

end

