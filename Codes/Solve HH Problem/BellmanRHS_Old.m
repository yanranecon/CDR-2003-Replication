function Value = BellmanRHS_Old(utility, ValuePrime, strProbV, cS, paramS)
%% Documentation
%   This function computes the value of RHS of Bellman equation of the OLD
% HHs, given utility, value prime, and transition matrix.

% INPUT
% (1). utility:    utility, nk*1 vector
%                  each element corresponds to one kprime on k grid, given
%                  k and s today.
% (2). ValuePrime: next period value function, nk*nS matrix
% (3). strProbV:   transition matrix, 1*nS row vector
%                  given today's labor state, the prob of transiting to
%                  each labor state tomorrow

% OUTPUT
% value: value of the RHS of Bellman equation of old HH


%% Main
tauEstate   = EstateTax(cS.kGridV, paramS);
kpNetTax    = cS.kGridV - tauEstate;
ValueInterp = InterpValFncDueToEstateTax(ValuePrime, kpNetTax, cS);
Value       = utility + ValueInterp * strProbV' * paramS.beta;
    
 
end