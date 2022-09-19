function [ filename ] = write_3DOF_t_png_filename( beh_par, OF_par, path_par, disp_par, t )
% Returns the name of the image file displaying the projected DVF at time t on a Y cross-section
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

OF_param_str = sprintf_OF_param(OF_par);
filename = sprintf('%s\\3DOF %s t=1 t=%d - %s Ycs=%d', path_par.temp_im_dir, path_par.input_im_dir_suffix, t, OF_param_str, disp_par.Ycs);
if beh_par.CROP_FOR_DISP_SAVE
    filename = sprintf('%s ROI', filename);
end
filename = sprintf('%s.png', filename);


end

