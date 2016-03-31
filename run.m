%% Initialize matrices for storing data
    % Final output matrices
        z1 = zeros(spa.T,1);
        z2 = zeros(spa.T,length(spa.EE));
        z3 = zeros(spa.T,2);

        out.InvestmentChoice    = z2;      % Store optimal choice
        out.Energy              = z2;      % Store energy consumption (E in the model)
        out.Consumption         = z2;      % Store consumption with dimensions T x and length of EE
        out.ValueFunction       = z2;      % Store Value Function  with dimensions T x and length of EE
        out.ValueFunctionPresent = z2;     % Store Value Function  with dimensions T x and length of EE for when agents are present biased
        out.CompareValues       = z3;      % Store compare values
    
    % Temporary matrices for evaluating between the low and high EE states
        z1 = zeros(1,1);
        z2 = zeros(1,length(spa.EE));
        
        temp.Energy              = z2;      % Store energy consumption (E in the model)
        temp.Consumption         = z2;      % Store consumption with two rows
        temp.ValueFunction       = z2;      % Store Value Function  with two rows
        temp.ValueFunctionPresent = z2;     % Store Value Function  with dimensions T x and length of EE for when agents are present biased
        temp.CompareValues       = z3;      % Store compare values
        
    % Compare matrixes for evaluating between investing or not
        z1 = zeros(1,2);
        compare.Energy          = z1;
        compare.Consumption     = z1;
        compare.ValueFunction   = z1;
        compare.ValueFunctionPresent   = z1;
    
    % Create varible for figure numbers
    FigureNumber = 1;

%% Specify last period
    last_period % Specifies last period consumption and value function
%% Run the loop over time
for t=spa.T-1:-1:1
    loop
end
%% PRINT
% out.x
% sum(out.x(:)==0)