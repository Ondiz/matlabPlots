function zoomSubplot(figNum,r,c,axis,lim1,lim2)

% Same zoom into all subplots
%
% Arguments: 
% - figNum: number of the figure with subplots
% - f: number of rows
% - c: number of columns
% - axis: axis to synchronise 'x', 'y' or 'xy' 
% - lim1: limit to axis if single
% - lim2: limits to second axis (x and then y)

% Copyright (C) 2016  Ondiz Zarraga
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

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