function [ multiple_reg_mdl, CI, adj_r, mean_num_bikers, mean_peak, ...
    mean_low ] = InitialRegression( data )

% isolate predictors and response 
predictors = data(:, 1:11);
response = data(:, 14);

% Perform Regression, isolate confidence intervals and adjusted R Squared
multiple_reg_mdl = fitlm(predictors, response);
CI = coefCI(multiple_reg_mdl);
adj_r = multiple_reg_mdl.Rsquared.adjusted;

winter = [4 0 12 1 1 0 1 0.3415 0.32 0.63 0.1179];
spring = [1 0 3 0 3 1 1 0.3415 0.34 0.71 0.1343];
summer = [2 0 6 0 5 1 1 0.4634 0.44 0.76 0.1075];
autumn = [3 0 9 0 0 1 1 0.5122 0.46 0.74 0.1060];
peak_day = [2 1 6 1 6 0 1 0.5827 0.4778 0.5 0.0299];
low_demand = [4 1 12 0 2 1 4 0.2439 0.2 0.8 0.1493];

% Predict average number of bikers 
[mean_num_bikers, mean_peak, mean_low] = NumRiders(winter, spring, ...
    summer, autumn, peak_day, low_demand, multiple_reg_mdl);

predicted_data = predict(multiple_reg_mdl, predictors);
residuals = response - predicted_data;

% Plotting all predictors against residuals
for i = 1:11
    figure();
    title(strcat('Original Regression: Plotting Residuals with Predictor__',...
        int2str(i)));
    hold on;
    plot(predictors(:,i), residuals, '.k', 'MarkerSize', 15);
end

disp('Initial Regression Finished')

end

