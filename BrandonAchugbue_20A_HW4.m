% Brandon Achugbue
% 4/21/2022

% This script gives the user a quiz on state capitals, in alphabetical
% order by state, and then reports their score

clear  % clear variables from workspace
clc    % clear the command window

stateCapitalTable = readtable('usStates.csv'); % input data

%% INPUT NUMBER OF STATES

% ask user for number of states/questions to include on the quiz
n = 0; % total questions
while ~ismember(n, [1:50]) % until the user gives a number between 1 and 50
    n = input('Enter the number of states to include on the quiz: ');
end

% So that users aren't entering code, and only char vectors, use this:
% n = str2double(input('Enter the number of states to include on the quiz: ');

%% DEFINE QUIZ ITEMS

state = stateCapitalTable{1:n, 'State'}; % a cell array containing the states we're using 
capital = stateCapitalTable{1:n, 'Capital'}; % a cell array containing those states' respective capitals

% Alternative syntax:
% state = stateCapitalTable.State(1:n); 
% capital = stateCapitalTable.Capital(1:n);

%% GIVE QUIZ

response = cell(n, 1);      % empty cell array to hold user's responses
scoreCard = false([1,n]);   % vector of logical 0s to record correct/false responses

% for-loop to give the quiz and collect the responses
for iState = 1:n % for each question on the quiz
    
    % ask for the capital of each state
    response{iState} = input(['\nWhat''s the capital of ' state{iState} '?\n '], 's');

    if strcmpi(response{iState}, capital{iState})     % if answer correct
        fprintf('\nCorrect!\n')                       % say correct
        scoreCard(iState) = 1;                        % update scoreCard
        
    elseif strcmpi(response{iState}, 'stop')          % if user types stop
        fprintf('\nQuiz aborted')                     % say quiz aborted
        return                                        % abort program
        
    else
        fprintf('\nIncorrect!\n')                     % else say incorrect 
    end
    
end

%% REPORT SCORE

score = sum(scoreCard);     % number of correct answers
percent = (score/n)*100;    % percent correct out of total questions

fprintf('You got %d out of %d answers correct(%.1f%%).\n', score, n, percent)
