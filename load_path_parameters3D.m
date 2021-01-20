function [ path_par ] = load_path_parameters3D()
% This function returns path_par, which returns the information concerning the folders used for loading and saving files,
% as well as the name of files to save or open
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    % time
    path_par.date_and_time = sprintf('%s %s', datestr(datetime, 'yyyy - mm - dd HH AM MM'), 'min');

    % directory of the imput images ("pref" means "prefix")
    path_par.input_im_dir_pref = 'Input images';
    % directory for saving temporary images (located in the Matlab workspace)
    path_par.temp_im_dir = 'Optical flow projection images';
    % directory for saving temporary variables
    path_par.temp_var_dir = 'Optical flow calculation results mat files';
    % directory for saving log files
    path_par.txt_file_dir = 'Log files';

    % check if the directories above exist and create them if they do not
    if ~exist(path_par.temp_im_dir, 'dir')
       mkdir(path_par.temp_im_dir)
    end    
    if ~exist(path_par.temp_var_dir, 'dir')
       mkdir(path_par.temp_var_dir)
    end  
    if ~exist(path_par.txt_file_dir, 'dir')
       mkdir(path_par.txt_file_dir)
    end   

    % image sequence parameters txt filename
    path_par.im_seq_par_txt_filename = 'Image sequence parameters.txt';
    % optical flow parameters filename
    path_par.OFpar_filename = '3DOF_calc_par.xlsx';
    % image parameters filename
    path_par.im_par_filename = '3Dim_seq_par.xlsx';
    % display parameters filename
    path_par.disp_par_filename = '3Ddisp_par.xlsx';
    % txt file with parameters filename
    path_par.log_txt_filename = sprintf('log file %s.txt', path_par.date_and_time);
   
end
