% Clear command window and workspace
clc
clear
%% Run setup
setup
%% Specify parameters to be evaluated and initialize output matrices
Kappa = [10 15 20 25 30];
experiment_iterations = length(Kappa);
% Output matrices
investment_decision = zeros(spa.T, experiment_iterations);
    %% Run the experiment
    for experiment_run = 1:experiment_iterations
        par.Kappa = Kappa(experiment_run);
        run;
%         investment_decision(:, experiment_run) = out.InvestmentChoice;
    end
    %% Print
    investment_decision
% end