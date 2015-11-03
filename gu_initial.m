function [ gu,extre_map ] = gu_initial( image, coordinate_flag)
% 输入：图像image，行列标志coordinate_flag，放大倍数scale
%   Detailed explanation goes here
scale = 2;%默认放大倍数为2
[m,n] = size(image);
gu = zeros(scale*m,scale*n);
extre_map = zeros(scale*m,scale*n);
extre_value = zeros(scale*m,scale*n);

if strcmp(coordinate_flag , 'hor')
    for i=scale:scale:m*scale %偶数行
        [ pos_extre,val_extre] = estimate_extremum(image(i/scale,:));
        temp = pos_extre*2;
        temp(1) = 1;
        
        for j=1:length(temp)
            if val_extre(j) > 0
                extre_map(i,temp(j)) = 1; %放大后图像的极值点位置  
            else
                extre_map(i,temp(j)) = -1; %放大后图像的极值点位置
            end
            extre_value(i,temp(j)) =val_extre(j);
        end
        extre_map(i,1) = 0.5;%首尾特别处理
        extre_map(i,end) = 0.5;
        
        for j=1:n*scale %剩余点插值
            gu(i,j) = interp1(temp,val_extre,j,'linear');
        end
    end
    
    for i=scale+1:scale:m*scale-1 %奇数行
        extre_count = 0;
        for j=1:n*scale % 奇数行情况下寻找临近行，同一列是不是极值点
            if extre_map(i-1,j) == 1 && extre_map(i+1,j) == 1
                extre_count = extre_count + 1;
                extre_map(i,j) = 1;
                extre_value(i,j) = (extre_value(i-1,j) + extre_value(i+1,j))/2;
            end
            if extre_map(i-1,j) == -1 && extre_map(i+1,j) == -1
                extre_count = extre_count + 1;
                extre_map(i,j) = -1;
                extre_value(i,j) = (extre_value(i-1,j) + extre_value(i+1,j))/2;
            end
            if extre_map(i-1,j) == 0.5 && extre_map(i+1,j) == 0.5
                extre_count = extre_count + 1;
                extre_map(i,j) = 0.5;
                extre_value(i,j) = (extre_value(i-1,j) + extre_value(i+1,j))/2;
            end
        end
        
        % 对极值点外的插值
        temp = zeros(extre_count,1);
        val_extre = zeros(extre_count,1);
        k=0;
        for j=1:n*scale
            if extre_map(i,j) == 1 || extre_map(i,j) == -1 || extre_map(i,j) == 0.5
                k=k+1;
                temp(k) = j; 
                val_extre(k) = extre_value(i,j);
            end
        end
        for j=1:n*scale %剩余点插值
            gu(i,j) = interp1(temp,val_extre,j,'linear');
        end
    end
    
elseif strcmp(coordinate_flag , 'ver')
    for i=scale:scale:n*scale %偶数列
        [ pos_extre,val_extre] = estimate_extremum(image(:,i/scale)');
        temp = pos_extre*2;
        temp(1) = 1;
        for j=1:length(temp)
            if val_extre > 0
                extre_map(temp(j),i) = 1; %放大后图像的极值点位置
            else
                extre_map(temp(j),i) = -1; %放大后图像的极值点位置
            end
            extre_value(temp(j),i) = val_extre(j);
        end
        extre_map(1,i) = 0.5;
        extre_map(end,i) = 0.5;
        
        for j=1:m*scale %剩余点插值
            gu(j,i) = interp1(temp,val_extre,j,'linear');
        end
    end 
    
    for i=scale+1:scale:n*scale-1 %奇数列
        extre_count = 0;
        for j=1:m*scale %奇数列情况下寻找临近列，同一列是不是极值点
            if extre_map(j,i-1) == 1 && extre_map(j,i+1) == 1
                extre_count = extre_count + 1;
                extre_map(j,i) = 1;
                extre_value(j,i) = (extre_value(j,i-1) + extre_value(j,i+1))/2;
            end
            if extre_map(j,i-1) == -1 && extre_map(j,i+1) == -1
                extre_count = extre_count + 1;
                extre_map(j,i) = -1;
                extre_value(j,i) = (extre_value(j,i-1) + extre_value(j,i+1))/2;
            end
            if extre_map(j,i-1) == 0.5 && extre_map(j,i+1) == 0.5
                extre_count = extre_count + 1;
                extre_map(j,i) = 0.5;
                extre_value(j,i) = (extre_value(j,i-1) + extre_value(j,i+1))/2;
            end
        end
        % 对极值点外的插值
        temp = zeros(extre_count,1);
        val_extre = zeros(extre_count,1);
        k=0;
        for j=1:m*scale
            if extre_map(j,i) == 1 || extre_map(j,i) == -1 || extre_map(j,i) == 0.5
                k=k+1;
                temp(k) = j; 
                val_extre(k) = extre_value(j,i);
            end
        end
        for j=1:m*scale %剩余点插值
            gu(j,i) = interp1(temp,val_extre,j,'linear');
        end
    end
else
    display('the coordinate flag is wrong!');
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
end

