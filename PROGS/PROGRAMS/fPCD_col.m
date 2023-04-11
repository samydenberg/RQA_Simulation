% Record photons detected by PCD with a collimator placed in front of it
% Input: 
%       "pos_s" - Photon position on the scoring sphere (x, y, z, r) in cm
%       "dir" - Photon direction as a unit vector (x, y, z) in cm and photon
%                energy in eV
%       "hexagons" - 3D collimator hexagonal holes
% Output:
%       "posCol" - Detected photon position on the scoring surface
%       "dirCol" - Detected photon direction and energy
%       "posCol_s" - Detected photon position on the PCD sensor area
%
% by Samuel Ydenberg


function [posCol,dirCol,posCol_s] = fPCD_col(pos, dir, pos_s, hexagons)
    init_hex = hexagons{1,1};
    back_track = max(init_hex(3,:));
    front_points = pos_s - dir(:,1:3)*back_track;
    save_ind = [];
    
    for i = 1:size(pos_s,1)
        bpt = pos_s(i,:);
        fpt = front_points(i,:);
        for j = 1:size(hexagons,2)
            cur_hex = hexagons{1,j};
            front_hex = [cur_hex(1:2,1),cur_hex(1:2,2),cur_hex(1:2,7),cur_hex(1:2,12),cur_hex(1:2,17),cur_hex(1:2,22)];
            hex_x = front_hex(1,:);
            hex_y = front_hex(2,:);
            [fin,fon] = inpolygon(fpt(2),fpt(3),hex_x,hex_y);
            [bin,bon] = inpolygon(bpt(2),bpt(3),hex_x,hex_y);
            if (fin ~= 0 && bin ~= 0) || (fin ~= 0 && bon ~= 0) || (fon ~= 0 && bin ~= 0) || (fon ~= 0 && bon ~= 0)
                save_ind = [save_ind,i];
            end
        end
    end
posCol = pos(save_ind,:);
dirCol = dir(save_ind,:);
posCol_s = pos_s(save_ind,:);
end