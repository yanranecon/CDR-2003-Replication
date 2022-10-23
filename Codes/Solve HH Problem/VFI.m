function [ValueM, kPolM, cPolM, lPolM, kPolIndx] = ...
          VFI(ValueInitial, utilityCornerM, sGridV, strProbM, w, r, cS, paramS)
%% Documentation
%{
1. Function Description:
   This program gets the value function and policy functions using VFI.

2. Inputs:
(1). ValueInitial:   value function obtained using steady state values for
                     c and l, nk*nS matrix
                     It is used as a more accurate initial guess for value
                     function iteration exercise.
(2). utilityCornerM: utility of Young HHs when labor supply takes corner
                     value, i.e. l=0
                     nk*nk*J matrix (k'*k*s)
(3). sGridV:         labor efficiency vector, nS*1 vector
(4). strProbM:       transition matrix, nS*nS matrix


3. Output:
(1). ValueM:    value function, nk*nS matrix
(2). kPolM:     policy function for saving, nk*nS matrix
(3). cPolM:     policy function for consumption, nk*nS matrix
(4). lPolM:     policy function for labor supply, nk*nS matrix
(5). kPolIndx:  the position indicator, nk*nS matrix
%}


%% Preparation
% Create some holders
ValueM     = zeros(cS.nk, cS.nS);
kPolM      = zeros(cS.nk, cS.nS);
cPolM      = zeros(cS.nk, cS.nS);
lPolM      = zeros(cS.nk, cS.nS);
kPolIndx   = zeros(cS.nk, cS.nS);

% Initial guess for value function
ValueGuess = ValueInitial;

% Creat precision threshold for VFI
dif        = Inf;
tol        = 0.00001;
iter       = 0;


%% Main
disp('VFI begins')

while dif > tol

    for i_k = 1 : cS.nk
        
        k = cS.kGridV(i_k);
           
        parfor i_s = 1 : cS.J  % Solve the old first
           
            [kPolM(i_k, i_s), kPolIndx(i_k, i_s), ValueM(i_k, i_s), cPolM(i_k, i_s)] = ...
                kPrimeOptimalGivenks_Old(k, i_s, strProbM, ValueGuess, r, w, cS, paramS);
        
        end     % loop over all labor efficiency points for old (i_s)
    
        
        for i_s = cS.J+1 : 2*cS.J  % Then solve for the young
            % Notice that I solve the young and old separately, because for the
            % old, labor efficiency is always zero. But for the young, labor
            % efficiency is increasing. Then I can exploit the monotonicity of
            % the policy function, that is
            % K_i>=K_j --> K_i'=h(K_i) >= K_j'=h(K_j)
            % Hence, once I find the optimal index j1* for K_1, I don't need
            % consider capital stocks smaller than K_j1* in the search for j2*
            % This shorten's iteration time.

          %******************* Interior Solution ***************
          
            if i_s == cS.J+1
                previous_kp = 1;
            else
                previous_kp = index_maxk_so_far;
            end
           
            s                = sGridV(i_s);
            value_max_so_far = -Inf;
            
            for i_kp = previous_kp : cS.nk
                
                kp   = cS.kGridV(i_kp);
                l    = SolveForLabor(kp, k, s, w, r, cS, paramS);
                c    = ConsumptionFromBC(l, kp, k, s, w, r, cS, paramS);  
                
                if c <= 0 
                    break
                else
                    utility = UtilityGenerator(c, l, cS, paramS);
                    value   = utility + ValueGuess(i_kp,:) * strProbM(i_s,:)' * paramS.beta;                    
                    if value > value_max_so_far
                        lPolM(i_k,i_s)    = l;
                        cPolM(i_k,i_s)    = c;
                        kPolM(i_k,i_s)    = cS.kGridV(i_kp);
                        kPolIndx(i_k,i_s) = i_kp;
                        ValueM(i_k,i_s)   = value;
                        value_max_so_far  = value;
                        index_maxk_so_far = i_kp;
                       
                    end % if condition for value                   
                end     % if condition for c
            
            end         % loop over all values of kprime (i_kp)
            
            
          %***************** Corner Solution ******************
          utilityCorner        = utilityCornerM(:, i_k, i_s-cS.J);
          ValueCorner          = BellmanRHS_Young(utilityCorner, ValueGuess, strProbM(i_s,:), paramS);
          [ValueCornerMax, kpCornerIndx] ...
                               = max(ValueCorner);
          
          
          %******** Compare Corner Solution with Interior Solution ********
          if ValueCornerMax > value_max_so_far
              kPolIndx(i_k,i_s) = kpCornerIndx;
              ValueM(i_k,i_s)   = ValueCornerMax;
              kPolM(i_k,i_s)    = cS.kGridV(kpCornerIndx);
              cPolM(i_k,i_s)    = ConsumptionFromBC(0, cS.kGridV(kpCornerIndx), cS.kGridV(i_k), sGridV(i_s), w, r, cS, paramS);
              lPolM(i_k,i_s)    = 0;
          end
   
        end             % loop over all labor efficiency points for young (i_s)

    end                 % loop over all values of k (i_k)
   
    iter       = iter + 1;
    dif        = norm(ValueM - ValueGuess);
    ValueGuess = ValueM;

    fprintf('VFI dif = %.5f\n',dif); 
    fprintf('VFI iter = %.5f\n',iter); 

end


end        