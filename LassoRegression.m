function [ betas, multiple_reg_mdl, CI, adj_r, mean_num_bikers, mean_peak, ...
    mean_low ] = LassoRegression( data )

% isolate predictors and response 
predictors = data(:, 1:11);
response = data(:, 14);

% Running lasso regression on original predictor set and response
betas = lasso(predictors, response);

% Exclude columns 3, 4, 5, 8, 10, create new regression, compute confidence
% intervals and adjusted r squared
predictors_lasso_reduced = horzcat(predictors(:,1:2), predictors(:,6:7), ...
    predictors(:, 9), predictors(:, 11));
multiple_reg_mdl = fitlm(predictors_lasso_reduced, response);
CI = coefCI(multiple_reg_mdl);
adj_r = multiple_reg_mdl.Rsquared.adjusted;

winter = [4 0 0 1 0.32 0.1179];
spring = [1 0 1 1 0.34 0.1343];
summer = [2 0 1 1 0.44 0.1075];
autumn = [3 0 1 1 0.46 0.1060];
peak_day = [2 1 0 1 0.4778 0.0299];
low_demand = [4 1 1 4 0.2 0.1493];


[mean_num_bikers, mean_peak, mean_low] = NumRiders(winter, spring, ...
    summer, autumn, peak_day, low_demand, multiple_reg_mdl);

predicted_data_lasso = predict(multiple_reg_mdl, predictors_lasso_reduced);
residuals_lasso = response - predicted_data_lasso;

% Plotting Predicted Data Against Residuals
for i = 1:6
    figure();
    title(strcat('Residuals for Reduced Lasso Regression: Predictor Number__', ...
        int2str(i)));
    hold on;
    plot(predictors_lasso_reduced(:,i), residuals_lasso, '.r', 'MarkerSize', 15);
end

disp('Lasso Regression Finished')

end

