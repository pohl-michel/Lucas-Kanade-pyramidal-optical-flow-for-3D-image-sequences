function write_rms_eval_log_file( beh_par, OFeval_par, path_par, im_par, rms_error, best_par )
% Returns information about the best hyper-parameter set in the grid search and the RMS error associated to each hyper-parameter set
% in a txt file.
%
% Author : Pohl Michel
% Date : Feb. 16th, 2021
% Version : v1.0
% License : 3-clause BSD Licenseclear all

    fid = fopen(path_par.OFeval_log_file_entire_fname,'wt');

    date = sprintf('%s %s', datestr(datetime, 'yyyy - mm - dd HH AM MM'), 'min');
    fprintf(fid, '%s \n',date);

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

    fprintf(fid, 'Gradient method : %s \n', OFeval_par.grad_meth_str);
    fprintf(fid, 'Determinant threshold for solving the linear system for each pixel %f \n', OFeval_par.epsilon_detG);
    fprintf(fid, '\n');

    length_sigma_init_tab = length(OFeval_par.sigma_init_tab);
    length_sigma_subspl_tab = length(OFeval_par.sigma_subspl_tab);
    length_sigma_LK_tab = length(OFeval_par.sigma_LK_tab);
    
    fprintf(fid, 'Range of parameters tested \n');  
    fprintf(fid, 'sg_init (std dev of the gaussian initial filtering) : \n');
    for sg_init_idx = 1:length_sigma_init_tab
       fprintf(fid, '%g \t', OFeval_par.sigma_init_tab(sg_init_idx)); 
    end
    fprintf(fid, '\n');
    fprintf(fid, 'nb_lyr (number of layers - lines) : \n');
    for nb_layers = OFeval_par.nb_layers_min:OFeval_par.nb_layers_max
       fprintf(fid, '%d \t', nb_layers); 
    end
    fprintf(fid, '\n');
    fprintf(fid, 'nb_iter (number of iterations) : \n');
    for nb_iter = OFeval_par.nb_min_iter:OFeval_par.nb_max_iter
       fprintf(fid, '%d \t', nb_iter); 
    end
    fprintf(fid, '\n');    
    fprintf(fid, 'sg_subspl (std dev of the gaussian filtering used when subsampling between each layer) : \n');
    for sigma_subspl_idx = 1:length_sigma_subspl_tab
       fprintf(fid, '%g \t', OFeval_par.sigma_subspl_tab(sigma_subspl_idx)); 
    end
    fprintf(fid, '\n');    
    fprintf(fid, 'sg_LK (std dev of the gaussian function used in the basic Lucas Kanade algorithm - columns) : \n');
    for sigma_LK_tab_idx = 1:length_sigma_LK_tab   
       fprintf(fid, '%g \t', OFeval_par.sigma_LK_tab(sigma_LK_tab_idx)); 
    end
    fprintf(fid, '\n \n');
    
    fprintf(fid, 'Lower root mean square error found : %g \n', best_par.rms_error);
    fprintf(fid, 'Corresponding parameters : \n');     
    fprintf(fid, 'sigma_init : %g \n', best_par.sg_init);
    fprintf(fid, 'nb_lyr : %d \n', best_par.nb_layers);
    fprintf(fid, 'nb_iter : %g \n', best_par.nb_iter);
    fprintf(fid, 'sg_subspl : %g \n', best_par.sigma_subspl); 
    fprintf(fid, 'sg_LK : %g \n', best_par.sigma_LK);    
    fprintf(fid, '\n \n');
   
    for nb_iter = OFeval_par.nb_min_iter:OFeval_par.nb_max_iter
        nb_iter_idx = nb_iter - OFeval_par.nb_min_iter +1;
        for sg_init_idx = 1:length_sigma_init_tab
            sigma_init = OFeval_par.sigma_init_tab(sg_init_idx);
            for sigma_subspl_idx = 1:length_sigma_subspl_tab
                sigma_subspl = OFeval_par.sigma_subspl_tab(sigma_subspl_idx);  

                fprintf(fid, 'Initial gaussian filtering of strd dev %f \n', sigma_init);
                fprintf(fid, 'Gaussian filtering before subsampling, with strd dev %f \n', sigma_subspl);
                fprintf(fid, 'Number of iterations per layer : %d \n', nb_iter);
                fprintf(fid, 'ROI results \n');

                rms_temp = squeeze(rms_error(:, :, nb_iter_idx, sg_init_idx, sigma_subspl_idx));
                for ii = 1:size(rms_temp,1)
                    fprintf(fid,'%g\t',rms_temp(ii,:));
                    fprintf(fid,'\n');
                end
                fprintf(fid, '\n');

            end
        end
    end      
    fclose(fid);
        
end

