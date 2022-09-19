function [ u_bottom ] = pyr_LK_3D( pyr_I, pyr_J, OF_par )
% Given the pyramidal representation pyr of two images I and J 
% This function computes the deformation vector field between I and J using the pyramidal Lucas Kanade method.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    u_temp = cell(OF_par.nb_layers,1);
    [top_w, top_l, top_h] = size(pyr_I{OF_par.nb_layers});
    u_temp{OF_par.nb_layers} = zeros(top_w, top_l, top_h, 3, 'single');
        % u_temp{lyr_idx}(y,x,z,1) contains the x coordinate of the original guess at the layer lyr_idx and pixel (x,y,z)
        % u_temp{lyr_idx}(y,x,z,2) ------------ y -----------------------------------------------------------------------
        % u_temp{lyr_idx}(y,x,z,3) ------------ z -----------------------------------------------------------------------
    aux = @(x) floor((x+1)/2); % auxiliary function for indexing
             
    for lyr_idx = OF_par.nb_layers:(-1):1 % "-1" for decrementation

        % Calculation of the optical flow refinement 
        fprintf('\t Refining the optical flow at the layer %d \n', lyr_idx);  
        u_temp{lyr_idx} = iterative_3Dof( pyr_I{lyr_idx}, pyr_J{lyr_idx}, u_temp{lyr_idx}, OF_par );
            % I = pyr{lyr_idx}; % representation of the 1st image of the sequence at the layer lyr_idx
            % J = pyr{lyr_idx}; % --------------------- 2nd ------------------------------------------
            % u_temp{lyr_idx} in the arguments is the guess at the layer lyr_idx ("g" in the paper from Intel, 2010)
            % u_temp{lyr_idx} in the output is the refined optical flow at the layer lyr_idx ("g+d" in the paper from Intel, 2010)
        
        % guess g at the layer below
        if (lyr_idx>1)
            fprintf('\t Guessing the optical flow at the layer %d \n', lyr_idx-1);           
            [W_below, L_below, H_below] = size(pyr_I{lyr_idx-1});            
            Y = aux(1:W_below);
            X = aux(1:L_below);
            Z = aux(1:H_below);
            u_temp{lyr_idx-1} = 2*u_temp{lyr_idx}(Y,X,Z,:);
                % u_temp{lyr_idx-1}(y, x, z, :) = 2*u_temp{lyr_idx}(aux(y), aux(x), aux(z), :)
        end

    end

    u_bottom = u_temp{1};

end