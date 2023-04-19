% Brandon Achugbue
% 5/1/2022

% this script runs a free-association exercise that works as follows: a
% series of words is presented, and after each presented word the subject
% responds as quickly as possible by typing the first word that comes to
% mind


clear           % clear variables from workspace
clc             % clear the command window
rng shuffle     % shuffle the random number generator

%% PREPARE WORD-PROMPTS

wordTable = readtable('free association word list.csv'); % input data
numPrompts = 10;                                         % number of word-propmts used in the exercise

nonAdjIndex = wordTable{:, 'IsAdjective'} == 0;          % location of all non-adjectives
allNonAdj = wordTable{nonAdjIndex, 'Word'};              % all non-adjectives
pickNonAdj = randperm(numel(allNonAdj), numPrompts/2);   % 5 random non-adj locations
nonAdj = allNonAdj(pickNonAdj)';                         % 5 random non-adjectives

adjIndex = wordTable{:, 'IsAdjective'} == 1;             % location of all adjectives
allAdj = wordTable{adjIndex, 'Word'};                    % all adjectives
pickAdj = randperm(numel(allAdj), numPrompts/2);         % 5 random adjective locations
adj = allAdj(pickAdj)';                                  % 5 random adjectives

prompts = [nonAdj                                        % 2x5 cell array containing 10 randomly selected non- 
            adj]                                         % adjectives and adjectives, in each respective row

%% FREE-ASSOCIATION EXERCISE

responses = cell(numPrompts,1);     % cell column vector to hold subject's responses
responseSecs = NaN(numPrompts,1);   % numeric column vector to hold subject's response times

% display instructions
fprintf('***FREE-ASSOCIATION EXERCISE***\n\nAfter each presented word, type the first word that comes to mind in response.\nType your answer as quickly as possible without thinking about it, and then press Return.\n\nPress any key to begin.\n');
pause

for i = 1:numPrompts                                    % for the number of specified prompts
    
    clc;                                                % clear the command window
    tic;                                                % start timing the response
    
    while isempty(responses{i})                         % until a nonempty response is given
        responses{i} = input([prompts{i} '\n'], 's');   % present each prompt and collect a response
    end
    
    if strcmp(responses{i}, 'abort exercise')           % if the response is 'abort exercise'
        fprintf('\nExercise aborted.');                 % print 'Exercise aborted.'
        return                                          % and end the program immediately
    end
        
    responseSecs(i) = toc;                              % stop timing the response
end

%% REPORT

% a table with columns for the prompts in the order they were presented,
% corresponding user responses, and corresponding response times (in secs)
resultsTable = table;
resultsTable.Prompt = reshape(prompts, 10, 1);
resultsTable.Response = responses;
resultsTable.Seconds = responseSecs;

clc;                                   % clear the command window
disp(resultsTable);                    % display resultTable in the command window
fprintf('\nExercise complete!\n');

%% SAVE

save('psych20ahw5data.mat', 'prompts', 'responses', 'responseSecs')
writetable(resultsTable, 'psych20ahw5results.csv')
