function [ J ] = translate3DIm( I, u )
% This function translates the image I by the vector field u
% informally J(vec_x) = I(vec_x + u(vec_x)) 
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    [W, L, H] = size(I);
    J = zeros(W, L, H, 'single');
    for x=1:L
        for y =1:W
            for z =1:H
                J(y, x, z) = my_tril_interp(I, H, W, L, z+u(y,x,z,3), y+u(y,x,z,2),x+u(y,x,z,1));
            end
        end
    end

end

