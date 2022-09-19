function compute_save_3DOF_mult_param( OFeval_par, path_par, im_par)
% Computes and saves the DVF for several parameters as specified in the structure OFeval_par
% This function is used for evaluating the influence of the parameters on the accuracy of the computed optical flow.
%
% Author : Pohl Michel
% Date : Feb. 16th, 2021
% Version : v1.0
% License : 3-clause BSD License

    length_sigma_LK_tab = length(OFeval_par.sigma_LK_tab);
    length_sigma_init_tab = length(OFeval_par.sigma_init_tab);
    length_sigma_subspl_tab = length(OFeval_par.sigma_subspl_tab);
    
    OF_par.epsilon_detG = OFeval_par.epsilon_detG;
    OF_par.grad_meth = OFeval_par.grad_meth;
    OF_par.grad_meth_str = OFeval_par.grad_meth_str;
    OF_par.cropped_OF = false;

    for sigma_LK_tab_idx = 1:length_sigma_LK_tab    
        OF_par.sigma_LK = OFeval_par.sigma_LK_tab(sigma_LK_tab_idx);
        for nb_layers = OFeval_par.nb_layers_min:OFeval_par.nb_layers_max
            OF_par.nb_layers = nb_layers;
            for nb_iter = OFeval_par.nb_min_iter:OFeval_par.nb_max_iter
                OF_par.nb_iter = nb_iter;
                for sg_init_idx = 1:length_sigma_init_tab
                    OF_par.sigma_init = OFeval_par.sigma_init_tab(sg_init_idx);
                    for sigma_subspl_idx = 1:length_sigma_subspl_tab
                        OF_par.sigma_subspl = OFeval_par.sigma_subspl_tab(sigma_subspl_idx);  
                        
                        compute_3Dof(OF_par, im_par, path_par);
                        
                    end
                end
            end
        end
    end
end

