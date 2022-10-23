function y = HHIncome(l, k, s, w, r, paramS)
%% Documentation:
% This function computes total income of a HH.

% INPUTS
% (1). l:          labor supply
% (2). k:          current capital stock
% (3). s:          labor efficiency
% (4). w and r:    wage and interest rate

% OUTPUTS
% y:  total income which contains two parts -- wage income from labor 
%     supply and productivity, and capital income from saving


%% Main
y = r*k + w*l*s + paramS.T*(s==0);


end