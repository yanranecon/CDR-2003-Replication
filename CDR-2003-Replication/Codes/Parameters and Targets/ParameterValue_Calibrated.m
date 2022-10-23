function paramS = ParameterValue_Calibrated(cS)
%% Documentation
%{
1. Function Description
This function sets parameter values for Castaneda et al.(2003) model.
These parameter values will be calibrated later using SMM.
%}


%% Main
% ************************ Household Preference ***************************
paramS.sigma2   = 1.016;             % Curvature of leisure
paramS.beta     = 0.942;             % Discount factor
paramS.chi      = 1.138;             % Parameter controlling disutility from work


% *********************** Efficiency Labor Units **************************
paramS.s2       = 3.15;              
paramS.s3       = 9.78;
paramS.s4       = 1061;                 

paramS.p12      = 0.0114/(1-cS.omegaR);
paramS.p13      = 0.0039/(1-cS.omegaR);
paramS.p14      = 0.0001/(1-cS.omegaR);
paramS.p21      = 0.0307/(1-cS.omegaR);
paramS.p23      = 0.0037/(1-cS.omegaR);
paramS.p24      = 0/(1-cS.omegaR);
paramS.p31      = 0.015/(1-cS.omegaR);
paramS.p32      = 0.0043/(1-cS.omegaR);
paramS.p34      = 0.0002/(1-cS.omegaR);
paramS.p41      = 0.1066/(1-cS.omegaR);
paramS.p42      = 0.0049/(1-cS.omegaR);
paramS.p43      = 0.0611/(1-cS.omegaR);
     
paramS.phi1     = 0.969;             % Earnings life cycle controller
paramS.phi2     = 0.525;             % Intergenerational earnings persistence controller


% **************************** Government *********************************
paramS.a2       = 0.491;             % Income tax function parameters 3 of 4
paramS.a3       = 0.144;             % Income tax function parameters 4 of 4
paramS.zlowerbar= 14.101;            % Estate tax function parameter: tax exempt level
paramS.tauE     = 0.16;              % Estate tax function parameter: marginal tax rate
paramS.T        = 0.696;             % Normalized transfers to retirees
paramS.G        = 0.296;             % Government expenditures


end