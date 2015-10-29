function [ image_grad ] = image_gradient( image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(image);

image_grad = zeros(m,n);
image_grad(2:end-1,2:end-1) = image(2:end-1,2:end-1) -(1/4)*(image(2:end-1,1:end-2) +...
    image(1:end-2,2:end-1) + image(3:end,2:end-1) + image(2:end-1,3:end));

end

