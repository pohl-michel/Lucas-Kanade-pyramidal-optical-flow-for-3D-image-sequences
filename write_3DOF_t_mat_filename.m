function [ OF_t_filename ] = write_3DOF_t_mat_filename( OF_par, path_par, t )
% Returns the name of the file containing the results of the optical flow calculations
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

OF_param_str = sprintf_OF_param(OF_par);
OF_t_filename = sprintf('%s\\3DOF %s t=1 t=%d - %s.mat', path_par.temp_var_dir, path_par.input_im_dir_suffix, t , OF_param_str);

end

