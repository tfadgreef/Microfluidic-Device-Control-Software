function [intensities] = intensityDetermination(images, XCoords, YCoords)
%% This function serves to determine the average intensity within a 
%  previously determined region of interest for all images recorded during
%  the calibration process. 
%
% The inputs of this function comprise the original, unedited images as
% well as the X- and Y-coordinates of those pixels which fall within the
% region of interest. 
%
% The function returns a matrix which contains the average intensity of
% pixels within the ROI for all images within the series. Each row of this
% matrix correlates to a single reaction chamber on the microfluidic device
% with each column representing the insensity therof at a different time
% point. 

%% Variable determination
numOfChambers = size(images,1);
timePoints = size(images{1,1},1);
intensities = zeros(numOfChambers,timePoints); % Zeros(rows, col)

%% The intensities within the ROI is determined. 
for i = 1:timePoints
    for j = 1:numOfChambers
        currIm = images{j,1}{i,1};
        intensities(j,i) = mean(currIm(sub2ind(size(currIm),XCoords{j,1},YCoords{j,1})));
    end
end

end