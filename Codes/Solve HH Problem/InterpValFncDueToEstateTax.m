function ValueInterp = InterpValFncDueToEstateTax(ValuePrime, kpNetTax, cS)
%% Documentation
%    This function generates interpolated value function. Due to estate
% tax, capital stock at the beginning of next period may not be equal to
% the saving decision made by old HH today. 
%    I compute the corresponding value function for each kpNetTax using
% interpolation.

% INPUTS
% (1). ValuePrime: next period value function defined on k grid, nk*nS matrix
% (2). kpNetTax:   next period capital stock net of estate tax, nk*1 vector

% OUTPUTS
% ValueInterp: value function corresponding to kpNetTax for EACH labor state
%              nk*nS matrix

%******* Notice *******
%   Estate tax only happens when the old HH dies at the end of current period
% and his kid enters into the economy in next period.

%   According to the set up of the transition matrix of labor state,
% row 1 to row J are for the old HHs, column 1 to column J means they are
% still old tomorrow, column J+1 to the last column means they become young
% tomorrow. ValueInterp only covers the case where old HHs become young
% tomorrow.

%   Hence when interpolating, my original value function should be
% ValuePrime(:, J+1:end), which corresponds to the young value function for
% each possible labor state tomorrow.


%% Main
ValueInterp            = zeros(cS.nk, cS.nS);
ValueInterp(:, 1:cS.J) = ValuePrime(:, 1:cS.J);

for i_s = cS.J+1 : cS.nS
    ValueInterp(:, i_s) = interp1(cS.kGridV, ValuePrime(:, i_s), kpNetTax, 'spline');
end


end