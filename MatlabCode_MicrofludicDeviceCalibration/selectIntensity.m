 function desiredIntensity = selectIntensity(testImage)
%% The aim of this function is to use a single test image to find the 
%  maximum intensity to use when attempting to view the figures. When no
%  intensity range is used, the images can become illegible and the
%  selection of the ROI at a later stage will be impeded.

%% Determine Correct Intensity to View Images
% Variables
% maxIntensity = max(max(testImage));
maxIntensity = 65000;
minIntensity = min(min(testImage));
desiredIntensity = maxIntensity;

% Show First Image of ND2 file:
f = figure;
ax = axes('Parent', f, 'position', [0.13 0.39 0.77 0.54]);
h = imshow(testImage, [minIntensity, maxIntensity]);

% Add slider to the image:
b = uicontrol('Parent',f,'Style','slider','Position',[81,75,419,50],...
              'value', maxIntensity, 'min',0, 'max',maxIntensity,...
              'Tag', 'Slider');
bgcolor = f.Color;          
bl1 = uicontrol('Parent',f,'Style','text','Position',[27,54,50,50],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,50,50],...
                'String',num2str(maxIntensity),'BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
                'String','Intensity Value','BackgroundColor',bgcolor);

% Add selection button to the image:
c = uicontrol('Parent',f,'Style','pushbutton','Position',[45,15,150,50],...
              'string', 'Select Current Max Intensity', 'Callback',...
              @button1_Callback, 'Tag', 'Button1');            

function updateIntensity(val)
    desiredIntensity = val;
    close(f)
end

% Set update functions
b.Callback = @(es, ed) imshow(testImage, [0, es.Value]);
c.Callback = @(er, et) updateIntensity(get(findobj('Tag', 'Slider'), 'Value'));

uiwait(f);

end     
