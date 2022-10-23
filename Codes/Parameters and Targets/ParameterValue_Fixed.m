function cS = ParameterValue_Fixed
%% Documentation
%{
1. Function Description
This function sets parameter values for Castaneda et al.(2003) model.
These parameter values are pre-determined without calibration. Hence they
stay fixed.
%}


%% Main
% ************************ Household Preference ***************************
cS.elle    = 3.2;               % Endowment of productive disposable time
cS.sigma1  = 1.5;               % Curvature of consumption

% *********************** Efficiency Labor Units **************************
cS.omegaR  = 0.022;             % The probability of being retired
cS.omegaD  = 0.066;             % The probability of dying
cS.J       = 4;                 % Number of realizations of productivity in working-age
cS.nS      = cS.J*2;            % Number of realizations of productivity over lifetime
cS.s1      = 1;                 % The endowment of productivity of the least productive HHs is normalized to be one

% ************************* Firm Production *******************************
cS.theta   = 0.376;             % Capital share in production function

% **************************** Government *********************************
cS.a0      = 0.258;              % Income tax function parameters 1 of 4
cS.a1      = 0.768;              % Income tax function parameters 2 of 4

% ****************************** Grids ************************************
% (1). Capital Grid
% Two states in Castaneda et al. economy, labor productivity (s) and saving (k)
% Given the parameterization for s, it is already discrete.
% However, k is still on the real line. 
% Need to approximate k's support with a discrete grid, starting from 0
% and going up to a large number
cS.kGridV  = [0:0.02:1, 1.05:0.05:2, 2.1:0.1:10, 10.5:0.5:100, 104:4:1500]';  
cS.nk      = length(cS.kGridV);             % Number of grids I set

% Note that capital grid is very unequally spaced. The distance b/w the
% grid points is very small near the origin, and it increases rapidly as we
% move toward the upper bound of the set of asset holdings. The reasons are
% that the curvature of the decision rules decreases very rapidly in wealth
% and the range of asset holdings needed to achieve the observed wealth
% concentration is fairly large: it is the interval (0,1500)


%% Simulation
cS.nSim    = 1000000;
cS.tSim    = 1000;


end