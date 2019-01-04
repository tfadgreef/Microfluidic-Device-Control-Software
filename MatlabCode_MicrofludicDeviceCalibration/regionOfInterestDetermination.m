function [XCoordinates, YCoordinates] = regionOfInterestDetermination(images, intensityRange)
%% This function is used to determine the regions of interest for each of 
%  channels of the microfluidic device. The images are loaded and the user
%  is required to select the region of interest from which the intensity
%  will be determined.
%
% The function output is a matrix containing the regions of interest for
% each of the images in a single data set. 
%
% The inputs of the function are the images themselves as well as the
% intensity range used to make the images visable. 

%% Show each of the images and determine the region of interest.
XCoordinates = cell([size(images,1), 1]);
YCoordinates = cell([size(images,1), 1]);

for i = 1:size(images,1)
    % Select each image and proceed to select the desired range.
    % Selection is acheived by selecting the corner points of the region of
    % interest in a clockwise manner, starting at the top-left corner.
    imageFull = images{i,1}{2,1};
    imshow(imageFull,intensityRange);

    mask = roipoly;

    % Obtain the coordinates of all points within the ROI 
    [XCoordinates{i,:}, YCoordinates{i,:}] = find(mask);
end

close all

end

