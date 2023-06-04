%﻿Convert former target data to new (After May 5th) target format
clc
clear all
close all
fnames = {...
'UMN_Recog_elAll_1800ms_Apr28',...
'UMN_Recog_elAll_800ms_Apr28',...
'EEG_Recog_elAll_2000ms_Apr28',...
'EEG_Recog_elAll_800ms_Apr28',...
'EEG_epoch_only3responses_corr'};
fname = fnames{1};

load([fname,'.mat']);

USER_=1; EVENT_=2; RESP_=3; ONSET_=4; HERTZ_ = 256;

idx0 = dataY(:,EVENT_) == 180 & dataY(:,RESP_) == 11; % Class 0, Old, Correct
idx1 = dataY(:,EVENT_) == 180 & dataY(:,RESP_) == 1;  % Class 1, Old, Incorrect
idx2 = dataY(:,EVENT_) == 200 & dataY(:,RESP_) == 12; % Class 1, New, Correct
idx3 = dataY(:,EVENT_) == 200 & dataY(:,RESP_) == 2;  % Class 4, New, Incorrect
disp(['Only task3: ',  string(1 == prod(sum([idx0, idx1, idx2, idx3], 2)))]); % Just check it

tempY = - ones(size(dataY,1),1);
tempY(idx0) = 0; 
tempY(idx1) = 1;
tempY(idx2) = 2;
tempY(idx3) = 3;
% Collect all four cases
idx = any([idx0, idx1, idx2, idx3], 2);  

% Total convertion
dataX = dataX(idx, :, :);
timeY = dataY(idx, ONSET_);
dataU = dataY(idx, USER_);
dataY = tempY(idx); % !!! REWRITE dataY 
nameUsers = unique(dataU);
% Time of a singe event and space of electrodes

ms_start = 0;                % The new format has explicit time scale in seconds
n_samples = size(dataX, 3);  % Here we worked in samples
ms_end  = n_samples / 256;   % Hz for the whole dataset  
if strcmp(fname(1:3), 'UMN') % Reverse time in the UMN collected data
     dataX = flip(dataX, 3);
     ms_start = 0 / HERTZ_; % The new format has explicit time scale in seconds   
     n_samples = size(dataX, 3);    % Here we worked in samples
     ms_end   = n_samples / HERTZ_;  % Hz for the whole dataset      
     nameElec = [];
else
    ms_start = h.smpMin / HERTZ_; % The new format has explicit time scale in seconds   
    ms_end   = h.smpMax / HERTZ_;  % Hz for the whole dataset  
    n_samples = size(dataX, 3);    % Here we worked in samples
    nameElec = h.elecnames;
end
disp(['Time goes from ', num2str(ms_start), ' to ', num2str(ms_end), ', samples: ', num2str(n_samples)]); 
plot(sort(timeY));
timeX = linspace(ms_start, ms_end, n_samples);
posElec =  [];

% The same as the step1_save_from_neurop.m


save(['/Users/victor/EEGcode/',fname,'updMay25.mat'], 'dataX', 'dataY', 'dataU', 'nameUsers', 'timeY', 'timeX', 'nameElec', 'posElec');