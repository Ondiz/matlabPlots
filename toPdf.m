function toPdf(inputFolder, outputFolder)

% Export all files in folder to pdf without opening
% 
% Arguments
% - inputFolder: complete path to folder where fig figures stand
% - outputFolder: complete path to folder to where pdfs should be exported 

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

cd(inputFolder)

files = ls(inputFolder);
files = files(3:end, 1:end); % delete first two entries (. and ..)
files = cellstr(files); % convert to cell to ease manipulation

number = size(files,1); % compute number of files, outside loop to avoid rep

% Output names = names without extension

outName = cellfun(@(x) x(1:(end-4)), files, 'UniformOutput', false); % lambda to delete extension

for f = 1:number

    h = openfig([inputFolder '\' files{f}],'new','invisible'); % open fig without showing

    h.PaperOrientation = 'landscape';
    
    % Set the figure on screen the same size as the print to avoid legend
    % appearing out the box
       
    pu = get(gcf,'PaperUnits');
    pp = get(gcf,'PaperPosition');
    set(gcf,'Units',pu,'Position',pp)
    
    name = [outputFolder '\' outName{f}];
    
    % To avoid extra white space export to eps and covert to pdf using
    % epstopdf (from MikTeX distro)
    
    saveas(h,name,'epsc') %c to export in colour
    
    % To avoid problems with \r\n Windows line endings
    
    eps = fileread([name '.eps']);
    fd = fopen([name '.eps'], 'wt');
    fwrite(fd, eps);
    fclose(fd);
    
    system(['epstopdf ' [name '.eps']]);
    
    close(h);

end

% Delete .eps files

cd(outputFolder)
delete *.eps




