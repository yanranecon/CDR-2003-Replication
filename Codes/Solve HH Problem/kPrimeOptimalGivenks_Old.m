function [kprime, kprimeIndx, value_max, c] = kPrimeOptimalGivenks_Old(k, i_s, strProbM, ValuePrime, r, w, cS, paramS)
%% Documentation
%    This function finds the optimal kprime that maximize the value function 
% of old HHs given state variables k and s.


% INPUTS
% (1). k:          today's capital stock, scalar
% (2). i_s:        ordinal number indicating the position of labor
%                  efficiency on s grid, scalar
% (3). strProbM:   transition matrix, nS*nS matrix
% (4). ValuePrime: value function on the RHS of Bellman equation, nk*nS matrix

% OUTPUTS
% (1). kprime:     optimal saving decision that maximizes Bellman equation, scalar
% (2). kprimeIndx: ordinal number indicating the position of kprime on k grid, scalar
% (3). value_max:  maximized value of Bellman equation, scalar
% (4). c:          optimal consumption, scalar


%% Main
cVec          = ConsumptionFromBC(0, cS.kGridV, k, 0, w, r, cS, paramS);
cVec(cVec<0)  = 0;
utilityVec    = UtilityGenerator(cVec, 0, cS, paramS);   % when c<0, utility is -Inf
Value         = BellmanRHS_Old(utilityVec, ValuePrime, strProbM(i_s,:), cS, paramS);

% Find the results
[value_max, kprimeIndx] = max(Value);
kprime                  = cS.kGridV(kprimeIndx);
c                       = cVec(kprimeIndx);


end