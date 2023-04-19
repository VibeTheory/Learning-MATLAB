% Brandon Achugbue
% 5/30/2022

% this script generates 3 pieces of audio, plays them, and then saves them
% to .wav files

clear                   % clear all variables from the workspace
clc                     % clear the command window
close all               % close all figure windows
rng default             % random number generator method
rng(0)                  % set the seed to 0

sampleRate = 44100    ; % sample rate for noise (44100 is high enough to accommodate full frequency range of human hearing)

%% STATIC WHITE NOISE

whiteNoiseTargetRMS      = .05                                        ; % we want average volume of white noise to be 5% of total volume
whiteNoiseLengthSecs    	= 5                                       ; % desired length of noise in seconds
whiteNoiseLengthSamples  = round(whiteNoiseLengthSecs * sampleRate)   ; % corresponding length of noise in samples
whiteNoise               = randn(whiteNoiseLengthSamples, 1)          ; % column of Gaussian white noise

whiteNoiseOriginalRMS = sqrt( mean(whiteNoise .^ 2) )                 ; % average volume of the white noise generated above
noiseScaled...
    = whiteNoise * whiteNoiseTargetRMS/whiteNoiseOriginalRMS          ; % white noise rescaled to have desired volume

%% SWELLING WHITE NOISE

fadeInVector        = linspace(0, 1, whiteNoiseLengthSamples)' .^3    ; % column vector of exponentially increasing values from 0 to 1
fadeOutVector       = flipud(fadeInVector)                            ; % reverse of that vector

noiseFadeIn      = noiseScaled .* fadeInVector                        ; % white noise starting at silence and gradually fading to original volume
noiseFadeOut     = noiseScaled .* fadeOutVector                       ; % white noise starting at original volume and gradually fading to silence

noiseSwell       = [noiseFadeIn                                         
                    noiseFadeOut]                                     ; % fade in and fade out combined

swellSampleRate = 2*sampleRate                                        ; % speed up the sample rate for noiseSwell since we've made it twice as long

swellSecs = height(noiseSwell)/swellSampleRate                        ; % amount of time it takes to play noiseSwell (in secs)

%% MELODY

leftToneFreq1       = 800                                             ; % frequency of 1st left tone
rightToneFreq1      = 700                                             ; % frequency of 1st right tone
leftToneFreq2       = 600                                             ; % frequency of 2nd left tone
rightToneFreq2      = 500                                             ; % frequency of 2nd rigth tone

silenceFreq        = 0                                                ; % frequency of silence

toneSecs       = 0.5                                                  ; % length of each tone in seconds
silenceSecs    = 0.1                                                  ; % length of each piece of silence between tones

toneNumSamples = ceil(toneSecs * sampleRate)                          ; % number of samples needed for desired tone-duration
silenceNumSamples = ceil(silenceSecs * sampleRate)                    ; % number of samples needed for desired silence-duration

toneTimeVector = (0:toneNumSamples-1) / sampleRate                    ; % "time vector" giving timestamp (in seconds) for each sample in the tone
silenceTimeVector = (0:silenceNumSamples-1) / sampleRate              ; % "time vector" giving timestamp (in seconds) for each sample in the piece of silence

leftSineTone1       = sin(2 * pi * leftToneFreq1 * toneTimeVector)'   ; % 1st left tone  
rightSineTone1      = sin(2 * pi * rightToneFreq1 * toneTimeVector)'  ; % 1st right tone
leftSineTone2       = sin(2 * pi * leftToneFreq2 * toneTimeVector)'   ; % 2nd left tone  
rightSineTone2      = sin(2 * pi * rightToneFreq2 * toneTimeVector)'  ; % 2nd right tone

silence            = sin(2 * pi * silenceFreq * silenceTimeVector)'  ;  % silence between tones
silenceBlock       = sin(2 * pi * silenceFreq * toneTimeVector)'     ;  % silence in one ear while a tone is playing in another

melodyLeft         = [leftSineTone1                                     % 1st left tone
                        silence                                         % silence between tones
                        silenceBlock                                    % silence in left while 1st right tone is playing
                        silence                                         % silence between tones
                        leftSineTone2                                   % 2nd left tone
                        silence                                         % silence between tones
                        silenceBlock]                                 ; % silence in left while 2nd right tone is playing
                    
melodyRight        = [silenceBlock                                      % silence in right while 1st left tone is playing
                        silence                                         % silence between tones
                        rightSineTone1                                  % 1st right tone
                        silence                                         % silence between tones
                        silenceBlock                                    % silence in right while 2nd left tone is playing
                        silence                                         % silence between tones
                        rightSineTone2]                               ; % 2nd right tone
                        
melody              = [melodyLeft melodyRight]                        ; % combine left and right audio streams

melodySecs       = height(melody)/sampleRate                          ; % amount of time it takes to play melody (in secs)

%% PLAY AUDIO

fprintf("Playing static white noise\n\n")
sound(.2*noiseScaled, sampleRate)                                       % play static white noise tone
pause(whiteNoiseLengthSecs+1)                                           % wait for the length of the sound + 1 second
clear sound                                                             % stop sound

fprintf("Playing swelling white noise\n\n")
sound(noiseSwell, swellSampleRate)                                      % play swelling white noise tone
pause(swellSecs+1)                                                      % wait for the length of the sound + 1 second
clear sound                                                             % stop sound

fprintf("Playing melody\n\n")
sound(.2*melody, sampleRate)                                            % play sine-wave tone
pause(melodySecs+1)                                                     % wait for the length of the sound + 1 second
clear sound                                                             % stop sound

%% SAVE AUDIO

audiowrite('noiseScaled.wav', noiseScaled, ...                          % save noiseScaled to a .wav file
    sampleRate, 'BitsPerSample', 24)

audiowrite('noiseSwell.wav', noiseSwell, ...                            % save noiseSwell to a .wav file
    sampleRate, 'BitsPerSample', 24)

audiowrite('melody.wav', melody, ...                                    % save melody to a .wav file
    sampleRate, 'BitsPerSample', 24)
