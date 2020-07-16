function [ disp_par ] = load_3Ddisplay_parameters(beh_par, im_par, path_par)
% Load the parameters concerning display,
% which are initially stored in the file named path_par.disp_par_filename.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    disp_par_file = sprintf('%s\\%s', path_par.input_im_dir, path_par.disp_par_filename);
    opts = detectImportOptions(disp_par_file);
    opts = setvartype(opts,'double');
    opts.DataRange = '2:2'; % pour pouvoir écrire commentaires sur les variables en dessous ds fichier excel
    disp_par = table2struct(readtable(disp_par_file, opts));

    disp_par.OF_res = sprintf('-r%d', int16(disp_par.OF_res));
    
    if beh_par.CROP_FOR_DISP_SAVE
        disp_par.Ycs_after_crop = disp_par.Ycs - (im_par.y_m - 1);
    else
        disp_par.Ycs_after_crop = disp_par.Ycs;
    end

end