function [ noncollinear_predictors, multiple_reg_mdl, CI, adj_r, ...
    mean_num_bikers, mean_peak, mean_low ] = CollinearRegression( data )

predictors = data(:, 1:11);
response = data(:, 14);

% Plotting Colinear Features 
figure();
plot(predictors(:,1), predictors(:,3), 'm.', 'MarkerSize', 15);
hold on;
title('Features 1 and 3: Season and Month');

figure();
plot(predictors(:,8), predictors(:,9), 'm.', 'MarkerSize', 15);
hold on;
title('Features 8 and 9: Temperature and ATemperature');

figure();
plot(predictors(:,7), predictors(:, 10), 'm.', 'MarkerSize', 15);
hold on;
title('Features 7 and 10: Weather Situation and Humidity');

% Excluding Collinear Predictors
noncollinear_predictors = horzcat(data(:, 1:2), data(:, 4:6), data(:, 8), ...
    data(:, 10:11));

% New Regression
multiple_reg_mdl = fitlm(noncollinear_predictors, response);
CI = coefCI(multiple_reg_mdl);
adj_r = multiple_reg_mdl.Rsquared.adjusted;

winter = [4 0 1 1 0 0.3415 0.63 0.1179];
spring = [1 0 0 3 1 0.3415 0.71 0.1343];
summer = [2 0 0 5 1 0.4634 0.76 0.1075];
autumn = [3 0 0 0 1 0.5122 0.74 0.1060];
peak_day = [2 1 1 6 0 0.5827 0.5 0.0299];
low_demand = [4 1 0 2 1 0.2439 0.8 0.1493];

% Predict Number of Bikers
[mean_num_bikers, mean_peak, mean_low] = NumRiders(winter, spring, summer,...
    autumn, peak_day, low_demand, multiple_reg_mdl);

predicted_data = predict(multiple_reg_mdl, noncollinear_predictors);
residuals = response - predicted_data;

% Plot Predicted data with Residuals
for i = 1:8
    figure();
    title(strcat('Plotting Reduced Non-Collinear Residuals with Predictor__',...
        int2str(i)));
    hold on;
    plot(noncollinear_predictors(:,i), residuals, '.b', 'MarkerSize', 15);
end

disp('Collinear Regression Finished')

end