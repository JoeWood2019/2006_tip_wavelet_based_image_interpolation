function [ gu_next,extre_map_next] = gu_extrema_update( gu_pre,extre_map_pre,coordinate_flag )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(gu_pre);
gu_next = gu_pre;
extre_map_next = extre_map_pre;

if strcmp(coordinate_flag , 'hor')
    %更新极值点位置
    for i=1:m
        for j=2:2:n
            if extre_map_pre(i,j) == 1
                [~,max_posi] = max([gu_pre(i,j-1),gu_pre(i,j),gu_pre(i,j+1)]);
                extre_map_next(i,j) = 0;
                extre_map_next(i,j+max_posi-2) = 1;
            elseif extre_map_pre(i,j) == -1
                [~,max_posi] = min([gu_pre(i,j-1),gu_pre(i,j),gu_pre(i,j+1)]);
                extre_map_next(i,j) = 0;
                extre_map_next(i,j+max_posi-2) = -1;
            end
        end
    end
    %极值点领域加bounding
    window_size = 3;
    for i=1:m
        for j=1+window_size:n-window_size
            if extre_map_next(i,j) == 1
                gu_next(i,j-3:j+3) = gu_pre(i,j-3:j+3).*(gu_pre(i,j-3:j+3) > gu_pre(i,j) ) * gu_pre(i,j) +...
                    gu_pre(i,j-3:j+3).*(gu_pre(i,j-3:j+3) < gu_pre(i,j) );
            elseif extre_map_next(i,j) == -1
                gu_next(i,j-3:j+3) = gu_pre(i,j-3:j+3).*(gu_pre(i,j-3:j+3) < gu_pre(i,j) ) * gu_pre(i,j) +...
                    gu_pre(i,j-3:j+3).*(gu_pre(i,j-3:j+3) > gu_pre(i,j) );
            end
        end
    end
    
elseif strcmp(coordinate_flag , 'ver')
    %更新极值点位置
    for i=1:n
        for j=2:2:m
            if extre_map_pre(j,i) == 1
                [~,max_posi] = max([gu_pre(j-1,i),gu_pre(j,i),gu_pre(j+1,i)]);
                extre_map_next(j,i) = 0;
                extre_map_next(j+max_posi-2,i) = 1;
            elseif extre_map_pre(i,j) == -1
                [~,max_posi] = min([gu_pre(j-1,i),gu_pre(j,i),gu_pre(j+1,i)]);
                extre_map_next(j,i) = 0;
                extre_map_next(j+max_posi-2,i) = -1;
            end
        end
    end
    %极值点领域加bounding
    window_size = 3;
    for i=1:n
        for j=1+window_size:m-window_size
            if extre_map_next(j,i) == 1
                gu_next(j-3:j+3,i) = gu_pre(j-3:j+3,i).*(gu_pre(j-3:j+3,i) > gu_pre(j,i) ) * gu_pre(j,i) +...
                    gu_pre(j-3:j+3,i).*(gu_pre(j-3:j+3,i) < gu_pre(j,i) );
            elseif extre_map_next(j,i) == -1
                gu_next(j-3:j+3,i) = gu_pre(j-3:j+3,i).*(gu_pre(j-3:j+3,i) < gu_pre(j,i) ) * gu_pre(j,i) +...
                    gu_pre(j-3:j+3,i).*(gu_pre(j-3:j+3,i) > gu_pre(j,i) );
            end
        end
    end
    
else
    display('the coordinate flag is wrong!');
end
end

