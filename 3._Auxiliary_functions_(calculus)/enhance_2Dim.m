function [ enhanced_image ] = enhance_2Dim( input_image, PERFORM_ENHANCEMENT)
% This function takes as an input an image of dimensions L*H encoded with 16bits
% pixels. It enhances the contrast of the image following the histogram streching algorithm used in ImageJ and
% outputs the enhanced image.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

%% PARAMETERS

limit_coeff = 0.1;
threshold_coeff = 0.0002;
absolute_max_value = (2^16 - 1); % image coded in 16 bits
[H, L] = size(input_image);


enhanced_image = input_image;

if PERFORM_ENHANCEMENT

    fprintf('image enhancement by histogram stretching ...\n');
    
    %% IMAGE ENHANCEMENT PROCESS

    nb_pixels = L*H;
    max_intensity = max(max(input_image));
    limit = nb_pixels*limit_coeff;
    threshold = nb_pixels*threshold_coeff;

    % HISTOGRAM CALCULATION
    hist = zeros(max_intensity+1);
    for x=1:L
        for y = 1:H
            current_pix_intensity = input_image(y,x);
            temp = hist(1+current_pix_intensity); 
                % 1+ because the intensity values range is [0, max_intensity]
                % whereas the indexes range in the hist tab is [1, max_intensity+1]
            hist(1+current_pix_intensity) = temp + 1;
        end
    end

    %ESTIMATION OF THE LOWER VALUE
    min_found = false;
    current_i = 0; %intensity value, not index
    while (not(min_found))&&(current_i < max_intensity)
        count = hist(current_i+1);
        if (count <= limit)&&(count >= threshold)
           min_index = current_i+1;
           min_found = true;
        end
        current_i = current_i + 1;
    end
    if (current_i == max_intensity)
        min_index = max_intensity;
    end

    %ESTIMATION OF THE UPPER VALUE
    max_found = false;
    current_i = max_intensity;
    while (not(max_found))&&((current_i+1) > min_index)
        count = hist(current_i+1);
        if (count <= limit)&&(count >= threshold)
           max_index = current_i+1;
           max_found = true;
        end
        current_i = current_i - 1;
    end
    if ((current_i+1) == min_index)
        max_index = min_index+1;
    end

    %LOOK UP TABLE
    lut = zeros(max_intensity+1);
    slope = absolute_max_value/(max_index - min_index); 
        % Remark : we never have max_index = min_index
    for i = min_index:max_index %i is an index, not an intensity value
       lut(i) = (i - min_index)*slope;
    end
    for i = max_index:(max_intensity+1)
       lut(i) = absolute_max_value;
    end

    %ENHANCED IMAGE CREATION
    enhanced_image = zeros(H, L);
    for x=1:L
        for y = 1:H
            enhanced_image(y,x) = lut(input_image(y,x)+1);
        end
    end

end


end

