function ValueInitial = InitialGuessForVFnc(cS, paramS)
%% Documentation:
% This function generate initial guess for value function that will be used
% in VFI.

% I use the steady state value of c and l for YOUNG and OLD HHs to generate 
% initial guess.

% Steady state value for YOUNG and OLD consumption is calculated by myself 
% separately using the policy function for c, togehter with the stationary 
% distribution mu, which I obtained using VFI in [New Code_5]


%% Main
cOld_ss        = 1.3052;
cYoung_ss      = 2.6150;
lYoung_ss      = cS.elle/3;
VYoung_ss      = UtilityGenerator(cYoung_ss, lYoung_ss, cS, paramS);
VOld_ss        = UtilityGenerator(cOld_ss, lYoung_ss, cS, paramS);

ValueInitial   = [ones(cS.nk, cS.J)*VOld_ss, ones(cS.nk, cS.J)*VYoung_ss];


end