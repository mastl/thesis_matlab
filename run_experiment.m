% Clear command window and workspace
clc
clear
%% Run setup
setup
%% Specify parameter experiment
par.Kappa = [10 15 20 25 30];
v = length(par.Kappa);
% for ex=1:v
    %% Run the loop over time
    run
    %% Print
    Figure1_consumption
% end