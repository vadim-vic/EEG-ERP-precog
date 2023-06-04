% ﻿Collect data from Neuropype .mat
clc
clear all
close all
strPATH = '/Users/victor/EEGcode/128ch_unfiltered/';
strFILE = '_VerbMem.mat';
nameUsers = [1037 1363 2038 7977 1045 1368 6639 7980 1034 1327 1385 7974];

% Types of events, the target variable
strOC = 'recognition_old-word_onset_correct';   % 0 Even is correct 0 is Old
strOI = 'recognition_old-word_onset_incorrect'; % 1 in Incorrect
strNC = 'recognition_new-word_onset_correct';   % 2 Two is New
strNI = 'recognition_new-word_onset_incorrect'; % 3 
posElec = []; % Dummy for checkup

% Temporary variables to save
dataX = [];
dataY = []; 
dataU = [];
timeY = [];

for nameUser = nameUsers
    load([strPATH, num2str(nameUser), strFILE]); % The users' data structure
    %---
    % First index is trial or event
    timY = data.chunks.eeg.block.axes{1, 1}.times; % Absolute start of an oblect
    markY = data.chunks.eeg.block.axes{1, 1}.data.recarray.Marker;
    %checkY = data.chunks.eeg.block.axes{1, 1}.data.recarray.TargetValue; % Classes 1 is New O is Old
    % Construct target, 2x2classes     
    datY = - ones([length(markY),1]);
    datY(...
        strcmp(strOC, markY)) = 0;
    datY(...
        strcmp(strOI, markY)) = 1;
    datY(...
        strcmp(strNC, markY)) = 2;
    datY(...
        strcmp(strNI, markY)) = 3;
    if any(datY == -1)
        disp('Target Marker error!');
    end
    %What is it? %eeg.axes{1, 1}.data.recarray.TargetTrialIndexAsc  
    %---    
    % Second index is time
    datX = data.chunks.eeg.block.data;          % events, time, electrodes
    datX = permute(datX, [1, 3, 2]);            % EVENTS, ELECTRODES, TIME
    tmp_timeX = data.chunks.eeg.block.axes{1, 2}.times;% One ERP trial time
    %---
    % Third index is space or electrode
    tmp_posElec = data.chunks.eeg.block.axes{1, 3}.positions;
    tmp_nameElec= data.chunks.eeg.block.axes{1, 3}.names;
    % strmatch(strtrim('A1 ') , strtrim('A1')) for later
    % Check is the time and also electrodes have the same positions
    if ~isempty(posElec) 
        if prod([...
                prod(tmp_posElec == posElec)...
                prod(tmp_nameElec == nameElec)...
                prod(tmp_timeX == timeX)...
                ]) == 0
            disp('Electrode position or name vary');
        end
    else
        timeX    = tmp_timeX;
        posElec  = tmp_posElec;
        nameElec = tmp_nameElec;
    end    
    %---
    % Collect all users in the joined dataset to save
    dataX = cat(1, dataX, datX); 
    dataY = cat(1, dataY, datY); 
    dataU = cat(1, dataU, nameUser * ones(size(datY)));
    timeY = cat(1, timeY, timY');     
end
% We need to save
% dataX, dataY, Users, timeY, and the common 
% timeX, nameElec, posElec
save('eeg_May23_unfilt.mat', 'dataX', 'dataY', 'dataU', 'nameUsers', 'timeY', 'timeX', 'nameElec', 'posElec');
