This program computes the deformation vector field (DVF) of a series of 3D images.
It registers the first image with the others
by using the pyramidal Lucas-Kanade optical flow algorithm.

The animation below shows the computed DVFs (actually the 2D coronal projection of the computed 3D DVFs) corresponding to the motion of a lung tumor on top of the initial tumor image (actually the cooronal cross-section of that initial 3D image). The vectors point up and down as the tumor moves with the breathing motion.

<img src="3DOF_4DCT.gif" width="40%" height="40%"/>

We used this code (including the hyper-parameter optimization, cf below) in the following research article: Michel Pohl, Mitsuru Uesaka, Kazuyuki Demachi, Ritu Bhusal Chhatkuli,
Prediction of the motion of chest internal points using a recurrent neural network trained with real-time recurrent learning for latency compensation in lung cancer radiotherapy,
Computerized Medical Imaging and Graphics,
Volume 91,
2021,
101941,
ISSN 0895-6111,
https://doi.org/10.1016/j.compmedimag.2021.101941.
Please consider citing that article if you use this code in your research.

Our implementation is based on the following research article (there are some small differences though) :
Bouguet, Jean-Yves, 
"Pyramidal implementation of the affine Lucas Kanade feature tracker description of the algorithm.", 
Intel corporation 5.1-10 (2001): 4. 

The main function to execute is "Lucas_Kanade_Pyramidal_Optical_Flow_Main.m".
The input image sequence is placed in the "Input images" folder.
Parameters concerning the image sequence itself, the DVF calculation, and the DVF display
are located respectively in the "3Dim_seq_par.xlsx" file, the "3DOF_calc_par.xlsx" file, and the "3Ddisp_par.xlsx" file.

The behavior of the program is controlled by the structure beh_par defined in "load_behavior_parameters3D()",
and its fields can be changed manually.
Also, the name of the input sequences whose DVF is computed needs to be specified in the "input_im_dir_suffix_tab" array.

The resulting DVF, the DVF visualization, and the evaluation log file 
will be saved respectively in the folders "Optical flow calculation results mat files",
"Optical flow projection images" and "Log files".
The root-mean-square error (RMSE) of the registration can be found in that log file.

We also included three 4DCT sequences of tumors of patients with lung cancer,
acquired by a 16-slice helical CT simulator (Brilliance Big Bore, Philips Medical System)
in Virginia Commonwealth University Massey Cancer Center,
which were downloaded from the Cancer Imaging Archive open database.

Also, by running "Lucas_Kanade_Pyramidal_Optical_Flow_Optimization_Main.m", one can perform hyper-parameter optimization by grid search to find an accurate DVF.
The hyper-parameters grid is specified in the file "load_3DOF_hyperparameters.m".
The results of the optimization is saved in the files "DVF optim log file.txt" and "DVF hyperpar influence (date and time).txt" 

More details about these sequences can be found in :
 - Hugo, Geoffrey D., Weiss, Elisabeth, Sleeman, William C., Balik, Salim, Keall, Paul J., Lu, Jun, & Williamson, Jeffrey F. (2016). Data from 4D Lung Imaging of NSCLC Patients. The Cancer Imaging Archive. http://doi.org/10.7937/K9/TCIA.2016.ELN8YGLE
 - Hugo, G. D., Weiss, E., Sleeman, W. C., Balik, S., Keall, P. J., Lu, J. and Williamson, J. F. (2017), A longitudinal four-dimensional computed tomography and cone beam computed tomography dataset for image-guided radiation therapy research in lung cancer. Med. Phys., 44: 762–771. doi:10.1002/mp.12059
 - S. Balik et al., “Evaluation of 4-Dimensional Computed Tomography to 4-Dimensional Cone-Beam Computed Tomography Deformable Image Registration for Lung Cancer Adaptive Radiation Therapy.” Int. J. Radiat. Oncol. Biol. Phys. 86, 372–9 (2013) PMCID: PMC3647023.
 - N.O. Roman, W. Shepherd, N. Mukhopadhyay, G.D. Hugo, and E. Weiss, “Interfractional Positional Variability of Fiducial Markers and Primary Tumors in Locally Advanced Non-Small-Cell Lung Cancer during Audiovisual Biofeedback Radiotherapy.” Int. J. Radiat. Oncol. Biol. Phys. 83, 1566–72 (2012). DOI:10.1016/j.ijrobp.2011.10.051
 - Clark K, Vendt B, Smith K, Freymann J, Kirby J, Koppel P, Moore S, Phillips S, Maffitt D, Pringle M, Tarbox L, Prior F. The Cancer Imaging Archive (TCIA): Maintaining and Operating a Public Information Repository, Journal of Digital Imaging, Volume 26, Number 6, December, 2013, pp 1045-1057. DOI: 10.1007/s10278-013-9622-7


