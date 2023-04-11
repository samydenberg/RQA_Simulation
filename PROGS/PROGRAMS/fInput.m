% Read the gDPM output files
% Input: 
%          path to the gDPM output files
% Output: 
%          "pos" - Photon position on the scoring sphere (x, y, z, r) in cm
%          "dir" - Photon direction as a unit vector (x, y, z) in cm and photon
%                  energy in eV
%          "dose" - Delievered dose in Gy/particle 
% 
% by Dr. Yujie Chi, Tatiana Kashtanova, and Samuel Ydenberg


function [pos, dir, dose] = fInput(path)

    % Photon position on the scoring sphere (x, y, z, r)
    fp = strcat(path,"PSFpos.dat");
    f = fopen(fp);
    pos = fread(f,'float');
    fclose(f);
    pos = reshape(pos,[4,length(pos)/4]); 
    pos = pos';
    pos(:,4)=sqrt(sum(pos(:,1:3).*pos(:,1:3),2));
     
    % Photon direction (x, y, z) and energy
    fp = strcat(path,"PSFdir.dat");
    f = fopen(fp);
    dir = fread(f,'float');
    fclose(f);
    dir = reshape(dir,[4,length(dir)/4]);
    dir = dir'; 
    
    % Flip z-coordinates
    pos(:,3) = -pos(:,3);
    dir(:,3) = -dir(:,3);
    
    % Delievered dose in Gy/particle
    dose_path = strcat(path,'dose.img');
    fid  = fopen(dose_path);
    data = fread(fid,'single');
    fclose(fid);
    % Dose scaling per the mentors' guidance
    data2 = data.*1.6*10^(-10);
    dose = reshape(data2,[150 150 150]);

    % 2D gDPM depth-dose profile
    figure
    J = imrotate(dose(:,:,75),180);
    contourf(J)
    c = colorbar;
    xlabel('Width, x (cm)','fontsize',12,'fontweight','bold')
    ylabel('Depth, z (cm)','fontsize',12,'fontweight','bold')
    ylabel(c,'Dose (Gy/particle)','fontsize',12,'fontweight','bold','Rotation',270);
    c.Label.Position (1:2) = [3 mean(c.Limits)];
    xticks([0 25 50 75 100 125 150])
    xticklabels({'0', '5', '10', '15', '20', '25', '30'})
    yticks([0 25 50 75 100 125 150])
    yticklabels({'0', '5', '10', '15', '20', '25', '30'})
    title("2D gDPM depth-dose profile") 
    %saveas(gcf, "2D_Dose.png")
end






