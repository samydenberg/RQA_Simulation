% Compute longitudinal photon counts
% Input: 
%       "pos" - Photon position on the scoring surface     
% Output:
%       "counts" - Longitudinal photon counts with a 3 cm step
%
% by Tatiana Kashtanova


function counts = fPcount(pos_s)
    counts = zeros(10,1);
    k = 0;
    for h = 1:10
        ct = nnz(pos_s(:,3)<=0-k & pos_s(:,3)>-3-k);
        counts(h) = ct;
        k = k+3;
    end
    
end















