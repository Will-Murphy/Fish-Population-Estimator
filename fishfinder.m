%  William Murphy, March 30 2017  
%% Fish Estimator Function Using MC Integration 
function [stdev_halfday,mean_halfday, stdev_fullday,mean_fullday] = fishfinder

rng('shuffle')

%% Tagging Fish 
fish_rand_vector = zeros(1,2000);
C = randperm(2000,100);
fish_rand_vector(C) = 1; 
tagged_fish = sum(fish_rand_vector);

%% Year-long for loop 
for i = 1:365
    
    fish_per_day_1 = 100;
    fish_per_day_2 = 200; 
 
    % Producing number of fish estimate after half day fishing
    gone_fishing_1 = datasample(fish_rand_vector,fish_per_day_1); 
   
    number_of_fish_1(i) = (fish_per_day_1*tagged_fish)/sum(gone_fishing_1); 
    
    % Producing number of fish estimate after half day fishing
    gone_fishing_2 = datasample(fish_rand_vector,fish_per_day_2); 
   
    number_of_fish_2(i) = (fish_per_day_2*tagged_fish)/sum(gone_fishing_2);         
end

%% Calculating Outputs

mean_halfday = mean(number_of_fish_1(~isinf(number_of_fish_1)));
stdev_halfday = std(number_of_fish_1(~isinf(number_of_fish_1)));

mean_fullday = mean(number_of_fish_2(~isinf(number_of_fish_2)));
stdev_fullday = std(number_of_fish_2(~isinf(number_of_fish_2)));

%% Plotting Estimates

plot(number_of_fish_1, 'b*')
hold on 
plot(number_of_fish_2, 'r+')
title('Estimates of Fish in Pond From Tagged Fish')
xlabel('Days')
ylabel('Daily Estimate of Fish in Pond')
legend('half day','full day')

end 
