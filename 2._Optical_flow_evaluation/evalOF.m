function [rms] = evalOF(im_par,path_par,OF_par,beh_par)
% Load the optical flow previously calculated by compute_3Dof,
% and calculates the root-mean square error associated to the image registration.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    rms_t = zeros(im_par.nb_im -1, 1, 'single');

    % chargement de l'image à t=1
    I = load_crop_filter3D(1, false, false, 0, im_par, path_par.input_im_dir);   
    for t=2:im_par.nb_im
        % chargemnet de l'image à t
        J = load_crop_filter3D(t, false, false, 0, im_par, path_par.input_im_dir);  
        % loading optical flow at time t
        OF_t_filename = write_3DOF_t_mat_filename( OF_par, path_par, t );
        load(OF_t_filename, 'u_t'); 
        % calcul de la RMS entre I et J
        rms_t(t-1) = RMS_two_im3d( I, translate3DIm(J, u_t), beh_par.EVALUATE_IN_ROI, im_par); 
    end
    
    rms = sqrt((1/(im_par.nb_im-1))*sum(rms_t.^2));

end

