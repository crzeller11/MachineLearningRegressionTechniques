function [ ridge_betas, multiple_reg_mdl, CI, adj_r, mean_num_bikers, mean_peak, mean_low ] = RidgeResgression( data )

% isolate predictors and response 
predictors = data(:, 1:11);
response = data(:, 14);

% columns 2, 5 and 6 are removed: decreasing between increasing lambda 
% values very small p values. Used lambda = 400, lambdas of 0-500 were
% considered and tested. 
ridge_betas = ridge(response, predictors, 400, 0);

predictors_ridge_reduced = horzcat(predictors(:,1), predictors(:,3:4), ...
    predictors(:, 7:11));

multiple_reg_mdl = fitlm(predictors_ridge_reduced, response);
CI = coefCI(multiple_reg_mdl);
adj_r = multiple_reg_mdl.Rsquared.adjusted;

winter = [4 12 1 1 0.3415 0.32 0.63 0.1179];
spring = [1 3 0 1 0.3415 0.34 0.71 0.1343];
summer = [2 6 0 1 0.4634 0.44 0.76 0.1075];
autumn = [3 9 0 1 0.5122 0.46 0.74 0.1060];
peak_day = [2 6 1 1 0.5827 0.4778 0.5 0.0299];
low_demand = [4 12 0 4 0.2439 0.2 0.8 0.1493];


[mean_num_bikers, mean_peak, mean_low] = NumRiders(winter, spring, ...
    summer, autumn, peak_day, low_demand, multiple_reg_mdl);

predicted_data_ridge = predict(multiple_reg_mdl, predictors_ridge_reduced);
residuals_ridge = response - predicted_data_ridge;

for i = 1:8
    figure();
    title(strcat('Residuals for Reduced Ridge Regression: Predictor Number__', ...
        int2str(i)));
    hold on;
    plot(predictors_ridge_reduced(:,i), residuals_ridge, '.g', 'MarkerSize',...
        15);
end

disp('Ridge Regression Finished')

end

