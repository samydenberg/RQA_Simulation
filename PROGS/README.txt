To run 'main.m' file, add the folder "PROGRAMS" with subfolders to the path in Matlab. 

Then, click "Run" in Matlab Editor.

'Run_gDPM.ipynb' runs gDPM on a GPU, this code is not included due to it being private

'fAnimation.m' animates the system setup

'fCollimator.m' builds a 3D collimator 

'fEnergy.m' filters detected by PCD photons based on the specified energy threshold

'fInput.m' reads the gDPM output files

'fParticleView.m' shows photon position in the system environment

'fPCD.m' records photons detected by PCD without a true collimator present

'fPCD_col.m' records photons detected by PCD with a collimator placed in front of it

'fPcount.m' computes longitudinal photon counts

'fPcountMap.m' creates a heatmap of photon counts on the detector sensor

'fPvsDose.m' plots the gDPM depth-dose profile vs scattered photons' counts

'Instructions.txt' contains instructions for running the 'main.m' file

'main.m' is the main program responsible for the execution of other source files

'PSFcenter.m' evaluates the scoring sphere center position

'PSFradius.m' evaluates the scoring sphere radius

'unit_testing.m' unit tests of the code major functions



Notations:

PCD - photon counting detector
gDPM - GPU-based dose planning method [1,2]

References:
[1] Jia, X. & Jiang, S.B. (2011). gDPM v2.0. A GPU-based Monte Carlo simulation 
    package for radiotherapy dose calculation. The Center for Advanced Radiotherapy 
    Technologies (CART), UCSD.
[2] Jia, X., Ziegenhein, P., & Jiang, S. B. (2014). GPU-based high-performance 
    computing for radiation therapy. Physics in Medicine and Biology, 59(4), 
    p. R151–R182.
[3] Singh Side, K (2022) Google-Colab-Shell [Source Code]. https://github.com/singhsidhukuldeep/Google-Colab-Shell
[4] Nechaev, I (2019) nvcc4jupyter [Source Code]. https://github.com/andreinechaev/nvcc4jupyter
[5] Google. “External Data: Local Files, Drive, Sheets, and Cloud Storage.” Google Colab. 

