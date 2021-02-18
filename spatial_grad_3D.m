  function [ spatial_grad_I ] = spatial_grad_3D(I, OF_par)
% Computation of the spatial gradient of a 3D image I
% If x = 1 or x = L or y = 1 or y = H or z = 1 or z = Zmax or t = 1 or t = T, then
% delta_I(y,x,t,k) = 0.
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    [W, L, H] = size(I);
    spatial_grad_I = zeros(W, L, H, 3, 'single');
    
	switch(OF_par.grad_meth)
    
        case 1
            % Central method difference
    
            for x = 2:L-1
               spatial_grad_I(:,x,:,1) = I(:,x+1,:)-I(:,x-1,:);
            end

            for y = 2:W-1
                spatial_grad_I(y,:,:,2) = I(y+1,:,:)-I(y-1,:,:);
            end
            
            for z = 2:H-1
               spatial_grad_I(:,:,z,3) = I(:,:,z+1)-I(:,:,z-1);
            end

            spatial_grad_I = 0.5*spatial_grad_I;
        
        case 2
           % Schaar gradient
           % https://en.wikipedia.org/wiki/Image_gradient
 
           K_3DSchaar_x = zeros(3,3,3);
           K_3DSchaar_x(:,1,:) = [1, 30, 1; 30, 100, 30; 1, 30, 1];
           K_3DSchaar_x(:,3,:) = -[1, 30, 1; 30, 100, 30; 1, 30, 1];
           spatial_grad_I(:,:,:,1) = convn(I, K_3DSchaar_x, 'same');
           
           K_3DSchaar_y = zeros(3,3,3);
           K_3DSchaar_y(1,:,:) = [1, 30, 1; 30, 100, 30; 1, 30, 1];
           K_3DSchaar_y(3,:,:) = -[1, 30, 1; 30, 100, 30; 1, 30, 1];
           spatial_grad_I(:,:,:,2) = convn(I, K_3DSchaar_y, 'same');
           
           K_3DSchaar_z = zeros(3,3,3);
           K_3DSchaar_z(:,:,1) = [1, 30, 1; 30, 100, 30; 1, 30, 1];
           K_3DSchaar_z(:,:,3) = -[1, 30, 1; 30, 100, 30; 1, 30, 1];
           spatial_grad_I(:,:,:,3) = convn(I, K_3DSchaar_z, 'same');
           
           spatial_grad_I = (1/448)*spatial_grad_I;
        
	end
    
    
end