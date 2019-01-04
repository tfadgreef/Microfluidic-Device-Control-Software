function reactors = myGUI(numberofReactors)

reactors = [];

% Create figure
f = figure('units','pixels','position',[200,200,100,200],...
             'toolbar','none','menu','none');
% Create yes/no checkboxes
for i = 1:numberofReactors
    c(i) = uicontrol('style','checkbox','units','pixels',...
                    'position',[10,170-((i-1)*20),170,20],'string',sprintf('Reactor: %d', i));
end
% Create OK pushbutton   
p = uicontrol('style','pushbutton','units','pixels',...
                'position',[40,5,70,20],'string','OK',...
                'callback',@p_Callback);
            
function updateChecks(vals)
    reactors = find([vals{:}]);
    close(f)
end

p.Callback = @(es, er) updateChecks(get(c, 'Value'));


uiwait(f)
end