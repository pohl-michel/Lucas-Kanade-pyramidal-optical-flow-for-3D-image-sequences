function [ rms_two_im3d ] = RMS_two_im3d( I, J, EVALUATE_IN_ROI, im_par)
% Calculation of the RMS error between the intensity levels of 2 images of the same size I & J
% if EVALUATE_IN_ROI is true, then the RMS is calculated only in the region of interest.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    if EVALUATE_IN_ROI
        Wevl = im_par.y_M - im_par.y_m + 1;
        Levl = im_par.x_M - im_par.x_m + 1;
        Hevl = im_par.z_M - im_par.z_m + 1; 
        x_eval_m = im_par.x_m;
        x_eval_M = im_par.x_M;
        y_eval_m = im_par.y_m;
        y_eval_M = im_par.y_M;
        z_eval_m = im_par.z_m;
        z_eval_M = im_par.z_M; 
    else
        Wevl = im_par.W;
        Levl = im_par.L;
        Hevl = im_par.H;
        x_eval_m = 1;
        x_eval_M = im_par.L;
        y_eval_m = 1;
        y_eval_M = im_par.W; 
        z_eval_m = 1;
        z_eval_M = im_par.H;
    end

    pix_errors = zeros(Wevl, Levl, Hevl, 'single');

    for x=x_eval_m:x_eval_M
        for y=y_eval_m:y_eval_M
            for z=z_eval_m:z_eval_M
                x_tab = x - x_eval_m + 1;
                y_tab = y - y_eval_m + 1;
                z_tab = z - z_eval_m + 1;                
                pix_errors(y_tab, x_tab, z_tab) = I(y,x,z) - J(y,x,z);
            end
        end
    end

    rms_two_im3d = sqrt(sum(sum(sum(((1/sqrt(Wevl*Levl*Hevl))*pix_errors).^2))));

end
