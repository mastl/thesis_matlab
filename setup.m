%% State space
    % Time
    spa.T       = 10;       % Number of time periods
    
    % Energy efficiency
    spa.LowEE = 0.1;                    % Baseline value
    spa.HighEE = 0.15;                   % Improved EE
    spa.EE = [spa.LowEE, spa.HighEE];   % Vector of efficiencies

%% Parameters and exogenous variables

    % Utility
    par.Rho     = 2;        % Constant relative risk (CRRA) parameter
    
    % Discount and present bias
    par.DiscountRate = 0.04;                     % Discount rate used by the Danish State the first 35 years of a projects lifetime
    par.Delta   = 1/(1+par.DiscountRate);        % Discount factor
    par.Beta    = 1;                           % Present bias
    
    % Prices
    par.EnergyPrice = 1;            % Relative price of energy
    par.Kappa       = 10;           % Investment cost

    % Exogenous income
    par.Mbar        = 400;          % Household after tax income available for consumption           
    
    % Energy End-use
    IncomeShareEnergy = 0.05;       % Energy income share according to eia
    PensionContributions = 0.11;    % Income going towards pension contributions - i.e. income outside this model
    IncomeShareEnergy = IncomeShareEnergy/(1-PensionContributions); % Readjust energy share to reflect pensions are outside model
    
    par.EnergyEndUse = IncomeShareEnergy*(median(par.Mbar)/par.EnergyPrice)*spa.LowEE; % Guesstimate end-use energy (non-observed variable)

%% Function handles