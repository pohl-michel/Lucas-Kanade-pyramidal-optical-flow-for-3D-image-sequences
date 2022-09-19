function analyze_OF_param_influence( rms_error_all_seq, OFeval_par, beh_par, path_par)
% Returns information about the influence of each hyper-parameter set in the grid search on the DVF accuracy in a txt file.
%
% Author : Pohl Michel
% Date : Feb. 16th, 2021
% Version : v1.0
% License : 3-clause BSD License

    [~,~,~,~,~,nb_seq] = size(rms_error_all_seq);
    length_sg_init_tab = length(OFeval_par.sigma_init_tab);
    length_sg_subspl_tab = length(OFeval_par.sigma_subspl_tab);
    length_sg_LK_tab = length(OFeval_par.sigma_LK_tab);
    nb_layers_evaluated = OFeval_par.nb_layers_max - OFeval_par.nb_layers_min +1;
    nb_iter_evaluated = OFeval_par.nb_max_iter - OFeval_par.nb_min_iter +1;

    sg_init_error_tab = zeros(length_sg_init_tab, nb_seq, 'single');
    sg_subspl_error_tab = zeros(length_sg_subspl_tab, nb_seq, 'single');
    sg_LK_error_tab = zeros(length_sg_LK_tab, nb_seq, 'single');    
    nb_lyr_error_tab = zeros(nb_layers_evaluated, nb_seq, 'single');
    nb_iter_error_tab = zeros(nb_iter_evaluated, nb_seq, 'single');
    
    sg_init_min_error_tab = zeros(length_sg_init_tab, nb_seq, 'single');
    sg_subspl_min_error_tab = zeros(length_sg_subspl_tab, nb_seq, 'single');
    sg_LK_min_error_tab = zeros(length_sg_LK_tab, nb_seq, 'single');    
    nb_lyr_min_error_tab = zeros(nb_layers_evaluated, nb_seq, 'single');
    nb_iter_min_error_tab = zeros(nb_iter_evaluated, nb_seq, 'single');
    
    sg_init_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    sg_subspl_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    sg_LK_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    nb_lyr_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    nb_iter_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    
    sg_init_min_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    sg_subspl_min_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    sg_LK_min_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    nb_lyr_min_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    nb_iter_min_error_std_dev_tab = zeros(nb_seq, 1, 'single');
    
    for im_seq_idx = 1:nb_seq
    
        % sigma_init
        for sg_init_idx = 1:length_sg_init_tab   
            sg_init_error_tab(sg_init_idx, im_seq_idx) = mean(reshape(rms_error_all_seq(:, :, :, sg_init_idx, :, im_seq_idx), [], 1));
            sg_init_min_error_tab(sg_init_idx, im_seq_idx) = min(reshape(rms_error_all_seq(:, :, :, sg_init_idx, :, im_seq_idx), [], 1));
        end
        sg_init_error_std_dev_tab(im_seq_idx) = std(sg_init_error_tab(:,im_seq_idx));
        sg_init_min_error_std_dev_tab(im_seq_idx) = std(sg_init_min_error_tab(:,im_seq_idx));

        % sigma_subspl
        for sg_subspl_idx = 1:length_sg_subspl_tab   
            sg_subspl_error_tab(sg_subspl_idx, im_seq_idx) = mean(reshape(rms_error_all_seq(:, :, :, :, sg_subspl_idx, im_seq_idx), [], 1));
            sg_subspl_min_error_tab(sg_subspl_idx, im_seq_idx) = min(reshape(rms_error_all_seq(:, :, :, :, sg_subspl_idx, im_seq_idx), [], 1));
        end
        sg_subspl_error_std_dev_tab(im_seq_idx) = std(sg_subspl_error_tab(:,im_seq_idx));
        sg_subspl_min_error_std_dev_tab(im_seq_idx) = std(sg_subspl_min_error_tab(:,im_seq_idx));
        
        % sigma_LK
        for sg_LK_idx = 1:length_sg_LK_tab  
            sg_LK_error_tab(sg_LK_idx, im_seq_idx) = mean(reshape(rms_error_all_seq(:, sg_LK_idx, :, :, :, im_seq_idx), [], 1));
            sg_LK_min_error_tab(sg_LK_idx, im_seq_idx) = min(reshape(rms_error_all_seq(:, sg_LK_idx, :, :, :, im_seq_idx), [], 1));
        end
        sg_LK_error_std_dev_tab(im_seq_idx) = std(sg_LK_error_tab(:,im_seq_idx));
        sg_LK_min_error_std_dev_tab(im_seq_idx) = std(sg_LK_min_error_tab(:,im_seq_idx));
        
        % nb of layers
        for nb_lyr_idx = 1:nb_layers_evaluated
            nb_lyr_error_tab(nb_lyr_idx, im_seq_idx) = mean(reshape(rms_error_all_seq(nb_lyr_idx, :, :, :, :, im_seq_idx), [], 1));
            nb_lyr_min_error_tab(nb_lyr_idx, im_seq_idx) = min(reshape(rms_error_all_seq(nb_lyr_idx, :, :, :, :, im_seq_idx), [], 1));
        end
        nb_lyr_error_std_dev_tab(im_seq_idx) = std(nb_lyr_error_tab(:,im_seq_idx));   
        nb_lyr_min_error_std_dev_tab(im_seq_idx) = std(nb_lyr_min_error_tab(:,im_seq_idx));   
        
        % nb of iterations
        for nb_iter_idx = 1:nb_iter_evaluated
            nb_iter_error_tab(nb_iter_idx, im_seq_idx) = mean(reshape(rms_error_all_seq(:, :, nb_iter_idx, :, :, im_seq_idx), [], 1));
            nb_iter_min_error_tab(nb_iter_idx, im_seq_idx) = min(reshape(rms_error_all_seq(:, :, nb_iter_idx, :, :, im_seq_idx), [], 1));
        end
        nb_iter_error_std_dev_tab(im_seq_idx) = std(nb_iter_error_tab(:,im_seq_idx));   
        nb_iter_min_error_std_dev_tab(im_seq_idx) = std(nb_iter_min_error_tab(:,im_seq_idx));   
        
    end
    
    %% Writing the analysis results in a txt file

    path_par.OFparam_influence_entire_fname = sprintf('%s\\%s', path_par.txt_file_dir, path_par.OFparam_influence_log_filename);
    fid = fopen(path_par.OFparam_influence_entire_fname,'wt');
    
    date = sprintf('%s %s', datestr(datetime, 'yyyy - mm - dd HH AM MM'), 'min');
    fprintf(fid, '%s \n',date);
    
    fprintf(fid, 'Gradient method : %s \n', OFeval_par.grad_meth_str);
    fprintf(fid, 'Determinant threshold for solving the linear system for each pixel %f \n', OFeval_par.epsilon_detG);
    fprintf(fid, '\n');
    
    length_sg_init_tab = length(OFeval_par.sigma_init_tab);
    length_sg_subspl_tab = length(OFeval_par.sigma_subspl_tab);
    length_sg_LK_tab = length(OFeval_par.sigma_LK_tab);
    
    fprintf(fid, 'Range of parameters tested \n');  
    fprintf(fid, 'sg_init (std dev of the gaussian initial filtering) : \n');
    for sg_init_idx = 1:length_sg_init_tab
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
    for sigma_subspl_idx = 1:length_sg_subspl_tab
       fprintf(fid, '%g \t', OFeval_par.sigma_subspl_tab(sigma_subspl_idx)); 
    end
    fprintf(fid, '\n');    
    fprintf(fid, 'sg_LK (std dev of the gaussian function used in the basic Lucas Kanade algorithm - columns) : \n');
    for sigma_LK_tab_idx = 1:length_sg_LK_tab   
       fprintf(fid, '%g \t', OFeval_par.sigma_LK_tab(sigma_LK_tab_idx)); 
    end
    fprintf(fid, '\n \n');
    
    for im_seq_idx = 1:nb_seq
       fprintf(fid, '%d -th image sequence studied : \n', im_seq_idx); 
       fprintf(fid, 'image sequence %s \n',path_par.input_im_dir_suffix_tab(im_seq_idx));
        if beh_par.EVALUATE_IN_ROI
            fprintf(fid, 'evaluation in the region of interest \n');
        else
            fprintf(fid, 'evaluation in the entire image \n');
        end
        fprintf(fid, '\n');
        
    end
    
    fprintf(fid, 'Lines : Parameter variation \n'); 
    fprintf(fid, 'Columns : image sequence studied \n'); 
    
         
    fprintf(fid, 'Mean error as a function of sg_init : \n'); 
    for ii = 1:size(sg_init_error_tab,1)
        fprintf(fid,'%g\t',sg_init_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');
    fprintf(fid, 'Min error as a function of sg_init : \n'); 
    for ii = 1:size(sg_init_min_error_tab,1)
        fprintf(fid,'%g\t',sg_init_min_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');

    fprintf(fid, 'Mean error as a function of sg_subspl : \n'); 
    for ii = 1:size(sg_subspl_error_tab,1)
        fprintf(fid,'%g\t',sg_subspl_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');
    fprintf(fid, 'Min error as a function of sg_subspl : \n'); 
    for ii = 1:size(sg_subspl_min_error_tab,1)
        fprintf(fid,'%g\t',sg_subspl_min_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');

    fprintf(fid, 'Mean error as a function of sg_LK : \n'); 
    for ii = 1:size(sg_LK_error_tab,1)
        fprintf(fid,'%g\t',sg_LK_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');
    fprintf(fid, 'Min error as a function of sg_LK : \n'); 
    for ii = 1:size(sg_LK_min_error_tab,1)
        fprintf(fid,'%g\t',sg_LK_min_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');    

    fprintf(fid, 'Mean error as a function of nb_lyr : \n'); 
    for ii = 1:size(nb_lyr_error_tab,1)
        fprintf(fid,'%g\t',nb_lyr_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');
    fprintf(fid, 'Min error as a function of nb_lyr : \n'); 
    for ii = 1:size(nb_lyr_min_error_tab,1)
        fprintf(fid,'%g\t',nb_lyr_min_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n'); 

    fprintf(fid, 'Mean error as a function of nb_iter : \n'); 
    for ii = 1:size(nb_iter_error_tab,1)
        fprintf(fid,'%g\t',nb_iter_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');
    fprintf(fid, 'Min error as a function of nb_iter : \n'); 
    for ii = 1:size(nb_iter_min_error_tab,1)
        fprintf(fid,'%g\t',nb_iter_min_error_tab(ii,:));
        fprintf(fid,'\n');
    end
    fprintf(fid, '\n');      
    
    fprintf(fid, 'In the next results, each column correspond to each image sequence \n'); 
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the mean error as a function of sg_init : \n'); 
    fprintf(fid,'%g\t',sg_init_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the min error as a function of sg_init : \n'); 
    fprintf(fid,'%g\t',sg_init_min_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the mean error as a function of sg_subspl : \n'); 
    fprintf(fid,'%g\t',sg_subspl_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the min error as a function of sg_subspl : \n'); 
    fprintf(fid,'%g\t',sg_subspl_min_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the mean error as a function of sg_LK : \n'); 
    fprintf(fid,'%g\t',sg_LK_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the min error as a function of sg_LK : \n'); 
    fprintf(fid,'%g\t',sg_LK_min_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the mean error as a function of nb_lyr : \n'); 
    fprintf(fid,'%g\t',nb_lyr_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the min error as a function of nb_lyr : \n'); 
    fprintf(fid,'%g\t',nb_lyr_min_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the mean error as a function of nb_iter : \n'); 
    fprintf(fid,'%g\t',nb_iter_error_std_dev_tab(:));
    fprintf(fid,'\n');
    
    fprintf(fid, 'Standard deviation of the min error as a function of nb_iter : \n'); 
    fprintf(fid,'%g\t',nb_iter_min_error_std_dev_tab(:));
    fprintf(fid,'\n');    

    fclose(fid);
    
    
    
end

