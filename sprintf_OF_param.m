function [ OF_param_str ] = sprintf_OF_param(OF_par)
% returns a string which contains information about the optical flow parameters, for saving and loading temporary variables
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

if OF_par.cropped_OF % if the OF is the OF which has been calculated on the entire image and then cropped
    cropped_OF_str = ' cropped_OF';
else
    cropped_OF_str = '';
end

OF_param_str = sprintf('sg_init=%g sg_sbspl=%g sg_LK=%g nb_lyr=%d nb_iter =%d %s%s', ...
    OF_par.sigma_init, OF_par.sigma_subspl, OF_par.sigma_LK, OF_par.nb_layers, OF_par.nb_iter, OF_par.grad_meth_str, cropped_OF_str);
    % used when variables are saved and loaded - needed even though the optical flow is not computed

end

