% Brandon Achugbue
% 5/8/2022

% this script will import a color image file of the recording artist Drake,
% perform various modifications of the image, display images, and save two
% files

clear           % clear variables from workspace
clc             % clear the command window
close all       % close all figure windows
rng default     % select the default random number generator
rng(0)          % set the seed of the random number generator to zero

%% ORIGINAL IMAGE

drakeOriginal = imread('drakeMeme.jpg');  % import original drake meme image
drakeHeight = height(drakeOriginal);      % original image height
drakeWidth = width(drakeOriginal);        % original image width

%% EXTRACT TOP HALF OF IMAGE

drakeTop = drakeOriginal(1:drakeHeight/2, :, :); % original drake indexed by the top half of its pixels

%% VERTICALLY & HORIZONTALLY MIRROR THE IMAGE

drakeUD = flipud(drakeTop);       % drakeTop image flipped upside down
drakeLR = fliplr(drakeTop);       % drakeTop image flipped left-right
drakeRot90 = rot90(drakeTop, 2);  % drakeTop image rotated 180 degrees counter-clockwise

drakeMirror = [drakeTop drakeLR   % drake mirrors concatenated to drakeTop
    drakeUD drakeRot90];

%% BLACK-TO-DARK-MAGENTA GRADIENT

% 1200x1200x3 RGB array of a linear color-gradient that goes from black 
% [0 0 0] to dark magenta [128 0 128]

zeroTo128Vector = uint8(linspace(0, 128, 1200));               % 1200 evenly spaced uint8 values between 0 and 128
blackToMagentaGradient = repmat(zeroTo128Vector, 1200, 1, 3);  % repeat pattern to get the same size as drakeMirror
blackToMagentaGradient(:,:,2) = 0;                             % set all values to 0 on green page 

% i chose to hard-code the 1200s here, because using drakeWidth*2 or
% drakeHeight to get 1200 is unintuitive at this point, as we're no longer
% working with the original drake image that had those specifications --
% doing so would only serve to confuse myself and readers

%% REPLACE BACKGROUND WITH GRADIENT

% replacement mask for yellowish background pixels in drakeMirror to be replaced
yellowPixelReplaceMask = drakeMirror(:, :, 1) > 150 & drakeMirror(:, :, 2) > 150 & drakeMirror(:, :, 3) < 150;

% replace the replacement pixels with gradient image, and the
% non-replacement pixels with the drakeMirror image
drakeGrad = blackToMagentaGradient .* uint8(yellowPixelReplaceMask) + drakeMirror .* uint8(~yellowPixelReplaceMask);

%% REPLACE BACKGROUND WITH NOISE

% 1200x1200x3 RGB array of randomly colored pixels
noise = uint8(randi([0 255], [1200 1200 3]));

% replace the replacement pixels with noise image, and the non-replacement
% pixels with the drakeMirror image
drakeNoise = noise .* uint8(yellowPixelReplaceMask) + drakeMirror .* uint8(~yellowPixelReplaceMask);

%% EXTRA CREDIT: CREATE FADE, AND ADD CONCENTRIC CIRCLES

zeroToOneVector   = linspace(0, 1, 1200)' ;             % 1200 linearly spaced values from 0 to 1 (vertical)
gradientMask      = repmat(zeroToOneVector, 1, 1200) ;  % replicate zeroToOneVector horizontally

% apply mask and convert back to uint8
drakeFade = uint8(double(blackToMagentaGradient) .* gradientMask + double(drakeGrad) .* (1 - gradientMask)) ;

radii = linspace(0, drakeWidth, 10);

drakeCircles = insertShape(drakeFade, 'FilledCircle', [drakeWidth drakeHeight/2 radii(1); 
    drakeWidth drakeHeight/2 radii(2); drakeWidth drakeHeight/2 radii(3); 
    drakeWidth drakeHeight/2 radii(4); drakeWidth drakeHeight/2 radii(5); 
    drakeWidth drakeHeight/2 radii(6); drakeWidth drakeHeight/2 radii(7); 
    drakeWidth drakeHeight/2 radii(8); drakeWidth drakeHeight/2 radii(9); 
    drakeWidth drakeHeight/2 radii(10)], ...
                           'Color', 'yellow', 'Opacity', 0.1) ;
                       
% couldn't figure out how to automate this process:
% making the height, width, and radii arguments vectors didn't work
% calling insertShape within a for loop didn't work

%% DISPLAY

figure(1)                             % open figure 1 window

subplot(2, 2, 1)                      % select position 1 in 2x2 grid of images
imshow(drakeTop)                      % show drakeTop image
title('drakeTop', 'FontSize', 14)     % image title + font size

subplot(2, 2, 2)                      % select position 2 in 2x2 grid of images
imshow(drakeMirror)                   % show drakeMirror image
title('drakeMirror', 'FontSize', 14)  % image title + font size

subplot(2, 2, 3)                      % select position 3 in 2x2 grid of images
imshow(drakeGrad)                     % show drakeGrad image
title('drakeGrad', 'FontSize', 14)    % image title + font size

subplot(2, 2, 4)                      % select position 4 in 2x2 grid of images
imshow(drakeNoise)                    % show drakeNoise image
title('drakeNoise', 'FontSize', 14)   % image title + font size

figure(2)                             % open figure 2 window

imshow(drakeNoise)                    % show only drakeNoise image
title('drakeNoise', 'FontSize', 14)   % image title + font size

figure(3)                             % open figure 3 window

imshow(drakeCircles)                  % show drakeCircles image
title('drakeCircles', 'FontSize', 14) % image title + font size

%% SAVE

imwrite(drakeNoise, 'drakeNoise.png')   % export drakeNoise to a png file called drakeNoise.png
saveas(1, 'drakefig.pdf')               % export figure 1 to a pdf file called drakefig.pdf
