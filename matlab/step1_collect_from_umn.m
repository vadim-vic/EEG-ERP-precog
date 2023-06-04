% Collect prepared data from flat matrices (with reversed time)
% Load prepared data to form the design matrix Events x Electrodes x Time
% and simplified target matrix with columns User, Event, Response.
% Only two types of Events are collected: Old word versus New word in the 
% Recognition task.
% All Correct and Incorrect responses were collected.
clc 
clear all
close all
load('/Users/victor/EEGcode/1037/1037_VerbMem_ecnt_af.mat');
strPATH = '/Users/victor/EEGcode/';
strFILE = '_VerbMem_ecnt_af.mat';
bDISP   = false;%true; % Report about errors in data.
% Users, tasks, and events
codeUsers  = [1034,1037,1045,1158,1363,1368,1385,2038,6639,7974,7977,7980,1327];
% codeEvents = [140, 145, 150, 160, 170, 180, 200]; % Cut for only these two
CLS1 = 180; CLS2 = 200; %Old word versus New word in the Recognition task
R1W = 2; R1C = 11; R2W = 1; R2C = 12; % The codes picked up from the data.% Matches description.
dataX = [];
dataY = [];
eval('USER_ = 1; EVENT_ = 2; RESP_ = 3; ONSET_ = 4; END_ = 5; RESP2_ = 6; END2_ = 7;');
for codeUser = codeUsers  % Example: '1037'
    fname = [strPATH,num2str(codeUser),'/',num2str(codeUser),strFILE];
    %load(fname) % Load user data and events    
    %% load 2038_VerbMem_ecnt_af data
    data      = load(fname); % './2038/2038_VerbMem_ecnt_af.mat');
    % resturcture eeg data
    eeg_data = [];
    for i=1:length(data.ecnt_af.sweep_af.ev)
        start_ind  = 462*i - 461;
        end_ind    = 462*i;
        eeg_data(i,:,:) = data.ecnt_af.data(:,start_ind:end_ind);
    end 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Encoding
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RT Analysis
    % small stim and correct
    part_s_c = find(data.ecnt_af.sweep_af.ev == CLS1 & data.ecnt_af.sweep_af.correct == 1);
    % small stim and incorrect
    part_s_w = find(data.ecnt_af.sweep_af.ev == CLS1 & data.ecnt_af.sweep_af.correct == -1);
    % large stim and correct
    part_l_c = find(data.ecnt_af.sweep_af.ev == CLS2 & data.ecnt_af.sweep_af.correct == 1);
    % large stim and incorrect
    part_l_w = find(data.ecnt_af.sweep_af.ev == CLS2 & data.ecnt_af.sweep_af.correct == -1);  
    % Extract X data
    x_s_c = eeg_data(part_s_c,:,:);
    x_l_c = eeg_data(part_l_c,:,:);
    x_s_w = eeg_data(part_s_w,:,:);
    x_l_w = eeg_data(part_l_w,:,:);  
    % Extract Y data (User, Event, Response codes); zeros to keep the format dataY.
    y_s_c = repmat([codeUser, CLS1, R1C 0 0 0 0], length(part_s_c), 1);
    y_l_c = repmat([codeUser, CLS2, R2C 0 0 0 0], length(part_l_c), 1);
    y_s_w = repmat([codeUser, CLS1, R1W 0 0 0 0], length(part_s_w), 1);
    y_l_w = repmat([codeUser, CLS2, R2W 0 0 0 0], length(part_l_w), 1);
    % Collect to the design matrix
    dataX = cat(1, dataX, x_s_c);
    dataX = cat(1, dataX, x_l_c);
    dataX = cat(1, dataX, x_s_w);
    dataX = cat(1, dataX, x_l_w);
    % Collect to the target matrix
    dataY = cat(1, dataY, y_s_c);
    dataY = cat(1, dataY, y_l_c);
    dataY = cat(1, dataY, y_s_w);
    dataY = cat(1, dataY, y_l_w);
    % 
    disp(['User: ', num2str(codeUser), ' sample size: ', num2str(length(part_s_c)+length(part_l_c)+length(part_s_w)+length(part_l_w))]);
end
% All electrodes and 462 samples
save('UMN_Recog_elAll_1800ms_Apr28.mat', 'dataX', 'dataY');
idxElecs = [103    85    71     1   127    19    43    15]'; % See line 147 make_dataset
% Cut the electrodes
dataXFull = dataX;
dataX = dataX( :, idxElecs, :);
save('UMN_Recog_elRec_1800ms_Apr28.mat', 'dataX', 'dataY');

% Cut the time series to 800 ms = 204 samples = 462 - 258
dataX = dataXFull;
dataX( :, :, 205:end) = [];
save('UMN_Recog_elAll_800ms_Apr28.mat', 'dataX', 'dataY');

% and electrodes
dataX = dataX( :, idxElecs, :);
save('UMN_Recog_elRec_800ms_Apr28.mat', 'dataX', 'dataY');