% Unit tests of the code major functions
%
% by Samuel Ydenberg


%% Test of photon movement
clc;
clear;
% Photon position on the scoring sphere (x, y, z, r) in cm
pos = [0,0,0,0; 0,0,0,0;0,0,0,0];
% Photon direction (x, y, z) in cm and photon energy in eV
dir = [1,0,0,0;0,1,0,0;0,0,1,0];
% Distance between the centers of the scoring sphere and PCD sensor area in cm
sensor_dist = 100;
% Visualization space phases
num_frames = 100;
axes_limit = 100;
fin_pos = fAnimation(pos,dir,sensor_dist,axes_limit,num_frames,1,"on");

% Expected final position is 100,0,0
if fin_pos(1) == 100 && fin_pos(2) == 0 && fin_pos(3) == 0
    disp("Test passed, particle movement successful")
end

%% Test of detector sorting
% Distance between the centers of the scoring sphere and PCD sensor area in cm
dx = 100;
% PCD sensor coordinates in cm
sensor_x = [dx;dx;dx;dx];
sensor_y = [0;0;30;30];
sensor_z = [-30;0;0;-30];

% Photon starting at [0,10,-10] and moving in x-direction should
%    collide with the detector
% Photon starting at [0,-1,0] nd moving in x-direction shouldn't
%    collide with the detectoror
% Photon position on the scoring sphere (x, y, z, r) in cm
pos = [0,10,-10,30;30,-1,0,30];
% Photon direction (x, y, z) in cm and photon energy in eV
dir = [1,0,0,1e6;1,0,0,1e6];

[fin_pos,fin_dir,~] = fPCD(pos,dir,dx,sensor_y,sensor_z);
[~] = fAnimation(pos,dir,sensor_dist,axes_limit,70,1,"on");

if size(fin_pos,1) == 1
   disp("Test passed, detector sorting successful") 
end

%% Test of photon sorting based on energy threshold
% Photon position on the scoring sphere (x, y, z, r) in cm
pos = [0,10,-10,0;0,20,-20,0;0,25,-25,0];
% Photon direction (x, y, z) in cm and photon energy in eV
dir = [1,0,0,10e5;1,0,0,10e3;1,0,0,10e7];
% Photon position on the PCD sensor area
pos_s = [100,10,-10,0;100,20,-20,0;100,25,-25,0];

% Energy threshold
thresh = 10e4;
name = "Test";

[posEn, dirEn, posEn_s, f] = fEnergy(pos, dir, pos_s, thresh, dx, name);

% Plots
figure
subplot(1,2,1)
scatter(pos(:,2),pos(:,3),40,"b","filled")
%set(gca,"color","r")
axis([0 30 -30 0])

subplot(1,2,2)
scatter(posEn(:,2),posEn(:,3),40,"b","filled")
%set(gca,"color","r")
axis([0 30 -30 0])

%% Collimator design
[~,~, f] = fCollimator(0,5,-5,0,10, "on");
