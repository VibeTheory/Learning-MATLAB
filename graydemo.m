clear
close all % close all figure windows

imageMatrix1 = zeros(25, 35);   % initialize image as 25x35 matrix of zeros
imageMatrix1(13, :) = 1;        % make middle row all 1s
imageMatrix1(:, 18) = 1;        % make middle column all 1s

figure(1)               % open figure 1 window
subplot(2, 2, 1)        % select position 1 in 2x2 grid of images
imshow(imageMatrix1)    % put imageMatrix1 image in that window

imageMatrix2 = imageMatrix1;    % initialize imageMatrix2 as imageMatrix1
imageMatrix2(1:12, 1:17) = .5;  % make top left quadrant grey
subplot(2, 2, 2)                % select position 2 in 2x2 grid of images
imshow(imageMatrix2)            % put imageMatrix2 image in that window


imageMatrix3 = imageMatrix2; % initialize imageMatrix3 as imageMatrix2
imageMatrix3(14:end, 19:end) = rand(12,17); % make bottom right quadrant randon values

subplot(2, 2, 3:4)     % select position 3 in 2x2 grid of images
imshow(imageMatrix3) % put imageMatrix3 image in that window

% 0 --> Black
% 1 --> White
% .5 --> Grey

