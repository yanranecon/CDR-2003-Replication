function [s,R,S,P_ss,gamma,P_Rs,P_S,gammafull] = JointAgeEfficiencyProcess(Params,Tgt)
%% Documentation
%{
1. Function Description:
This program gets the joint age and endowment of efficiency labor units
process

The joint age and endowment of efficiency labor units process takes values
in set S={s & R}, where s and R are two J-dimensional sets.
s: set of J realizations of efficiency labor units for working-age HHs
R: set of J realizations of efficiency labor units for retired HHs 
  (due to assumption, it's 0 for all retired HHs)

The model assumptions about the nature of the joint age and endowment
process impose some additional structure on the transition probability
matrix P_S, which can be divided into 4 partitions
            P_S = [Gamma_ss, Gamma_sR; Gamma_Rs, Gamma_RR]

Gamma_ss: describe the changes in the endownments of efficiency labor units 
          of working-age HHs that are still of working age one period later
Gamma_sR: describe the transitions from the working-age states into the
          retirement states
          We use only the last working-age shock to keep track of the
          earnings ability of retired HHs, and we assume every working-age
          HH faces the same probability of retiring. Hence
                        Gamma_sR = omegaR * I
          where omegaR is the prob. of retiring, I is J*J identity matrix
Gamma_Rs: describe the transitions from the retirement states into the
          working-age states that take place when a retired HH dies and is
          replaced by its working-age descendant
Gamma_RR: describe the changes in the retirement states of retired HHs that
          are still retired on period later.
          The type of retired HHs never changes, and we assume every
          retired HH faces the same probability of dying. Hence
                        Gamma_RR = (1-omegaD) * I
          where omegaD is the prob. of dying, I is J*J identity matrix


2. Inputs:
(1). Params.J                    % Number of realizations of productivity
(2). Params.s1, Tgt.s2, Tgt.s3, Tgt.s4
(3). Params.omegaR               % The probability of being retired
(4). Params.omegaD               % The probability of dying
(5). Tgt.p12, Tgt.p13, Tgt.p14, 
     Tgt.p21, Tgt.p23, Tgt.p24, 
     Tgt.p31, Tgt.p32, Tgt.p34, 
     Tgt.p41, Tgt.p42, Tgt.p43
(6). Tgt.phi1                    % Intergenerational persistence of earning
(7). Tgt.phi2                    % Life-cycle profile of earnings


3. Output:
(1). s: efficiency labor units for working-age HHs, J*1 vector
(2). R: efficiency labor units for retired HHs, J*1 vector
(3). S: joint age and endowment of efficiency labor units process, 2J*1 vector
(4). P_ss: transition matrix of s, i.e. Pr(s'|s)
(5). gamma: stationary distribution of s
(6). P_Rs: transition matrix from R to s, i.e. Pr(s'|R)
           To get P_Rs, we need the stationary distribution of s, gamma.
           And P_Rs evaluates the roles played by the life cycle profile
           of earnings (modeled using parameter phi1), and by the
           intergenerational transmission of earnings ability (modeled using 
           parameter phi2)
(7). P_S: transition matrix of S
          P_S = [Gamma_ss, Gamma_sR; Gamma_Rs, Gamma_RR], where
          Gamma_ss = P_ss * (1-omegaR)
          Gamma_sR = omegaR
          Gamma_Rs = P_Rs * omegaD
          Gamma_RR = 1 - omegaD
%}


%% Productivity Realizations 
% Working-age, s
s       = [Params.s1; Tgt.s2; Tgt.s3; Tgt.s4;];

% Retired, R
R       = zeros(Params.J,1); % Productivity states holder: retirement J

% Entire life, S
S       = [R;s];


%% Transition Matrix P_ss, and Stationary Distribution gamma
P_ss    = [1-Tgt.p12-Tgt.p13-Tgt.p14, Tgt.p12, Tgt.p13, Tgt.p14;
           Tgt.p21, 1-Tgt.p21-Tgt.p23-Tgt.p24, Tgt.p23, Tgt.p24;
           Tgt.p31, Tgt.p32, 1-Tgt.p31-Tgt.p32-Tgt.p34, Tgt.p34;
           Tgt.p41, Tgt.p42, Tgt.p43, 1-Tgt.p41-Tgt.p42-Tgt.p43];

gamma = P_ss;
for i = 1 : 1000
    gamma = gamma * P_ss;
end
gamma = gamma(1,:)';


%% Transition Matrix P_Rs
% Step-1.
P_Rs         = [gamma(1)+Tgt.phi1*gamma(2)+(Tgt.phi1^2)*gamma(3)+(Tgt.phi1^3)*gamma(4), ...
               (1-Tgt.phi1)*(gamma(2)+Tgt.phi1*gamma(3)+(Tgt.phi1^2)*gamma(4)), ...
               (1-Tgt.phi1)*(gamma(3)+Tgt.phi1*gamma(4)), ...
               (1-Tgt.phi1)*gamma(4); ...          
               (1-Tgt.phi1)*gamma(1), ...
               Tgt.phi1*gamma(1)+gamma(2)+Tgt.phi1*gamma(3)+(Tgt.phi1^2)*gamma(4), ...
               (1-Tgt.phi1)*(gamma(3)+Tgt.phi1*gamma(4)), ...
               (1-Tgt.phi1)*gamma(4); ...            
               (1-Tgt.phi1)*gamma(1), ...
               (1-Tgt.phi1)*(Tgt.phi1*gamma(1)+gamma(2)), ...
               (Tgt.phi1^2)*gamma(1)+Tgt.phi1*gamma(2)+gamma(3)+Tgt.phi1*gamma(4), ...
               (1-Tgt.phi1)*gamma(4); ...            
               (1-Tgt.phi1)*gamma(1), ...
               (1-Tgt.phi1)*(Tgt.phi1*gamma(1)+gamma(2)), ...
               (1-Tgt.phi1)*((Tgt.phi1^2)*gamma(1)+Tgt.phi1*gamma(2)+gamma(3)), ...
               (Tgt.phi1^3)*gamma(1)+(Tgt.phi1^2)*gamma(2)+Tgt.phi1*gamma(3)+gamma(4)];

% Step-2.
for i=1:4
   P_Rs(i,1) = P_Rs(i,1)+Tgt.phi2*P_Rs(i,2)+(Tgt.phi2^2)*P_Rs(i,3)+(Tgt.phi2^3)*P_Rs(i,4);
   P_Rs(i,2) = (1-Tgt.phi2)*(P_Rs(i,2)+Tgt.phi2*P_Rs(i,3)+(Tgt.phi2^2)*P_Rs(i,4));
   P_Rs(i,3) = (1-Tgt.phi2)*(P_Rs(i,3)+Tgt.phi2*P_Rs(i,4));
   P_Rs(i,4) = (1-Tgt.phi2)*P_Rs(i,4);
end


%% Transition Matrix P_S and Stationary Distribution gammafull
P_S = [(1-Params.omegaD)*eye(Params.J), P_Rs*Params.omegaD; ...
       Params.omegaR*eye(Params.J), P_ss*(1-Params.omegaR)];
   
gammafull = P_S;
for i = 1 : 5000
    gammafull = gammafull * P_S;
end
gammafull = gammafull(1,:)';



%% Output Validation
% Since P_S is the transition matrix
% 1. All elements in P_S should be positive
   if any(P_S(:) < 0)
      error('Wrong transition matrix of S');
   end
   
% 2. The sum of each row in P_S should be 1
   for i = 1:length(P_S)
   if sum(P_S(i,:)) > 1.001 || sum(P_S(i,:)) < 0.999
      error('Sum of each row of transition matrix P_S should be 1');
   end
   end
   
% 3. P_S should be a squared matrix
   if size(P_S,1)~=size(P_S,2)
      error('Transition matrix P_Sshould be a squared matrix');
   end


end