function compute_3Dof( OF_par, im_par, path_par)
% Compute the optical flow between t_init = 1 et t_current
% for t_current varying from 2 to im_par.nb_im, 
% and saves the result in a mat file
% The optical flow is saved rather than returned as an output because it takes up much memory.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    fprintf('OPTICAL FLOW CALCULATION \n');
    fid = 1; % screen display
    fprintfOFpar( fid, OF_par );
    
    % Calculation of the pyramidal representation of the images at t=1 and t=2    
    initial_filtering_flag = true;
    crop_flag = false;
    
    t_init = 1;
    I = load_crop_filter3D(t_init, crop_flag, initial_filtering_flag, OF_par.sigma_init, im_par, path_par.input_im_dir);
    pyr_I = im_to_pyr3D( I, OF_par );
    
    for t = (t_init + 1):im_par.nb_im 
 
        J = load_crop_filter3D(t, crop_flag, initial_filtering_flag, OF_par.sigma_init, im_par, path_par.input_im_dir); 
        pyr_J = im_to_pyr3D( J, OF_par );
        
        % Calculation of optical flow between images at 1 and t
        u_t = pyr_LK_3D( pyr_I, pyr_J, OF_par); % la valeur de u_t n'est pas utilisée mais u_t est enregistré dans un fichier .mat - ignorer le warning

        fprintf('saving optical flow between t=1 and t = %d \n', t);
        OF_t_filename = write_3DOF_t_mat_filename( OF_par, path_par, t );
        save(OF_t_filename, 'u_t');   
        clear u_t ;

    end

end

