% Filter detected by PCD photons based on the specified energy threshold
% Input: 
%       "posPCD" - Detected photon position on the scoring surface
%       "dirPCD" - Detected photon direction and energy
%       "posPCD_s" - Detected photon position on the PCD sensor area
%       "energy" - Energy threshold
%       "dx" - Distance between the centers of the scoring sphere and PCD sensor area in cm
%       "name" - Energy threshold label
%       
% Output:
%       "posEn" - Filtered photon position on the scoring surface
%       "dirEn" - Filtered photon direction and energy
%       "posEn_s" - Filtered photon position on the PCD sensor area
%       "f" - 2D detector sensor signal
% 
% by Tatiana Kashtanova


function [posEn, dirEn, posEn_s, f] = fEnergy(posPCD, dirPCD, posPCD_s, energy, dx, name)
    c = dirPCD(:,4) >= energy;
    posEn = posPCD(c,:);
    dirEn = dirPCD(c,:);
    posEn_s = posPCD_s(c,:);

    f = figure;
    scatter(posEn_s(:,2), posEn_s(:,3), 10, dirEn(:,4), 'filled')
    c = colorbar;
    xlabel('y (cm)','fontsize',12,'fontweight','bold')
    ylabel('z (cm)','fontsize',12,'fontweight','bold')
    colormap turbo
    ylabel(c,'Energy (eV)','fontsize',12,'fontweight','bold','Rotation',270);
    c.Label.Position (1:2) = [3.5 mean(c.Limits)];
    title("Nominal energy " + name + "; Distance " + dx + " cm") 
    saveas(gcf, strcat(string(energy), "_", string(dx), "_", "2DSignal.png"))
end








