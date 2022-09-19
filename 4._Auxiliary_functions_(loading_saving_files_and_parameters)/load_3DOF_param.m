function [ OF_par ] = load_3DOF_param( path_par )
% Load the parameters concerning the optical flow calculation, 
% which are initially stored in the file named path_par.OFpar_filename
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

OF_calc_param_file = sprintf('%s\\%s', path_par.input_im_dir, path_par.OFpar_filename);
opts = detectImportOptions(OF_calc_param_file);
opts = setvartype(opts,'double');
opts.DataRange = '2:2'; % pour pouvoir écrire commentaires sur les variables en dessous ds fichier excel
OF_par = table2struct(readtable(OF_calc_param_file,opts)); 

switch(OF_par.grad_meth)
    case 1
        OF_par.grad_meth_str = 'ctrl diff grdt';
    case 2
        OF_par.grad_meth_str = 'Schaar grdt';
end


end

