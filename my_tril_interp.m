function interVal = my_tril_interp(img, Zmax, Ymax, Xmax, z, y, x)
% Trilinear interpolation using 8 pixels around the target location
% img is a 3D image
% z, y and x the coordinates of the point to be interpolated
% zeros are used for pixel values outside of the given image
%
% Author : Pohl Michel
% Date : July 16th, 2020
% Version : v1.0
% License : 3-clause BSD License

x0 = floor(x);
y0 = floor(y);
z0 = floor(z);

eps_x = x - x0; eps_conj_x = 1 - eps_x;
eps_y = y - y0; eps_conj_y = 1 - eps_y;
eps_z = z - z0; eps_conj_z = 1 - eps_z;

interVal = ... 
    eps_x*     (eps_y*     (eps_conj_z*pixLookup(img, Zmax, Ymax, Xmax, z0, y0+1, x0+1) + eps_z*pixLookup(img, Zmax, Ymax, Xmax, z0+1, y0+1, x0+1))  + ...
                eps_conj_y*(eps_conj_z*pixLookup(img, Zmax, Ymax, Xmax, z0, y0  , x0+1) + eps_z*pixLookup(img, Zmax, Ymax, Xmax, z0+1, y0  , x0+1))) + ...
    eps_conj_x*(eps_y*     (eps_conj_z*pixLookup(img, Zmax, Ymax, Xmax, z0, y0+1, x0  ) + eps_z*pixLookup(img, Zmax, Ymax, Xmax, z0+1, y0+1, x0  ))  + ...
                eps_conj_y*(eps_conj_z*pixLookup(img, Zmax, Ymax, Xmax, z0, y0  , x0  ) + eps_z*pixLookup(img, Zmax, Ymax, Xmax, z0+1, y0  , x0  )));

end

function pixVal = pixLookup(img, Zmax, Ymax, Xmax, z, y, x)
   % in this function x and y are integer coordinates
   if (x<=0)||(x>Xmax)||(y<=0)||(y>Ymax)||(z<=0)||(z>Zmax)
       pixVal = 0; % padding with zeros
   else
       pixVal = img(y,x,z);
   end
end