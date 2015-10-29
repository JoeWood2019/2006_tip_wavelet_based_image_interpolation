function [ wavelet_next_map_in_base ] = find_the_same_extrema_cross_scale( wavelet_base,wavelet_next,extre_pos_base,extre_next )
%输入小波信号基准wavelet_base，需要map的小波信号wavelet_next，小波信号基准的极值点位置参照矢量extre_pos_base，待map的小波信号的极值点参照矢量extre_next
%输出的是一个与原信号等长的一维矢量，除了找到了对应的极值点的位置有相应的值，其余为0
signal_len = length(wavelet_base);
wavelet_next_map_in_base = zeros(1,signal_len);
for i=1:signal_len
    if extre_pos_base(i) ~= 0
        unfound_flag = 1;
        left_index = i;
        right_index = i;
        bound_index = 0;
        while unfound_flag
            bound_index = bound_index +1;
            sign_left = extre_next(left_index);
            sign_right = extre_next(right_index);
            if extre_pos_base(i) == sign_left%左边找到了对应的极值点
                ratio_extrema = wavelet_next(left_index) / wavelet_base(i);
                if (ratio_extrema <= 2^1.5 ) && ( ratio_extrema >= 1/(2^1.5) )
                    wavelet_next_map_in_base(i) = wavelet_next(left_index);
                    unfound_flag = 0;
                end
            elseif extre_pos_base(i) == sign_right%右边找到了对应的极值点
                    ratio_extrema = wavelet_next(right_index) / wavelet_base(i);
                    if (ratio_extrema <= 2^1.5 ) && ( ratio_extrema >= 1/(2^1.5) )
                        wavelet_next_map_in_base(i) = wavelet_next(right_index);
                        unfound_flag = 0;
                    end
            end
            if left_index == 1 || right_index == signal_len%到了尽头
                break;
            end
            if bound_index == 5
                break;
            end
            left_index = left_index -1;%继续寻找
            right_index = right_index +1;
        end
    end
end

end

