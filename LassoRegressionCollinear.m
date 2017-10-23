function [ betas, multiple_reg_mdl, CI, adj_r, mean_num_bikers, mean_peak, ...
    mean_low ] = LassoRegressionCollinear( noncollinear_predictors, response )

% isolate predictors and response 
predictors = noncollinear_predictors;

% Running lasso regression on original predictor set and response
% columns 5, 6, 7 (lmbda at col80 = [188.976823609557])
betas = lasso(predictors, response);

predictors_lasso_reduced = horzcat(predictors(:,1:4), predictors(:,8));
multiple_reg_mdl = fitlm(predictors_lasso_reduced, response);
CI = coefCI(multiple_reg_mdl);
adj_r = multiple_reg_mdl.Rsquared.adjusted;

winter = [4 0 1 1 0.1179];
spring = [1 0 0 3 0.1343];
summer = [2 0 0 5 0.1075];
autumn = [3 0 0 0 0.1060];
peak_day = [2 1 1 6 0.0299];
low_demand = [4 1 0 0.8 0.1493];

[mean_num_bikers, mean_peak, mean_low] = NumRiders(winter, spring, summer, ...
    autumn, peak_day, low_demand, multiple_reg_mdl);

predicted_data_lasso = predict(multiple_reg_mdl, predictors_lasso_reduced);
residuals_lasso = response - predicted_data_lasso;

for i = 1:5
    figure();
    title(...
        strcat('Residuals for Collinear Reduced Lasso Regression: Predictor Number__',...
        int2str(i)));
    hold on;
    plot(predictors_lasso_reduced(:,i), residuals_lasso, '.r', ...
        'MarkerSize', 15);
end

disp('Non-Collinear Lasso Regression Finished')

end

