function [ output_args ] = gu_initial( image, coordinate_flag , scale)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(image);
output_args = zeros(scale*m,scale*n);
if strcmp(coordinate_flag , 'hor')
    for i=1:m
        temp = wavelet1_wavelet_func( image(i,:),1 );
        output_args(i,:) = imresize(temp,scale,'bicubic');
                                                                                                                                                                                                                                                                                                                                                                                                               
    end
elseif strcmp(coordinate_flag , 'ver')
    for i=1:n
        output_args(:,i) = wavelet1_wavelet_func( image(:,i),1 );
    end 
else
    display('the coordinate flag is wrong!');
end

end

