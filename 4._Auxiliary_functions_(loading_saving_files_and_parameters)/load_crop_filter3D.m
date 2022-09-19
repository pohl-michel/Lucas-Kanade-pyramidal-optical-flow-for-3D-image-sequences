function [ im ] = load_crop_filter3D(t, CROP, FILTER, sigma_init, im_par, input_im_dir)
% Return the image at time t.
% The image is cropped and/or filtered if specified in the behavior parameters.
% The returned image is of type 'single' (in order to minimize the memory used).
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    fprintf('loading 3D image at time t = %d ...\n', t);
    im_filename = sprintf('%s\\image%d.dcm',input_im_dir, t);
    im = single(squeeze(dicomread(im_filename)));
        % squeeze is necessary because when Matlab opens a 3D image with dicomread the 3rd dimension is a singleton
    
    if CROP
        fprintf('cropping image at time t = %d \n', t);
        im = im(im_par.y_m:im_par.y_M, im_par.x_m:im_par.x_M, im_par.z_m:im_par.z_M);
    end

    if FILTER
        fprintf('low pass gaussian filtering of the image at time t = %d \n', t);
            im = floor(imgaussfilt3(im, sigma_init));
                % 1) floor is necessary because otherwise filtered_image has real
                % values and then enhance_brightness_contrast do not work well.  
                % 2) the matrix type is still 'single after this operation'
    end

end