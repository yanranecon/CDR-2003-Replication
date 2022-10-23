function util = UtilityGenerator(c, h, cS, paramS)
%% Documentation
% This function computes eparable power utility function

%{
INPUTS:
(1). c:     Consumption
(2). h:     Working hours


OUTPUTS:
util: Utility
%}


%% Compute the Utility

util = (c.^ (1-cS.sigma1)) / (1-cS.sigma1) + paramS.chi * ((cS.elle - h).^ (1-paramS.sigma2)) / (1-paramS.sigma2);  

end