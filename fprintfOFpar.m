function fprintfOFpar( fid, OF_par )
% Prints on the console the parameters associated to the DVF calculation with the optical flow method
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

    % fid for file id
    
    fprintf(fid, 'Pyramidal representation parameters \n');
    fprintf(fid, '\t Initial gaussian filtering of strd dev %f \n', OF_par.sigma_init);
    fprintf(fid, '\t Number of layers : %d \n', OF_par.nb_layers);
    fprintf(fid, '\t Gaussian filtering before subsampling, with strd dev %f \n', OF_par.sigma_subspl);
    fprintf(fid, 'Lukas-Kanade optical flow parameters \n');
    fprintf(fid, '\t Gradient method : %s \n', OF_par.grad_meth_str);
    fprintf(fid, '\t Number of iterations per layer : %d \n', OF_par.nb_iter);
    fprintf(fid, '\t Gaussian filtering before solving the linear system for each pixel, with strd dev : %f \n', OF_par.sigma_LK);
    fprintf(fid, '\t Determinant threshold for solving the linear system for each pixel %f \n', OF_par.epsilon_detG);

end

