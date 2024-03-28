function y = gamma_serial(gamma)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    x = 0:1:255;
    y = zeros(size(x));
    for i = 0:1:255
        y(i + 1) = round(255 * (i/255) ^ gamma);
    end
    
end

