function phase_vocoder_GUI25
% Modifiable runGUI file
clc;
clear all;

% USER - ENTER FILENAME
fileName = 'phase_vocoder.mat';    
fileData=load(fileName);
temp=fileData(1).temp;

f = figure('Visible','on',...
'Units','normalized',...
'Position',[0,0,1,1],...
'MenuBar','none',...
'NumberTitle','off');
% %SENSE COMPUTER AND SET FILE DELIMITER
% switch(computer)				
%     case 'MACI64',		char= '/';
%     case 'GLNX86',  char='/';
%     case 'PCWIN',	char= '\';
%     case 'PCWIN64', char='\';
%     case 'GLNXA64', char='/';
% end
% 
% % find speech files directory by going up one level and down one level
% % on the directory chain; as follows:
%     dir_cur=pwd; % this is the current Matlab exercise directory path 
%     s=regexp(dir_cur,char); % find the last '\' for the current directory
%     s1=s(length(s)); % find last '\' character; this marks upper level directory
%     dir_fin=strcat(dir_cur(1:s1),'speech_files'); % create new directory
%     start_path=dir_fin; % save new directory for speech files location

% USER - ENTER PROPER CALLBACK FILE
Callbacks_phase_vocoder_GUI25(f,temp);    
%panelAndButtonEdit(f, temp);       % Easy access to Edit Mode

% Note comment PanelandBUttonCallbacks(f,temp) if panelAndButtonEdit is to
% be uncommented and used
end

% GUI Lite 2.5 for phase vocoder
% 1 Panel
% 1 TitleBox
% 6 Buttons
%   #1 - pushbutton - Speech Directory
%   #2 - popupmenu - Speech Files
%   #3 - editable button - r: slowdown (r in range 1-4)/speedup (r in range
%   0.25 -1) factor
%   #4 - editable button - wlen: analysis window length
%   #5 - pushbutton - Run Phase Vocoder
%   #6 - pushbutton - Close GUI