classdef fct
    methods (Static)
        %% Useful User functions
          function Diff = Diff(Vector)
              % Function is used to calculate the difference between any two
              % points of a vector. Input must thus be a vector of.
              Diff = Vector - [0; Vector(1:(end-1))];     
          end
        %% Utility & Consumption
            % Absolute
                function U = Util(c,par)
                    U = par.EnergyEndUse + (c.^(1-par.Rho)-1)./(1-par.Rho);
                end
            % Marginal
                function dU = dUtil(c,par)
                    dU = c.^(-par.Rho);
                end
            % Inverse
                function Ce = dUtilInv(v, par)
                    Ce = v.^(-1/par.Rho);
                end

            
        %% Calculations
        function Energy = Energy(IndexInEE, par, spa) 
            % Calculates the energy used based on the level of EE (given by
            % IndexInEE
            Energy = par.EnergyEndUse*spa.EE(IndexInEE)^(-1);
        end
        
        function c = Cons(InvestmentChoice, Energy, par, spa)
            % Calculates consumption based on investment choice and energy consumption
            c = par.Mbar-par.EnergyPrice*Energy-par.Kappa*InvestmentChoice;
        end
        
        function ValueFunction = ValueFunction(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa)
            % Calculates the valuefunction. 
            % Level within loops given by t -> IndexInEE ->
            % InvestmentChoice
            % Current consumption given by consumption and lookup matrix
            % given by out (which is the final output matrix)
            ValueFunction   = fct.Util(Consumption,par) + par.Delta* fct.NextValueFunction(t, IndexInEE, InvestmentChoice, out, par, spa); % Value Function without potential present bias
        end
        
        function ValueFunctionPresent = ValueFunctionPresent(t, IndexInEE, InvestmentChoice, Consumption, out, par, spa)
            % Calculates the valuefunction under present bias.
            % Same function as ValueFunction except for par.Beta!
            ValueFunctionPresent   = fct.Util(Consumption,par) + par.Beta*par.Delta* fct.NextValueFunction(t, IndexInEE, InvestmentChoice, out, par, spa); % Value Function without potential present bias
        end
        
        function NextValueFunction = NextValueFunction(t, IndexInEE, InvestmentChoice, out, par, spa)
            % Looks up the valuefunction in the next period given specified EE and investment choice
            if t == spa.T
                NextValueFunction = 0; % Return 0 if current period is the final one (no bequest motive)
            else 
                if IndexInEE == length(spa.EE)                           % If the EE is as high as it can be...
                    NextValueFunction = out.ValueFunction(t+1, IndexInEE);  % ... it is that state that is looked up.
                    print = 'Last IndexInEE'
                else
                    if InvestmentChoice == 1                                % If the investment is made...
                        NextValueFunction = out.ValueFunction(t+1, IndexInEE + 1); % ... EE will improve.
                        print = 'InvestmenChoice == 1'
                    else                                                        % Else ...
                        NextValueFunction = out.ValueFunction(t+1, IndexInEE); % ... it will remain to have the same (low) state as today
                        print = 'InvestmenChoice == 0'
                    end
                end
            end
        end 
        %% Store output
            function Output = StoreOutput(out, TimePeriod, temp)
                % Stores the values at time t
                    out.InvestmentChoice(TimePeriod, :) = temp.InvestmentChoice;          % Store optimal choice
                    out.Energy(TimePeriod, :)           = temp.Energy;                    % Store energy consumption (E in the model)
                    out.Consumption(TimePeriod, :)      = temp.Consumption;               % Store consumption with dimensions T x and length of EE
                    out.ValueFunction(TimePeriod, :)    = temp.ValueFunction;             % Store Value Function  with dimensions T x and length of EE
                    out.ValueFunctionPresent(TimePeriod, :)    = temp.ValueFunctionPresent;             % Store Value Function  with dimensions T x and length of EE
                    out.CompareValues                   = temp.CompareValues;
                    
                    Output = out;
            end

         %% Transition Equations
            % Income
                function m = M_NoSaving(spa)
                    m = spa.Mbar;
                end
    end
end