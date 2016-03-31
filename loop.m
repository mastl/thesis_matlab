%% Run loop over the possible states at each time period
for IndexInEE = 1:length(spa.EE)        % Run loop over state space (i.e. the levels of EE)
    %% Evaluate the level of EE
    if IndexInEE == length(spa.EE) % If EE is as high as it can...
        % ... then return values for this absorbing state
        
        InvestmentChoice = 0;
        
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
    
    else % If EE is not as high as it can be...
        %... then figure out what is better: To invest or not invest
        
        %% Run loop over discrete decision
        for x = 1:2 % To invest or not invest 
            InvestmentChoice = x-1; % x=1 => No Investment ; x=2 => invest
            
            % Find values
            Energy = fct.Energy(IndexInEE, par, spa);
            Consumption = fct.Cons(InvestmentChoice, Energy, par, spa);
            ValueFunction = fct.ValueFunction(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa);
            ValueFunctionPresent = fct.ValueFunctionPresent(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa);
            
            % Store values to compare struct 
            compare.Energy(1,x) = Energy;
            compare.Consumption(1,x) = Consumption;
            compare.ValueFunction(1,x) = ValueFunction;
            compare.ValueFunctionPresent(1,x) = ValueFunctionPresent;            
        end
        
        % Compare and return the better choice
        if compare.ValueFunctionPresent(1,1) < compare.ValueFunctionPresent(1,2)
            temp.InvestmentChoice = 1; % If the value function of investing is highest then invest
        else
            temp.InvestmentChoice = 0; % Else don't invest
        end
        Index = temp.InvestmentChoice + 1;
        % If the investment is made take the values corresponding to that
        temp.Energy(1, IndexInEE) = compare.Energy(1, Index);
        temp.Consumption(1, IndexInEE) = compare.Consumption(1, Index);
        temp.ValueFunction(1, IndexInEE) = compare.ValueFunction(1, Index);
        temp.ValueFunctionPresent(1, IndexInEE) = compare.ValueFunctionPresent(1, Index);
        
        temp.CompareValues(t,:)       = compare.ValueFunctionPresent;      % Store compare values
        
    end % If-else statement w.r.t. absorbing state
    % Finally send to output
    out = fct.StoreOutput(out, t, temp); % Send to output
    out.ValueFunction
end % End loop over possible states
