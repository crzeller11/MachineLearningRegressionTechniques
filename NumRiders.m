function [ numriders, num_peak, num_low ] = NumRiders( winter, spring, ...
    summer, autumn, peak, low, regression )

prediction_winter_avg = predict(regression, winter);
prediction_spring_avg = predict(regression, spring);
prediction_summer_avg = predict(regression, summer);
prediction_autumn_avg = predict(regression, autumn);
numriders = (prediction_winter_avg + prediction_spring_avg + ...
    prediction_summer_avg + prediction_autumn_avg) / 4; 

num_peak = predict(regression, peak);
num_low = predict(regression, low);

end

