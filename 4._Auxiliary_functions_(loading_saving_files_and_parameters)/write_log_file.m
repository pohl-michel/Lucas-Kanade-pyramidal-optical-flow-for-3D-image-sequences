function write_log_file(path_par, beh_par, im_par, OF_par, rms)
% Saves the set of parameters used and the RMS registration error 
% in a txt file in the folder path_par.txt_file_dir
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    log_file_complete_filename = sprintf('%s\\%s %s', path_par.txt_file_dir, path_par.input_im_dir_suffix, path_par.log_txt_filename);
    fid = fopen(log_file_complete_filename,'wt');
        
        fprintf(fid, '%s \n',path_par.date_and_time);
 
        % I] Writing down the calculation paremeters        
        
        fprintf(fid, 'image sequence %s \n\n',path_par.input_im_dir_suffix);

        if beh_par.EVALUATE_IN_ROI
            fprintf(fid, 'evaluation in the region of interest \n');
            fprintf(fid, 'x_m = %d \n', im_par.x_m);
            fprintf(fid, 'x_M = %d \n', im_par.x_M);        
            fprintf(fid, 'y_m = %d \n', im_par.y_m);        
            fprintf(fid, 'y_M = %d \n', im_par.y_M); 
            fprintf(fid, 'z_m = %d \n', im_par.z_m);        
            fprintf(fid, 'z_M = %d \n', im_par.z_M);
        else
            fprintf(fid, 'evaluation in the entire image \n');
        end
        fprintf(fid, '\n');
        
        fprintf(fid, 'Optical flow calculation parameters \n');
        fprintfOFpar( fid, OF_par );
            if OF_par.cropped_OF % if the OF is the OF which has been calculated on the entire image and then cropped
                cropped_OF_str = 'yes';
            else
                cropped_OF_str = 'no';
            end
        fprintf(fid, 'Optical flow cropped (from the entire image if ROI) : %s \n', cropped_OF_str);
        fprintf(fid, '\n');
        
        % II] Writing down the evaluation result
        fprintf(fid, 'RMS error of the deformation field : %g \n', rms);

    fclose(fid);

end