% Brandon Achugbue
% 4/7/2022
% this script diagrams a short chess match between two players and analyzes
% the amount of time each player took for each move

% white pawn = 1, white rook = 2, white knight = 3, white bishop = 4, white
% queen = 5, white king = 6, corresponding negative numbers for the black
% pieces (black pawn = -1, black rook = -2, etc.), and empty square = 0

clear; % clear all previously defined variables from memory

%% BOARD DIAGRAMS

whitePawns = [1 1 1 1 1 1 1 1];
whiteNumbers = [2 3 4 6 5 4 3 2];
blackPawns = -whitePawns;
blackNumbers = -whiteNumbers;
empty = [0 0 0 0 0 0 0 0];

% an 8x8 matrix representing a chessboard with the pieces in standard
% starting positions (white on top and black on bottom)
boardStart = [whiteNumbers
    whitePawns
    repmat(empty, 4, 1)
    blackPawns
    blackNumbers];

% an 8x8x6 array in which the pages show the positions of the pieces after
% each move (starting positions not included)
fullGame = repmat(boardStart, 1, 1, 6);

% move 1
fullGame(2, 4, :) = 0;
fullGame(4, 4, :) = 1;

% move 2
fullGame(5, 5, 2:6) = -1;
fullGame(7, 5, 2:6) = 0;

% move 3
fullGame(4, 4, 3:6) = 0;
fullGame(5, 5, 3:6) = 1;

% move 4
fullGame(5, 5, 4:6) = -5;
fullGame(8, 5, 4:6) = 0;

% move 5
fullGame(1, 4, 5:6) = 0;
fullGame(2, 4, 5:6) = 6;

% move 6 (checkmate)
fullGame(4, 4, 6) = -5;
fullGame(5, 5, 6) = 0;

% fullGame rotated so that white is on the right and black is on the left
fullGameRotated = rot90(fullGame, 3);

%% MOVE-TIME ANALYSIS

% move times for white and black
moveTimesWhite = [0.2 0.7 1.2];
moveTimesBlack = [0.5 0.9 0.6];
moveSecs = [moveTimesWhite 
    moveTimesBlack];

% minimum move times for white and black, respectively
minMoveSecs = min(moveSecs, [], 2);

% overall mean move time
grandMeanMoveSecs = mean(moveSecs(:));

% total time (in seconds) elapsed in the game
totalGameSecs = sum(moveSecs(:));
