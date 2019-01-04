function [finalRefreshRatio, averageRefreshRatiosPerReactor] = plotIntensityCurves(intensities)
%% This function will plot the intensity curve of the fluorescence 
%  intensity within the reaction chambers over time as well as determine
%  the final refresh ratios and plot these as well. 

%% Variables
numOfChambers = size(intensities,1);
timePoints = size(intensities,2)-1;
refreshRatios = zeros(numOfChambers,timePoints-1);

%% Determine Corrected Intensities
% The first image recorded is taken before the channels are flushed with
% EGFP, thus providing a measure of the background. This background is
% removed from each of the other images. 
correctedIntensities = intensities(:,2:end) - intensities(:, 1);

%% Determine Refresh Ratios
% The refresh ratio, or the percentage of the reactor ring which is
% refreshed per dilution sequence is expressed as thea fraction of the
% volume of the reactor ring which is being refreshed. This is found by
% determining the change in intensity during the dilution. 
for i = 2:timePoints
    refreshRatios(:,i-1) = 1 - (correctedIntensities(:,i)./correctedIntensities(:,i-1));
end

averageRefreshRatiosPerReactor = mean(refreshRatios(:,:),2);

%% Display Results
% Plot the Corrected Intensities
figure(1)
plot(correctedIntensities')
title('Intensities per Reactor');
legend('Channel 1','Channel 2','Channel 3','Channel 4','Channel 5','Channel 6',...
    'Channel 7','Channel 8');
xlabel('Dilution Steps'); ylabel('Intensity [A.U.]');

% Plot the final refresh ratios
figure(2)
plot(refreshRatios')
title('Refresh Ratios per Reactor');
legend('Channel 1','Channel 2','Channel 3','Channel 4','Channel 5','Channel 6',...
    'Channel 7','Channel 8');
xlabel('Dilution Steps'); ylabel('Refresh Ratio')


%% Select Correct Channels
% Here, we select the channels which show the correct 
selectedChannels = myGUI(numOfChambers);


%% Determine Average Refresh Ratios
% This is the average refresh ration of each individual reactor which has 
% been selected. This array is only used to then determine the average
% refresh ratio across all selected reactors. 
averageRefreshRatiosPerReactor2 = mean(refreshRatios(selectedChannels,:),2);

% This is the average refresh ratio across all reactors which have been
% selected. This can be used as an estimate when loading all reactors at
% the same time.
finalRefreshRatio = mean(averageRefreshRatiosPerReactor2);

%% Print Results
correctedIntensities
refreshRatios
