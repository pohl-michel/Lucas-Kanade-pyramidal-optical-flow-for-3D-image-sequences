% This function optimize the parameters involved in the calculation of the deformation vector field (DVF) of 3D dicom image sequences 
% using the pyramidal Lucas Kanade optical flow algorithm.
% 
% Author : Pohl Michel
% Date : Feb. 16th, 2021
% Version : v1.0
% License : 3-clause BSD License

clear all
close all
clc

%% PARAMETERS

% Program behavior (can be changed)
beh_par.EVALUATE_IN_ROI = true;
%     % when this variable is set to true, the numerical evaluation is carried only in the region of interest (ROI)

% Directories 
path_par = load_path_parameters3D();

% Input image sequences
path_par.input_im_dir_suffix_tab = [
   string('111_HM10395 4DCT');
   string('117_HM10395 4DCT');
   string('118_HM10395 4DCT');
    ];

% Hyper-parameter grid search :
OFeval_par = load_3DOF_hyperparameters();   

% Behavior - do not change
beh_par.DISPLAY_OF = false;

% final results variables
nb_seq = length(path_par.input_im_dir_suffix_tab);
length_sigma_LK_tab = length(OFeval_par.sigma_LK_tab);
length_sigma_init_tab = length(OFeval_par.sigma_init_tab);
length_sigma_subspl_tab = length(OFeval_par.sigma_subspl_tab);
nb_layers_test = OFeval_par.nb_layers_max - OFeval_par.nb_layers_min +1;
nb_iter_test = OFeval_par.nb_max_iter - OFeval_par.nb_min_iter +1;
% final array containing the desired rms scores :
rms_error_all_seq = zeros(nb_layers_test, length_sigma_LK_tab, nb_iter_test, length_sigma_init_tab, length_sigma_subspl_tab, nb_seq, 'single');
best_par_all_seq = cell(nb_seq, 1);

for im_seq_idx = 1:nb_seq
        
    % directory of the input images (text string inside the function)
    path_par.input_im_dir_suffix = path_par.input_im_dir_suffix_tab(im_seq_idx);
    path_par.input_im_dir = sprintf('%s\\%s', path_par.input_im_dir_pref, path_par.input_im_dir_suffix);

    % Image parameters
    im_par = load_3Dim_param(path_par);

    %% EVALUATION OF EACH HYPER-PARAMETER SET IN THE GRID
    
    compute_save_3DOF_mult_param( OFeval_par, path_par, im_par);

    [rms_error, best_par] = rms_of3D( beh_par, OFeval_par, path_par, im_par);
    path_par.OFeval_log_file_entire_fname = sprintf('%s\\%s %s', path_par.txt_file_dir, char(path_par.input_im_dir_suffix), path_par.OFoptim_log_filename);
    write_rms_eval_log_file( beh_par, OFeval_par, path_par, im_par, rms_error, best_par );

    rms_error_all_seq(:,:,:,:,:,im_seq_idx) = rms_error;
    best_par_all_seq{im_seq_idx} = best_par;

end

analyze_OF_param_influence( rms_error_all_seq, OFeval_par, beh_par, path_par);
