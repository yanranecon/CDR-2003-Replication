function [ValueM, kPolM, cPolM, lPolM, kPolIndx] = SolveHHProblem(sGridV, strProbM, r, w, cS, paramS)
%% Documentation
%{
1. Function Description
   This function performs value function iteration to solve HH problem. 

2. Input
(1). sGridV:   labor efficiency vector, nS*1 vector
(2). strProbM: transition matrix, nS*nS matrix

3. Output
(1). ValueM:value function, nk*nS matrix
(2). kPolM: policy function for saving, nk*nS matrix
(3). cPolM: policy function for consumption, nk*nS matrix
(4). lPolM: policy function for labor supply, nk*nS matrix
(5). kPolIndx: ordinal numbers showing the position of optimal saving
               decision in k grid, nk*nS matrix
%}


%% Preparation
% Initial guess for value function
try 
    load ./Output/ValueM.mat
    ValueInitial   = ValueM;
catch
    ValueInitial   = InitialGuessForVFnc(cS, paramS);
end

utilityCornerM     = UtilityWithCornerL(sGridV, w, r, cS, paramS);


%% Main
[ValueM, kPolM, cPolM, lPolM, kPolIndx] ...
                   = VFI(ValueInitial, utilityCornerM, sGridV, strProbM, w, r, cS, paramS);


end