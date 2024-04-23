% Create a patchMicrostrip antenna
% Generated by MATLAB(R) 9.14 and Antenna Toolbox 5.4.
% Generated on: 16-Apr-2024 16:15:38

%% Antenna Properties 

antennaObject = patchMicrostrip;
antennaObject.FeedOffset = [0.015, 0];
% Show
figure;
show(antennaObject) 

%% Antenna Analysis 
% Define plot frequency 
plotFrequency = 1670*1e6;
% Define frequency range 
freqRange = (1503:16.7:1837)*1e6;
% Reference Impedance 
refImpedance = 50;
% pattern
figure;
pattern(antennaObject, plotFrequency)
set(gcf,'Fontname', 'Times New Roman')
% azimuth
figure;
patternAzimuth(antennaObject, plotFrequency, 0, 'Azimuth', 0:5:360)
% elevation
figure;
patternElevation(antennaObject, plotFrequency,0,'Elevation',0:5:360)

