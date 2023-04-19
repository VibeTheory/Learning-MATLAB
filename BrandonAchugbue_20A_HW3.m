% Brandon Achugbue
% 4/7/2022
% This script collects survey responses via keyboard input, analyzes the
% responses, and saves the data

clear;
clc;

%% GET SURVEY RESPONSES VIA KEYBOARD

responseCell = cell(4,1); % 4x1 vector of empty cells

% gather text from user input returned as a character vector
responseCell{1} = input("What is your favorite color?\n", "s");
responseCell{2} = input("What is your favorite style of music?\n", "s");
responseCell{3} = input("What is your favorite movie?\n", "s");
responseCell{4} = input("Describe your current mood in words?\n", "s");

% print closing message
fprintf('\nThe survey is complete.\nThank you for participating!\n');

% convert responseCell vector to a structure
responseStruct = cell2struct(responseCell,{'faveColor','faveMusic','faveMovie','mood'});

%% ANALYZE RESPONSES

% new field in responseStruct containing the number of characters in each
% respective response from the responseCell vector
responseStruct.responseNumChar = [numel(responseCell{1})
    numel(responseCell{2})
    numel(responseCell{3})
    numel(responseCell{4})];

% new field in responseStruct containing the number of characters in the
% user's last response, not including spaces
responseStruct.moodNumCharNoSpace = numel(strrep(responseCell{4},' ',''));

% new field in responseStruct containing the number of e's in the user's
% last response
responseStruct.moodNumE = numel(strfind(responseCell{4}, "e")) + numel(strfind(responseCell{4}, "E"));

% new field in responseStruct containing the number of words in the user's
% last response
responseStruct.moodNumWords = numel(strsplit(responseCell{4}));

%% SAVE DATA

% save responseStruct to a Matlab data file
save('psych20ahw3data.mat', 'responseStruct');

% create a text file containing the subject's response about mood
fileID = fopen('psych20ahwmood.txt','w');
fprintf(fileID, "The subject's response to ""Describe your current mood in words"" was:\n" + responseCell{4});
fclose(fileID);

