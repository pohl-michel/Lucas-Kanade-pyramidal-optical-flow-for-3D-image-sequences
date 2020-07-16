function [ beh_par ] = load_behavior_parameters3D()
% The structure beh_par contains important information about the behavior of the whole algorithm,
% which should be set manually.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

beh_par.SAVE_OF_PNG = true;
    % If SAVE_OF_PNG is set to true, the algorithm will save images of the DVF projected in cross-sections 

beh_par.CROP_FOR_DISP_SAVE = true;
    % if CROP_FOR_DISP_SAVE is set to true, then the optical flow is displayed only around the
    % tumor area, or the area specified by x_m, x_M, y_m, y_M, z_m, z_M. 
    
beh_par.EVALUATE_IN_ROI = true;
    % if EVALUATE_IN_ROI is set to true, the RMS registration error is calculated using only the pixels in the region of interest (ROI)

end