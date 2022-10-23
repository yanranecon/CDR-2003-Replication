%%%%%%%%%%%%%%%%% Castaneda et al. (2003) Model Replication %%%%%%%%%%%%%%%

%                           Brief Summary
% Model: Heterogeneous agent model of Bewley-Hugget-Aiyagari type
%        Combine the main characteristics of the dynastic and of the
%        life-cycle abstractions (hybrid model with retirement & bequests)
%        (1). HHs are altruistic
%        (2). Stochastic aging
%        (3). Earning process is chosen to match SCF data on income and wealth inequality

% Task: Solve Castaneda et al. (2003) model using VFI


% Author: Yanran Guo
% Date:   3/9/2019


%% Environment Setup
clc;                     % Clear screen
clear;                   % Clear memory
rng default;             % Fix the seed for the random number generator (so as to keep simulations the same)
close all;               % Close open windows
addpath(genpath(pwd));   % Include subfolders of the current folder
parpool;                 % Start parallel


%% Set Parameter Values
cS           = ParameterValue_Fixed;
paramS       = ParameterValue_Calibrated(cS);
[Targets, ~] = CalibrationTargets;

% Some parameters can be recovered without solving the HH problem.
% 'Handy Trick' to avoid need to loop over the calculation of GE during calibration process
cS.delta     = Targets.ItoY / Targets.KtoY;
% Set interest rate to be what must be the eqm value 
[r, w]       = HHPrices(Targets.KtoY, cS);

% Labor efficiency and its transition matrix
[~,~,sGridV,~,~,~,strProbM,~] ...
             = JointAgeEfficiencyProcess(cS,paramS);


%% Solve HH Problem Using VFI Without Calibration
[ValueM, kPolM, cPolM, lPolM, kPolIndx] ...
             = SolveHHProblem(sGridV, strProbM, r, w, cS, paramS);

% Save the results
save ./Output/ValueM.mat ValueM
save ./Output/kPolM.mat kPolM
save ./Output/cPolM.mat cPolM
save ./Output/lPolM.mat lPolM
save ./Output/kPolIndx.mat kPolIndx


