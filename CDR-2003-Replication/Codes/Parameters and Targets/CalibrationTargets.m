function [Targets, CalibTargets] = CalibrationTargets
%% Documentation
% This file defines calibration targets in Castaneda et al. (2003)
% There are 26 parameters, 27 targets

%% Main

%********************* 1. Macroeconomic Aggregates ************************
Targets.ItoY    = 0.186;   % Investment to output ratio
Targets.KtoY    = 3.13;    % Capital to output ratio
Targets.GtoY    = 0.202;   % Government expenditure to output ratio
Targets.TrtoY   = 0.049;   % Government transfer to output ratio
Targets.GovBC   = 0;       % Government balances its BC

CalibTargets(1) = Targets.KtoY;
CalibTargets(2) = Targets.GtoY;
CalibTargets(3) = Targets.TrtoY;
CalibTargets(4) = Targets.GovBC;


%**************** 2. Allocation of Time and Consumption *******************
Targets.LtoH      = 0.3;    % Share of disposable time allocated to market
Targets.CVctoCVl  = 3.0;    % Ratio of coeff of var for consumption to coeff of var for hours worked

CalibTargets(5)   = Targets.LtoH;
CalibTargets(6)   = Targets.CVctoCVl;


%******************** 3. Life-Cycle Profile of Earnings *******************
% EarningOtoY: average earnings for HHs btw age 41-60 / that of HHs btw ages of 21-40
Targets.EarningOtoY = 1.303;  
CalibTargets(7)     = Targets.EarningOtoY;


%******** 4. The Intergenerational Transmission of Earnings Ability *******
Targets.IncomeCorr = 0.4;  % Cross sectional corr of income btw fathers and sons
CalibTargets(8)    = Targets.IncomeCorr;


%************************** 5. Estate Taxation ****************************
Targets.zlowerbarMinus10timesAveIncome = 0;
Targets.tauEtoY    = 0.002; % Estate tax revenue as fraction of output

CalibTargets(9)    = Targets.zlowerbarMinus10timesAveIncome;
CalibTargets(10)   = Targets.tauEtoY;


%************************** 6. Income Taxation ****************************
% Effective tax rate on average HH income
% This number comes from gov BC
Targets.TautoY   = Targets.GtoY + Targets.TrtoY - Targets.tauEtoY;                                         
CalibTargets(11) = Targets.TautoY;


%*************** 7. The Distributions of Earnings and Wealth **************
Targets.EarningsGini                = 0.63;
Targets.WealthGini                  = 0.78;
Targets.EarningsQuintileShares1and2 = 0.0279*100;
Targets.EarningsQuintileShares3     = 0.1249*100;
Targets.EarningsQuintileShares4     = 0.2333*100;
Targets.EarningsQuintileShares5     = 0.6139*100;
Targets.WealthQuintileShares1and2   = 0.0135*100;
Targets.WealthQuintileShares3       = 0.0572*100;
Targets.WealthQuintileShares4       = 0.1343*100;
Targets.WealthQuintileShares5       = 0.7949*100;
Targets.EarningsTopShares9095       = 0.1238*100;
Targets.EarningsTopShares9599       = 0.1637*100;
Targets.EarningsTopShares100        = 0.1476*100;
Targets.WealthTopShares9095         = 0.1262*100;
Targets.WealthTopShares9599         = 0.2395*100;
Targets.WealthTopShares100          = 0.2955*100;

CalibTargets(12) = Targets.EarningsGini;                
CalibTargets(13) = Targets.WealthGini;                 
CalibTargets(14) = Targets.EarningsQuintileShares1and2; 
CalibTargets(15) = Targets.EarningsQuintileShares3;     
CalibTargets(16) = Targets.EarningsQuintileShares4;     
CalibTargets(17) = Targets.EarningsQuintileShares5;    
CalibTargets(18) = Targets.WealthQuintileShares1and2;   
CalibTargets(19) = Targets.WealthQuintileShares3;      
CalibTargets(20) = Targets.WealthQuintileShares4;       
CalibTargets(21) = Targets.WealthQuintileShares5;      
CalibTargets(22) = Targets.EarningsTopShares9095;       
CalibTargets(23) = Targets.EarningsTopShares9599;      
CalibTargets(24) = Targets.EarningsTopShares100;       
CalibTargets(25) = Targets.WealthTopShares9095;         
CalibTargets(26) = Targets.WealthTopShares9599;        
CalibTargets(27) = Targets.WealthTopShares100;         


end