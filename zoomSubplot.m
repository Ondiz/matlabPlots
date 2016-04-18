function zoomSubplot(figNum,r,c,axis,lim1,lim2)

% Same zoom into all subplots:
%
% figNum: number of the figure with subplots
% f: number of rows
% c: number of columns
% axis: axis to synchronise 'x', 'y' or 'xy' 
% lim1: limit to axis if single
% lim2: limits to second axis (x and then y)

figure(figNum)

num = length(findall(gcf,'type','axes')); % detect number of subplots in plot

handles = zeros(1,num);

for k = 1:num
   
    handles(k) = subplot(r,c,k);
    
end

linkaxes(handles,axis) % same zoom

if nargin > 5

    xlim(lim1)
    ylim(lim2)
    
elseif axis == 'x'
    
    xlim(lim1)
    
else
    
    ylim(lim1)
    
end