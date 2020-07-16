% This function calculates the deformation vector field (DVF) of 3D dicom image sequences using the pyramidal Lucas Kanade optical flow algorithm,
% provides images of that DVF projected in cross-sections and calculates the root-mean square registration error of the calculated DVF.
% 
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

clear all
close all
clc

%% PARAMETERS 

% Program behavior
beh_par = load_behavior_parameters3D();

% Directories 
path_par = load_path_parameters3D();

% Input image sequences
input_im_dir_suffix_tab = [
   string('111_HM10395 4DCBCT');
    ];
    % The names of the image sequences for which the DVF needs to be calculated are placed inside the array above.

nb_seq = length(input_im_dir_suffix_tab);
for im_seq_idx = 1:nb_seq

    % directory of the input images (text string inside the function)
    path_par.input_im_dir_suffix = input_im_dir_suffix_tab(im_seq_idx);
    path_par.input_im_dir = sprintf('%s\\%s', path_par.input_im_dir_pref, path_par.input_im_dir_suffix);  

    % Parameters concerning optical flow - depend on the input sequence - they are in an excel file
    OF_par = load_3DOF_param(path_par);

    % Image parameters
    im_par = load_3Dim_param(path_par);

    % Display parameters
    disp_par = load_3Ddisplay_parameters(beh_par, im_par, path_par);


    %% ---------------------------------------------------------------------------------------------------------------------------------------------------
    %  PROGRAM -------------------------------------------------------------------------------------------------------------------------------------------
    %  --------------------------------------------------------------------------------------------------------------------------------------------------- 

    compute_3Dof(OF_par, im_par, path_par);

    if beh_par.SAVE_OF_PNG
        save_3DOFpng(beh_par, path_par, disp_par, OF_par, im_par);
    end

    rms = evalOF(im_par,path_par,OF_par,beh_par);
        
    write_log_file(path_par, beh_par, im_par, OF_par, rms);

end