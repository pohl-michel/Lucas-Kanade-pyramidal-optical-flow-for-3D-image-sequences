function save_3DOFpng(beh_par, path_par, disp_par, OF_par, im_par)
% Load the optical flow previously calculated by compute_3Dof,
% and displays its projection on a Y-slice of coordinates disp_par.Ycs
% The DVF images are saved in the folder path_par.im_par_filename.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    % loading image at time t=1
    im3D_t1 = load_crop_filter3D(1, beh_par.CROP_FOR_DISP_SAVE, false, 0, im_par, path_par.input_im_dir);
    background_im = enhance_2Dim(transpose(squeeze(im3D_t1(disp_par.Ycs_after_crop, :, :))), true);  
        % the image is cropped if we select a specific region where the optical flow should be displayed (beh_par.CROP_FOR_DISPLAY = 1)
        % The image is not filtered because it is used to display the optical flow here (FILTER = false)
        % Transposition because otherwise horizontally will be the Z axis and vertically the X axis
    clear im3D_t1
    [H, L] = size(background_im); 
 
    x = 1:L; % coordinates in the image
    z = 1:H;
    [X,Z] = meshgrid(x,z);
    % the matrices X and Y have the same dimensions : H*L 
    
    % creation of a mask for displaying arrows spaced by dist_vec only.
    G = zeros(H,L);
    i_max = floor((L-1)/disp_par.dist_vec);
    j_max = floor((H-1)/disp_par.dist_vec);
    for i = 0:i_max % x-coordinate / dist_vec
        for j = 0:j_max % y-coordinate / dist_vec
            G(1+j*disp_par.dist_vec,1+i*disp_par.dist_vec) = 1;
        end
    end    
    
    % preparation of the variable containing the 2D optical flow
    u_t_2D = zeros(H, L, 2, 'single');
    
    for t=2:im_par.nb_im
        
        if ~beh_par.IS_BACKGROUND_FIRST_IMG
            im3D_t = load_crop_filter3D(t, beh_par.CROP_FOR_DISP_SAVE, false, 0, im_par, path_par.input_im_dir);
            background_im = enhance_2Dim(transpose(squeeze(im3D_t(disp_par.Ycs_after_crop, :, :))), true);  
            clear im3D_t
        end

        % loading optical flow at time t
        OF_t_filename = write_3DOF_t_mat_filename(OF_par, path_par, t );
        load(OF_t_filename, 'u_t');
        if beh_par.CROP_FOR_DISP_SAVE
            v_temp = u_t(im_par.y_m:im_par.y_M, im_par.x_m:im_par.x_M, im_par.z_m:im_par.z_M,:);
            u_t = v_temp;
        end
        
        % projection of 3D-OF on the plane Y = Yslice
        u_t_2D(:,:,1) = transpose ( squeeze( u_t(disp_par.Ycs_after_crop, :, :, 1) ) ) ; % 1st component in 2D = X component in 3D
        u_t_2D(:,:,2) = transpose ( squeeze( u_t(disp_par.Ycs_after_crop, :, :, 3) ) ) ; % 2nd component in 2D = Z component in 3D
        
        f = figure;        
        % im2D_t1(:) = 0; % 

        imshow(background_im, []);      
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        
        hold on
        quiver(X,Z,disp_par.arrow_scale_factor*(u_t_2D(:,:,1).*G), disp_par.arrow_scale_factor*(u_t_2D(:,:,2).*G), 'Autoscale', 'off', 'linewidth', disp_par.OF_arw_width, ...
            'color', [1 1 1]);
        hold off
        
        if beh_par.SAVE_OF_PNG
            
            filename = write_3DOF_t_png_filename( beh_par, OF_par, path_par, disp_par, t );
            set(gca,'position',[0 0 1 1],'units','normalized');
            set(gcf, 'InvertHardCopy', 'off');
            print(filename, '-dpng', disp_par.OF_res);
        end
        
        close(f);
        
    end
    
end