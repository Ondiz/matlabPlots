function toPdf(inputFolder, outputFolder)

% Export all files in folder to pdf without opening
% 
% - inputFolder: complete path to folder where fig figures stand
% - outputFolder: complete path to folder to where pdfs should be exported  

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




