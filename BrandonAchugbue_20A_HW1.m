%% 1

% Brandon Achugbue
% 4/1/2022
% this script records the heart rates of 12 people on two separate days and
% performs operations on this vectorized data

%% 2

% clear any previously defined variables from memory
clear;

%% 3

% define vectors called beatsPerMinDay1 and beatsPerMinDay2, consisting of
% the heart-rate measurements from day 1 and day 2, in beats-per-minute,
% respectively
beatsPerMinDay1 = [98.4 87.2 66.9 90.2 68.4 69.1 73.7 81.3 69.4 97.6 51.8 105.5];
beatsPerMinDay2 = [100.5 86.0 54.7 79.2 75.2 67.0 81.4 63.1 77.9 90.3 57.3 102.8];

%% 4

% define vectors called beatsPerSecDay1 and beatsPerSecDay2 consisting of
% the day 1 and day 2 heart-rates convertd to beats-per-second,
% respectively
beatsPerSecDay1 = beatsPerMinDay1/60;
beatsPerSecDay2 = beatsPerMinDay2/60;

%% 5

% define meanBeatsPerSecDay1 and meanBeatsPerSecDay2 as the mean heart-rate
% in beats-per-second on day 1 and day 2, respectively
meanBeatsPerSecDay1 = mean(beatsPerSecDay1);
meanBeatsPerSecDay2 = mean(beatsPerSecDay2);

%% 6

% define propHeartRateDecrease as the proportion of subjects whose heart
% rate was lower on day 2 than on day 1
propHeartRateDecrease = mean(beatsPerMinDay2 < beatsPerMinDay1);

%% 7

% define whichSubjectHeartRateIncrease as a vector giving the indexes of
% the subjects whose heart rate was higher on day 2 than on day 1
whichSubjectHeartRateIncrease = find(beatsPerMinDay2 > beatsPerMinDay1);

%% 8

% define numUnusualHeartRateDay1 and numUnusualHeartRateDay2 as the number
% of heart rates that were either lower than 60 beats-per-minute or higher
% than 95 beats-per-minute on day 1 and day 2, respectively
numUnusualHeartRateDay1 = sum(beatsPerMinDay1 < 60 | beatsPerMinDay1 > 95);
numUnusualHeartRateDay2 = sum(beatsPerMinDay2 < 60 | beatsPerMinDay2 > 95);

%% 9

% define beatsPerMinIn70sDay1 and beatsPerMinIn70sDay2 as vectors
% containing only the heart-rates that were >=70 and <80 beats-per-minute
% on day 1 and day 2, respectively
beatsPerMinIn70sDay1 = beatsPerMinDay1(beatsPerMinDay1 >= 70 & beatsPerMinDay1 < 80);
beatsPerMinIn70sDay2 = beatsPerMinDay2(beatsPerMinDay2 >= 70 & beatsPerMinDay2 < 80);

%% 10

% define roundSortedBeatsPerMinDay1 as the day 1 heart rates, rounded to
% the nearest whole number and sorted from lowest to highest
roundSortedBeatsPerMinDay1 = sort(round(beatsPerMinDay1));
