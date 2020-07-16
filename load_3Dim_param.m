function [ im_par ] = load_3Dim_param( path_par )
% Load the parameters concerning the loaded image sequence,
% which are initially stored in the file named path_par.im_par_filename.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

im_par_file = sprintf('%s\\%s', path_par.input_im_dir, path_par.im_par_filename);
opts = detectImportOptions(im_par_file);
opts.DataRange = '2:2'; % pour pouvoir écrire commentaires sur les variables en dessous ds fichier excel
im_par = table2struct(readtable(im_par_file, opts));

end

