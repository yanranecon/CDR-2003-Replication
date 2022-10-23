function value = BellmanRHS_Young(utility, ValuePrime, strProbV, paramS)
%% Documentation
%   This function computes the value of RHS of Bellman equation of the YOUNG
% HHs, given utility, value prime, and transition matrix.

% INPUT
% (1). utility:    utility, nk*1 vector
% (2). ValuePrime: next period value function, nk*nS matrix
% (3). strProbV:   transition matrix, 1*nS row vector
%                  given today's labor state, the prob of transiting to
%                  each labor state tomorrow

% OUTPUT
% value: value of the RHS of Bellman equation of young HH


%% Main

value       = utility + ValuePrime * strProbV' * paramS.beta;

end