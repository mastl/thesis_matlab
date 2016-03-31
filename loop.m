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
        for InvestmentChoice = 0:1 % To invest or not invest
            
            % Find values
            Energy = fct.Energy(IndexInEE, par, spa);
            Consumption = fct.Cons(InvestmentChoice, Energy, par, spa);
            ValueFunction = fct.ValueFunction(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa);
            ValueFunctionPresent = fct.ValueFunctionPresent(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa);
            
            % Store values to compare struct
            index = InvestmentChoice + 1;
            compare.Energy(1,index) = Energy;
            compare.Consumption(1,index) = Consumption;
            compare.ValueFunction(1,index) = ValueFunction;
            compare.ValueFunctionPresent(1,index) = ValueFunctionPresent;            
        end
        
        % Compare and return the better choice
        if compare.ValueFunctionPresent(1,1) < compare.ValueFunctionPresent(1,2)
            InvestmentChoice = 1; % If the value function of investing is highest then invest
            
            % Overwrite investment choice matrix with the investment choice
            out.InvestmentChoice(t, IndexInEE) = InvestmentChoice; 
        else
            InvestmentChoice = 0; % Else don't invest
        end
        
        % If the investment is made take the values corresponding to that
        Index = InvestmentChoice + 1;
        temp.Energy(1, IndexInEE) = compare.Energy(1, Index);
        temp.Consumption(1, IndexInEE) = compare.Consumption(1, Index);
        temp.ValueFunction(1, IndexInEE) = compare.ValueFunction(1, Index);
        temp.ValueFunctionPresent(1, IndexInEE) = compare.ValueFunctionPresent(1, Index);
        
        temp.CompareValues(t,:)       = compare.ValueFunctionPresent;      % Store compare values
        
    end % If-else statement w.r.t. absorbing state
end % End loop over possible states

% Send to output
out = fct.StoreOutput(out, t, temp); % Send to output
