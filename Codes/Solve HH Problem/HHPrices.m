function [r, w] = HHPrices(KY, cS)
%% Documentation:
% This function is defined based on production function

% INPUTS
% (1). KY:         aggregate capital-output ratio in the economy
% (2). cS.theta:   capital share
% (3). cS.delta:   depreciation rate

% OUTPUTS
% (1). R: capital rental price faced by households
%         R = MPK - depreciation
% (2). w: wage after tax
%         w = MPL


%% Main
% Production
MPK = cS.theta * (1/KY);

% Prices faced by households
r   = MPK - cS.delta;
w   = (1-cS.theta)*(((r+cS.delta)/(cS.theta))^(cS.theta/(cS.theta-1)));


end