function l = SolveForLabor(kprime, k, s, w, r, cS, paramS)
%% Documentation:
% This function combines static FOC and BC to substitube out c to get a
% function of labor supply l
% And then solves for l using Newton's Method

% INPUTS
% (1). kprime:     saving decision
% (2). k:          current capital stock
% (3). s:          labor efficiency
% (4). w and r:    wage and interest rate

% OUTPUTS
% l solved from an equation obtained from combining FOC and BC


%% Main
l     = cS.elle/3;
go_on = 1;

while (go_on==1)

    % Combine FOC and BC together to substitute out c
    fval     =  paramS.chi^(-1/cS.sigma1) * (cS.elle-l)^(paramS.sigma2/cS.sigma1) * ...
                ((1-cS.a0-paramS.a3)*w*s + cS.a0*w*s* (r*k+w*s*l)^(-cS.a1-1) * ...
                ((r*k+w*s*l)^(-cS.a1)+paramS.a2)^(-1-1/cS.a1))^(1/cS.sigma1) + ... 
                kprime - k - (1-cS.a0-paramS.a3)*(r*k+w*s*l) - ...
                cS.a0 * ((r*k+w*s*l)^(-cS.a1) + paramS.a2)^(-1/cS.a1);
       
    % Jacobian
    fjac     =  (-paramS.sigma2/cS.sigma1) * paramS.chi^(-1/cS.sigma1) * ...
                (cS.elle-l)^(paramS.sigma2/cS.sigma1 - 1) * ...
                ((1-cS.a0-paramS.a3)*w*s + cS.a0*w*s* (r*k+w*s*l)^(-cS.a1-1) * ...
                ((r*k+w*s*l)^(-cS.a1)+paramS.a2)^(-1-1/cS.a1))^(1/cS.sigma1) + ...
                paramS.chi^(-1/cS.sigma1) * (cS.elle-l)^(paramS.sigma2/cS.sigma1) * ...
                (1/cS.sigma1) * ((1-cS.a0-paramS.a3)*w*s + cS.a0*w*s* (r*k+w*s*l)^(-cS.a1-1) * ...
                ((r*k+w*s*l)^(-cS.a1)+paramS.a2)^(-1-1/cS.a1))^(1/cS.sigma1 - 1) * ...
                (cS.a0*w*s*(-cS.a1-1)*w*s* (r*k+w*s*l)^(-cS.a1-2) * ...
                ((r*k+w*s*l)^(-cS.a1)+paramS.a2)^(-1-1/cS.a1) + ...
                cS.a0*w*s*(cS.a1+1)*w*s* (r*k+w*s*l)^(-2*cS.a1-2) * ...
                ((r*k+w*s*l)^(-cS.a1)+paramS.a2)^(-2-1/cS.a1)) - ...
                (1-cS.a0-paramS.a3)*w*s - ...
                cS.a0*w*s * (r*k+w*s*l)^(-cS.a1-1) * ...
                ((r*k+w*s*l)^(-cS.a1)+paramS.a2)^(-1-1/cS.a1);
        
    % Newton's Method
    lp = l - (fval/fjac);

    if(abs(lp-l)<0.0000001 || lp>0.99*cS.elle || lp<0.00001*cS.elle)
        go_on = 0;
    end
    
    l = lp;
    
end % while loop

l = min(0.99*cS.elle, l);
l = max(0.00001*cS.elle, l);

end