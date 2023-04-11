% The main program responsible for the execution of other source files
% Input: 
%          Path to the gDPM output files obtained with the sphere center set 
%          to (15,15,15) cm and the sphere radius set to 26 cm,
%          the number of simulated particles is 10^8
% Output: 
%          A plot with 2D PCD sensor signal
%          A plot with the gDPM depth-dose profile vs scattered photons' counts 
%          (with and without a collimator present)
% 
% by Tatiana Kashtanova

clc;
clear;

% Path to the gDPM output files
path = strcat("./data/8_PSF_15.15.15_26/");

% "pos" - Photon position on the scoring sphere (x, y, z, r) in cm
% "dir" - Photon direction as a unit vector (x, y, z) in cm and photon
% energy in eV
% "dose" - Delievered dose in Gy/particle 
[pos, dir, dose] = fInput(path);

% PCD sensor coordinates in cm
sy = [0;0;30;30];
sz = [-30;0;0;-30];
% Distance between the centers of the scoring sphere and PCD sensor area in cm
dx_list = [45, 65];

% Photon energy thresholds in eV
e_list = [100000, 250000];

% For each distance 
 %   Index "1" - no collimator
 %   Index "2" - with a collimator
for i = 1:length(dx_list)
    dx = dx_list(i);
   
    % Photons detected by PCD (no collimator):
    %   "posPCD" - Photon position on the scoring surface
    %   "dirPCD" - Photon direction and energy
    %   "posPCD_s" - Photon position on the PCD sensor area
    [posPCD1, dirPCD1, posPCD1_s] = fPCD(pos, dir, dx, sy, sz);
    [hexagons,~, ~] = fCollimator(sy(1),sy(3),sz(1),sz(2),dx, "on");
    [posPCD2, dirPCD2, posPCD2_s] = fPCD_col(posPCD1, dirPCD1, posPCD1_s, hexagons);
    
    % For each energy threshold 
    for j = 1:length(e_list)
        energy = e_list(j);
        % "col" - Color 
        % "name" - Energy threshold label
        if energy == 100000
            col = 'red';
            name = '>=100 keV';
        else 
            col = 'blue';
            name = '>=250 keV';
        end

        % Photons detected by PCD and met the energy threshold:
        %   "posEn" - Photon position on the scoring surface
        %   "dirEn" - Photon direction and energy
        %   "posEn_s" - Photon position on the PCD sensor area
        %   "fig_a" - 2D detector sensor signal
        [posEn1, dirEn1, posEn1_s, fig_a1] = fEnergy(posPCD1, dirPCD1, posPCD1_s, energy, dx, name);
        [posEn2, dirEn2, posEn2_s, fig_a2] = fEnergy(posPCD2, dirPCD2, posPCD2_s, energy, dx, name);

        % Heatmap of photon counts
        fig_b1 = fPcountMap(posEn1_s,sy,sz);
        fig_b2 = fPcountMap(posEn2_s,sy,sz);

        % Longitudinal photon counts
        counts1 = fPcount(posEn1_s);
        counts2 = fPcount(posEn2_s);

        % The gDPM depth-dose profile vs scattered photons' counts
        fig_c1 = fPvsDose(counts1, dose, energy, dx, name, col);
        fig_c2 = fPvsDose(counts2, dose, energy, dx, name, col);
    end 
end


