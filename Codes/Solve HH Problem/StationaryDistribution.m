function mu = StationaryDistribution(kPolIndx, strProbM, cS)
%% Documentation
%{
1. Function Description
   Given prices and the policy function k'=g(k,s), this program find the associated
stationary distribution mu(k,s) by iterating until finding a fixed point of
the following operator 
          mu(k',s')=sum_k sum_s 1{k'=g(k,s)} prob(s'|s) mu(k,s)

    The idea is that taking the decision rules from the value function
iteration step and a guess at the distribution as given, we can map current
states into future states, and then repeat this mapping as necessary until
convergence.

2. Input
(1). kPolM:    policy function for kprime, nk*nS matrix
(2). strProbM: transition probability (nS*nS matrix)

3. Output
mu: stationary distribution of k and s
%}


%% Preparation
nS       = 2 * cS.J;

% Get the stationary probabilities of the transition matrix
SSprob = strProbM;
for i = 1 : 1000
    SSprob = SSprob * strProbM;
end


%% Main
%                               Step-1.
% Make an initial guess at the stationary distribution. 
mu0 = zeros(cS.nk, nS);
for i = 1 : nS
    mu0(:,i) = SSprob(1,i)/cS.nk;
end

%--------------------------------------------------------------------------
%{
                               Step-2. 
Given my initial guess, compute mu1(k,s)=Tmu0(k,s) for all (k,s) on the grid.
Given the decision rule, and setting mu1(k,s)=0 at the start of each new
iteration before looping through all k,s,s', we can compute mu1 by
accumulation. That is for each triple (k,s,s')
         mu1(g(k,s),s') = mu1(g(k,s),s') + mu0(k,s)*Prob(s,s')

Notice that, due to estate taxation, k' may not be the exact value of
g(k,s). Hence, we need an "if-loop" to take care of this case
%--------------------------------------------------------------------------

                              Step-3.
Compute the sup-norm metric: sup_(k,s) |mu1(k,s)-mu0(k,s)|
If the convergence metric is within tolerance, exit the loop and set mu1=mu.
Otherwise, set mu0=mu1 and repeat steps 2 and 3.
%}
tol        = 10^(-7);
dif        = tol + 1;
itermu     = 0;

while dif > tol 
    mu1 = zeros(cS.nk,nS);
    for i = 1 : cS.nk             % Capital
        for j = 1 : nS            % Current labor productivity shock
            for jprime = 1 : nS   % Next period labor productivity shock
 
                    mu1(kPolIndx(i,j),jprime) = mu1(kPolIndx(i,j),jprime) + strProbM(j,jprime)*mu0(i,j);
                
            end  % for jprime
        end      % for j
    end          % for i
    
    dif    = norm(mu0-mu1);
    mu0    = mu1;
    itermu = itermu+1;
    
end % while loop

formatSpec = '(Stationary Distribution Iteration) current diff: %2.4f ,Iter %i \n';
fprintf(formatSpec,dif,itermu)

mu = mu1;


end