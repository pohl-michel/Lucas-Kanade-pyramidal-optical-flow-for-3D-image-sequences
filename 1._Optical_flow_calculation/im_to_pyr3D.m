function [ pyr_I ] = im_to_pyr3D( I, OF_par )
% Function which takes a 3D initial image I and returns its pyramidal representation,
% which is used subsequently in the calculation of the deformation field.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    pyr_I = cell(OF_par.nb_layers,1);
    pyr_I{1} = I;  
        
    if (OF_par.nb_layers > 1) 
    % in the case where nb_layers = 1 (that is to say when no pyramid is used),
    % the pyramid is the image itself
    
        for lyr_idx = 1:(OF_par.nb_layers-1)
        % we are constructing the layer lyr_idx+1 of the pyramid

            % 1) filtering with a gaussian function
            filtered_image = floor(imgaussfilt3(pyr_I{lyr_idx}, OF_par.sigma_subspl));
                % floor is necessary because otherwise filtered_image has real
                % values and then enhance_brightness_contrast do not work well.

            %2) subsampling 
            pyr_I{lyr_idx+1} = filtered_image(1:2:end,1:2:end,1:2:end); 
                % pyr_I{lyr_idx+1}(y,x,z) = filtered_image(2*y-1,2*x-1,2*z-1);

        end

    end    
    
end

