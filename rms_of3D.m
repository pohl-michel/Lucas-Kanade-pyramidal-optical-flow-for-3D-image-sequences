function [ rms_error, best_par ] = rms_of3D( beh_par, OFeval_par, path_par, im_par)
% Computes the RMS error for each hyper parameter set in the grid specified by OFeval_par
%
% Author : Pohl Michel
% Date : Feb. 16th, 2021
% Version : v1.0
% License : 3-clause BSD Licenseclear all

    length_sigma_LK_tab = length(OFeval_par.sigma_LK_tab);
    length_sigma_init_tab = length(OFeval_par.sigma_init_tab);
    length_sigma_subspl_tab = length(OFeval_par.sigma_subspl_tab);
    
    OF_par.epsilon_detG = OFeval_par.epsilon_detG;
    OF_par.grad_meth_str = OFeval_par.grad_meth_str;
    OF_par.cropped_OF = false;

    nb_layers_test = OFeval_par.nb_layers_max - OFeval_par.nb_layers_min +1;
    nb_iter_test = OFeval_par.nb_max_iter - OFeval_par.nb_min_iter +1;    
    
    % final array containing the desired rms scores :
    rms_error = zeros(nb_layers_test, length_sigma_LK_tab, nb_iter_test, length_sigma_init_tab, length_sigma_subspl_tab, 'single');
    % lines : number of layers
    % columns : sigma_LK

    % table of rms errors at time t
    rms_t = zeros(nb_layers_test, length_sigma_LK_tab, nb_iter_test, length_sigma_init_tab, length_sigma_subspl_tab,im_par.nb_im -1, 'single');    
    
    % loading the image at t=1
    I = load_crop_filter3D(1, false, false, 0, im_par, path_par.input_im_dir);
    
    for t=2:im_par.nb_im
        % loop over t to avoid loading J several times

        J = load_crop_filter3D(t, false, false, 0, im_par, path_par.input_im_dir);
            
        for sigma_LK_tab_idx = 1:length_sigma_LK_tab    
            OF_par.sigma_LK = OFeval_par.sigma_LK_tab(sigma_LK_tab_idx);
            fprintf('sg_LK = %f...\n', OF_par.sigma_LK);
            for nb_layers = OFeval_par.nb_layers_min:OFeval_par.nb_layers_max
                OF_par.nb_layers = nb_layers;
                lyr_idx = nb_layers - OFeval_par.nb_layers_min +1;
                fprintf('\t nb_layers = %d...\n', nb_layers);
                for nb_iter = OFeval_par.nb_min_iter:OFeval_par.nb_max_iter
                    OF_par.nb_iter = nb_iter;
                    nb_iter_idx = nb_iter - OFeval_par.nb_min_iter +1;
                    fprintf('\t\t nb_iter = %d...\n', nb_iter);
                    for sg_init_idx = 1:length_sigma_init_tab
                        OF_par.sigma_init = OFeval_par.sigma_init_tab(sg_init_idx);
                        for sigma_subspl_idx = 1:length_sigma_subspl_tab
                            OF_par.sigma_subspl = OFeval_par.sigma_subspl_tab(sigma_subspl_idx);  

                                % loading optical flow at time t
                                OF_t_filename = write_3DOF_t_mat_filename( OF_par, path_par, t );
                                load(OF_t_filename, 'u_t');

                                % RMS between I and J
                                rms_t(lyr_idx, sigma_LK_tab_idx, nb_iter_idx, sg_init_idx, sigma_subspl_idx, t-1) = ...
                                                    RMS_two_im3d( I, translate3DIm(J, u_t), beh_par.EVALUATE_IN_ROI, im_par); 

                        end
                    end
                end
            end  
        end
        
    end

    for sigma_LK_tab_idx = 1:length_sigma_LK_tab    
        OF_par.sigma_LK = OFeval_par.sigma_LK_tab(sigma_LK_tab_idx);
        for nb_layers = OFeval_par.nb_layers_min:OFeval_par.nb_layers_max
            lyr_idx = nb_layers - OFeval_par.nb_layers_min +1;
            OF_par.nb_layers = nb_layers;
            for nb_iter = OFeval_par.nb_min_iter:OFeval_par.nb_max_iter
                nb_iter_idx = nb_iter - OFeval_par.nb_min_iter +1;
                OF_par.nb_iter = nb_iter;
                for sg_init_idx = 1:length_sigma_init_tab
                    OF_par.sigma_init = OFeval_par.sigma_init_tab(sg_init_idx);
                    for sigma_subspl_idx = 1:length_sigma_subspl_tab 
                        OF_par.sigma_subspl = OFeval_par.sigma_subspl_tab(sigma_subspl_idx);  
    
                        rms_t_temp = squeeze(rms_t(lyr_idx, sigma_LK_tab_idx, nb_iter_idx, sg_init_idx, sigma_subspl_idx, :));
                        rms_error(lyr_idx, sigma_LK_tab_idx, nb_iter_idx, sg_init_idx, sigma_subspl_idx) = sqrt((1/(im_par.nb_im-1))*sum(rms_t_temp.^2)); 
                        
                        for t=2:im_par.nb_im
                            OF_t_filename = write_3DOF_t_mat_filename( OF_par, path_par, t );
                            delete(OF_t_filename); % for preserving storage
                        end
       
                    end
                end
            end
        end
    end
    
    % Finding the best parameters
    best_par.rms_error = min(min(min(min(min(rms_error)))));
    lin_idx_min = find(rms_error== best_par.rms_error);
    [lyr_idx, sigma_LK_tab_idx, nb_iter_idx, sg_init_idx, sigma_subspl_idx] = ind2sub(size(rms_error), lin_idx_min);
    best_par.nb_layers = lyr_idx + OFeval_par.nb_layers_min -1;
    best_par.sigma_LK = OFeval_par.sigma_LK_tab(sigma_LK_tab_idx);
    best_par.nb_iter = nb_iter_idx + OFeval_par.nb_min_iter -1;
    best_par.sg_init = OFeval_par.sigma_init_tab(sg_init_idx);
    best_par.sigma_subspl = OFeval_par.sigma_subspl_tab(sigma_subspl_idx);
    
    
end

