function tauEstate = EstateTax(kp, paramS)
%% Documentation:
% This function computes estate tax.

% INPUT
% kp: old HH saving today

% OUTPUT
% tauEstate: estate tax


%% Main
kp(kp <= paramS.zlowerbar) = paramS.zlowerbar;
tauEstate                  = paramS.tauE * (kp - paramS.zlowerbar);


end