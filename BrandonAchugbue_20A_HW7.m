% Brandon Achugbue
% 5/14/2022

% this script simulates a study to evaluate the efficacy of a drug that is
% supposed to improve memory. it computes basic statistics and makes graphs
% about the data.

% each participant has been randomly assigned to either the treatment or
% control group, and has completed two memory tests: a "digit span" test
% and an "image recognition" test, each scored from 0 to 100.

clear       % clear all variables from the workspace
close all   % close all figure windows

%% IMPORT & EXTRACT DATA

dataTable = readtable('fakeMemoryData2022.csv');              % input data

placeboIndex = dataTable{:, 'Condition'} == 0;                % location of all placebo subjects
treatIndex = dataTable{:, 'Condition'} == 1;                  % location of all treatment subjects

scorePlaceboDigit = dataTable{placeboIndex, 'DigitScore'};    % digit scores of placebo
scorePlaceboObject = dataTable{placeboIndex, 'ObjectScore'};  % object scores of placebo

scoreTreatDigit = dataTable{treatIndex, 'DigitScore'};        % digit scores of treatment
scoreTreatObject = dataTable{treatIndex, 'ObjectScore'};      % object scores of treatment

%% STATISTICS

meanPlaceboDigit = mean(scorePlaceboDigit);     % mean digit-span score in the placebo group
meanPlaceboObject = mean(scorePlaceboObject);   % mean object-recognition score in the placebo group
meanTreatDigit = mean(scoreTreatDigit);         % mean digit-span score in the treatment group
meanTreatObject = mean(scoreTreatObject);       % mean object-recognition score in the treatment group

sdPlaceboDigit = std(scorePlaceboDigit);        % std. deviation of the digit-span scores in placebo
sdPlaceboObject = std(scorePlaceboObject);      % std. deviation of the object-recognition scores in placebo
sdTreatDigit = std(scoreTreatDigit);            % std. deviation of the digit-span scores in treatment
sdTreatObject = std(scoreTreatObject);          % std. deviation of the object-recognition scores in treatment

semPlaceboDigit = std(scorePlaceboDigit)/sqrt(numel(scorePlaceboDigit));    % std. error of mean of digit-span placebo
semPlaceboObject = std(scorePlaceboObject)/sqrt(numel(scorePlaceboObject)); % std. error of mean of object-recognition placebo
semTreatDigit = std(scoreTreatDigit)/sqrt(numel(scoreTreatDigit));          % std. error of mean of digit-span treatment
semTreatObject = std(scoreTreatObject)/sqrt(numel(scoreTreatObject));       % std. error of mean of object-recognition treatment

%% FIGURE 1 - GROUPED BAR GRAPH

figure(1)                                           % open figure 1 window

scoreBarGraph = bar(1:2,...                         % grouped bar graph comparing the mean for placebo group
    [meanPlaceboDigit meanTreatDigit                % with mean for treatment group, grouped by type of test
    meanPlaceboObject meanTreatObject]);

scoreBarGraph(1).FaceColor = [.6 .75 1] ;           % make bar in position 1 (placebo) light blue
scoreBarGraph(2).FaceColor = [1 .65  0] ;           % make bar in position 2 (treatment) light orange

title('Mean Memory Scores', 'FontSize', 11)         % title
xlabel('Test Type')                                 % x-axis label
ylabel('Memory Score')                              % y-axis label

set(gca, 'XTick', 1:2)                              % specify where to put tick-mark locations on x-axis
set(gca, 'XTickLabel',...                           % string array of tick-labels for x-axis
    ["Digit-Span" "Object-Recognition"])  
set(gca, 'YGrid', 'on')                             % show horizontal grid lines on the graph

hold on                                             % hold to put error bars on the same graph
xOffset = get(scoreBarGraph, 'XOffset') ;           % cell array of horizontal offsets

errorbar((1:2) + xOffset{1},...                     % error bars w/o connecting lines for placebo,
    [meanPlaceboDigit meanPlaceboObject],...        % representing +- 1 std. deviation
    [sdPlaceboDigit sdPlaceboObject],...
    'LineStyle', 'none', 'Color', 'black'); 

errorbar((1:2) + xOffset{2},...                     % error bars w/o connecting lines for treatment,
    [meanTreatDigit meanTreatObject],...            % representing +- 1 std. deviation
    [sdTreatDigit sdTreatObject],...
    'LineStyle', 'none', 'Color', 'black');
hold off                                            % end hold

legend('Placebo', 'Treatment',...                   % legend
    'Location', 'northeastoutside')

annotation('textbox', [.726 .64 .12 .2],...         % text box explaining the error bars
    'String',...
    ['Error bars indicate ' char(177) '1 SD'],...
    'EdgeColor', 'none', 'FontSize', 9)

% note: creating the legend before the errorbars causes the legend to
% include the error bars (?)

%% FIGURE 2 - SCATTER PLOT

figure(2)                                           % open figure 2 window

scatter(scorePlaceboDigit, scorePlaceboObject,...   % scatter plot of placebo image recognition vs digit span scores
    'oblack', 'MarkerFaceColor', 'blue')            % make points for placebo group black circles filled with blue

hold on                                             % hold to put next scatter plot on the same graph
scatter(scoreTreatDigit, scoreTreatObject,...       % scatter plot of treatment image recognition vs digit span scores
    'dblack', 'MarkerFaceColor', [1 .5  0])         % make points for treatment group black diamonds filled with orange
hold off                                            % end hold

title('Object-Recognition vs. Digit-Span')          % title
xlabel('Digit-Span Score')                          % x-axis label
ylabel('Object-Recognition Score')                  % y-axis label

grid on                                             % show horizontal and vertical grid lines
axis square                                         % force the graph to be square
box on                                              % complete the box outlining the graph

legend('Placebo', 'Treatment',...                   % legend
    'Location', 'northeastoutside')   

%% SAVE FIGURES

saveas(figure(1), 'psych20ahw7fig1.pdf')            % save figure 1 as a pdf
saveas(figure(2), 'psych20ahw7fig2.pdf')            % save figure 2 as a pdf
