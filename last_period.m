%% Last period
t=spa.T;
%% Find Values
    InvestmentChoice = 0;           % Optimal to not reinvest in last period (no bequest motive)
    
    % Run loop over the possible states at each time period
    for IndexInEE = 1:length(spa.EE)        % Run loop over state space (i.e. the levels of EE)
        IndexInEE = IndexInEE;
        
        % Find values
        Energy = fct.Energy(IndexInEE, par, spa);
        Consumption = fct.Cons(InvestmentChoice, Energy, par, spa);
        ValueFunction = fct.ValueFunction(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa);
        ValueFunctionPresent = fct.ValueFunctionPresent(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa);
        
        % Store to temporary struct
        temp.Energy(1,IndexInEE) = Energy;
        temp.Consumption(1,IndexInEE) = Consumption;
        temp.ValueFunction(1,IndexInEE) = ValueFunction;
        temp.ValueFunctionPresent(1,IndexInEE) = ValueFunctionPresent;
    end
    
    temp.InvestmentChoice = InvestmentChoice;
    
    % Store values for output
    out = fct.StoreOutput(out, t, temp);