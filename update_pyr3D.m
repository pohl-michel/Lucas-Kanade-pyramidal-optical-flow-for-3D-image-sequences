function [ new_pyr ] = update_pyr3D( pyr, OF_par, im_par, input_im_dir, t )
% pyr contains the representation of the two images at time t_1 = 1, and t-1 (current time)
% update_pyr` creates the pyramid containing the representation of the two images at time t_1 = 1 and t
% This function is normally called the following way : pyr = update_pyr( pyr, OF_par, im_par, beh_par, input_im_dir, t )

    new_pyr = pyr;

    % I] loading the image at time t
    initial_filtering_flag = true;
    crop_flag = false;
    new_pyr{1}.pix_val(:,:,:,2) = load_crop_filter3D(t, crop_flag, initial_filtering_flag, OF_par.sigma_init, im_par, input_im_dir);    

    % II] calculating the pyramidal representation of the image at time t
    new_pyr = compute_upper_layers3D( new_pyr, 2, OF_par);

end

