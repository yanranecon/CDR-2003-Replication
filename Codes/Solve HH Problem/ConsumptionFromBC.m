function c = ConsumptionFromBC(l, kprime, k, s, w, r, cS, paramS)
%% Documentation:
% This function computes consumption using budget constraint.
% BC:  kprime + c = y - tau(y) + k

% INPUTS
% (1). l:          labor supply
% (2). kprime:     saving decision
% (3). k:          current capital stock
% (4). s:          labor efficiency
% (5). w and r:    wage and interest rate

% OUTPUTS
% Consumption


%% Main
y   = HHIncome(l, k, s, w, r, paramS);
tau = IncomeTax(y, cS, paramS);
c   = -kprime + k + y - tau;


end