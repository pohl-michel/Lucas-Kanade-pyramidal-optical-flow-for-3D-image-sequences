function [ OFeval_par ] = load_3DOF_hyperparameters()
% Hyperparameters used when optimizing the deformation vector field by grid search
%
% Author : Pohl Michel
% Date : Feb. 16th, 2021
% Version : v1.0
% License : 3-clause BSD License

% Threshold below which the image structure tensor is probably non invertible and the pseudo inverse is used for inversion.
OFeval_par.epsilon_detG = 0.001;

% Standard deviation of the Gaussian filter used for filtering the initial image
OFeval_par.sigma_init_tab = [0.2, 0.5, 1.0, 2.0];

% Standard deviation of the Gaussian filter used for filtering each layer of the pyramid
OFeval_par.sigma_subspl_tab = [0.2, 0.5, 1.0, 2.0];

% Choice of the method used to calculate the gradient
OFeval_par.grad_meth = 2;
    % 2 : Scharr gradient
    % 1 : Central difference

switch(OFeval_par.grad_meth)
    case 1
        OFeval_par.grad_meth_str = 'ctrl diff grdt';
    case 2
        OFeval_par.grad_meth_str = 'Schaar grdt';
end    
    
% Standard deviation of the Gaussian kernel used in the Lucas Kanade method
OFeval_par.sigma_LK_tab = [1.0, 2.0, 3.0, 4.0];

% Number of layers in the pyramidal representation
OFeval_par.nb_layers_min = 1;
OFeval_par.nb_layers_max = 4;

% Number of iterations for refining the DVF at each layer
OFeval_par.nb_min_iter = 1;
OFeval_par.nb_max_iter = 3;


end
