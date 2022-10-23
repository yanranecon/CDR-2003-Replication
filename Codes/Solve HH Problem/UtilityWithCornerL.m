function utility = UtilityWithCornerL(sGridV, w, r, cS, paramS)
%% Documentation
%{
1. Description
   This function generates utilities for YOUNG HHs, given each k', k and s,
when labor supply is 0

2. Inputs
(1). sGridV: vector of labor efficiency, nS*1 vector
             Notice that since I only compute the utilites of Young HHs, I
             only use the last J elements in sGridV. The first J elements
             in sGridV are labor efficiency for OLD HHs
(2). w:      wage, scalar
(3). r:      interest rate, scalar

3. Output
utility:     k'*k*s (nk*nk*J) matrix
             utility given each k', k, and young s, when l=0

%}


%% Main
utility = zeros(cS.nk, cS.nk, cS.J);

for i_k = 1 : cS.nk
    
    for i_s = 1 : cS.J
        
        k = cS.kGridV(i_k);
        s = sGridV(i_s+cS.J);
        cCornerL             = ConsumptionFromBC(0, cS.kGridV, k, s, w, r, cS, paramS);
        cCornerL(cCornerL<0) = 0;
        utility(:, i_k, i_s) = UtilityGenerator(cCornerL, 0, cS, paramS);   % when c<0, utility is -Inf
        
    end
    
end

end