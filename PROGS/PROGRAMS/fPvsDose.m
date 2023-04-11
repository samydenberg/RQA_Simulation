% Plot the gDPM depth-dose profile vs scattered photons' counts
% Input: 
%       "counts" - longitudinal photon counts 
%       "dose" - gDPM delievered dose in Gy/particle
%       "energy" - Energy threshold
%       "dx" - Distance between the centers of the scoring sphere and PCD sensor area in cm
%       "name" - Energy threshold label
%       "col" - Color 
% Output:
%       A plot showing the gDPM depth-dose profile vs scattered photons' counts
%
% by Tatiana Kashtanova and Samuel Ydenberg


function f = fPvsDose(counts, dose, energy, dx, name, col)

    % gDPM longitudinal dose profile in Gy
    dose_data = zeros(1,150);
    for i = 1:150
        J = dose(:,:,i);
        for j  = 1:150
            K = sum(J(j,:));
            dose_data(j) = dose_data(j) + K;
        end
    end
    
    % Dose vs photon counts
    f = figure;
    yyaxis left
    plot(dose_data, 'linewidth', 1, 'color', 'black', 'DisplayName', 'gDPM')
    xlabel('Depth, z (cm)','fontsize',12,'fontweight','bold')
    ylabel('Dose (Gy)','fontsize',12,'fontweight','bold','color','black')
    yyaxis right
    voxels = 1:15:150;
    scatter(voxels, counts, col, 'DisplayName', name)
    ylabel('Photon counts','fontsize',12,'fontweight','bold')
    xticks([0 50 100 150])
    xticklabels({'0', '-10', '-20', '-30'})
    ax = gca;
    ax.YAxis(1).Color = 'black';
    ax.YAxis(2).Color = 'black';
    legend   
    title("Nominal energy " + name + "; Distance " + dx + " cm") 
    saveas(gcf, strcat(string(energy), "_", string(dx), "_", "PvsDose.png"))
end


















