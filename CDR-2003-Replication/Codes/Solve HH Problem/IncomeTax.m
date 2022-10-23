function tau = IncomeTax(y, cS, paramS)
%% Documentation:
% This function computes income tax.

% INPUT
% y:   HH income (labor income + capital income)

% OUTPUT
% tau: income tax given wage income from labor supply and productivity and
%      capital income from saving 


%% Main
tau = cS.a0 * (y - (paramS.a2 + y.^(-cS.a1)).^(-1/cS.a1)) + y * paramS.a3;


end