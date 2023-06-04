% Collect data from raw mat files
% Collect the 3-way matrix Events x Electrodes x Time from the raw data,
% given user from list of users. 
% Collect the simplified target matrix with columns User, Event, Response,
% Onset time (absolut in samples), Response time (relative to onset in samples), 
% Response-2 (code), Response-2 )relatove to onset in samples). 
%
% Only two types of Events are collected: Old word versus New word in the 
% Recognition task.
% All Correct and Incorrect responses were collected.
% The cut on electrodes and time is below. 
% The version of April 28th
clc 
clear all
close all
strPATH = '/Users/victor/EEGcode/';
strFILE = '_VerbMem_ecnt_af.mat';
% Usage example
% codeUser = 1034;
% fname = [strPATH,num2str(codeUser),'/',num2str(codeUser),strFILE];
% load('/Users/victor/EEGcode/1037/1037_VerbMem_ecnt_af.mat');

bDISP   = false; %true; % Report about errors in response and event codes.
% Users, tasks, and events
codeUsers  = [1034,1037,1045,1158,1363,1368,1385,2038,6639,7974,7977,7980,1327];
codeEvents = [140, 145, 150, 160, 170, 180, 200]; % Reduced in the next line!
codeEvents = [180, 200];%140, 145, 150, 160, 170, 180, 200]; MOVE TO BOTTOM
nameTasks  = {'Encoding', 'Encoding', 'Lexical', 'Lexical', 'Lexical', 'Old word', 'New word'};
codeTasks  = [  1,   1,   2,   2,   2,   3,   3]; 
nameEvents = {'Smaller word', 'Larger word', 'Old word', 'New word', 'Non-word', 'Old word', 'New word'};
codeResps  = [1 2 11 12]; %  All responses of events of a single task
nameResps  = {'incorrect','incorrect','correct','correct'};
% Save in the .mat file with class description in dataY
% Fields in the RAW data
%ecnt_af.elecnames  
%ecnt_af.samplerate; 
%ecnt_af.data;  % (electrodes, samples of time series)
%ecnt_af.event; % (1, samples of events)

%% Select electrodes: 1) all, and 2) recommended by experts
nameElecs = []; % Empty set means ALL ELECTRODES; Foe selected see below
[idxElecs, idxNeighbours] = indexElectrodes(nameElecs); % See below for reduced set.
% The time interval before and after event
%samplerate = 256; % Hz!

% Several variants how to cut the time segments to make ERP
%%% Start from before Onset 
smpMin = -76;  % To avoid convert from tMin, tMax
smpMin = -16;   % -2 -1 (0 1 2 3) ~4 Min=-2, Max=3, Total=6; 
smpMin = 0;
%%% Stop after Onset
smpMax = +410; 
smpMax = +512; % Them cut to 800 ms = 204 (=512-308)  samples (no it is greater than a second)

% Empty final matrices
dataX = []; % Collected epochs [epoch, electrode, sample]
dataY = []; % Collected lables [lable], _, _] of epochs
counter = 0;    % Event counter 
errcnt = 0;     % Error counter
wearehere = 0;  % Collected events counter, the factual sample size
for codeUser = codeUsers  % Example: '1037'
    fname = [strPATH,num2str(codeUser),'/',num2str(codeUser),strFILE];
    load(fname) % Load user data and events    
    %
    sampEvents = []; % Collect sample numbers of Events' Onsets for the loaded user
    for codeEvent = codeEvents 
        sampEvents = [sampEvents find(ecnt_af.event == codeEvent)]; 
    end
    counter =  counter+size(sampEvents,2);
    report(true,['User: ', num2str(codeUser), ' Events: ', num2str(size(sampEvents,2))]);
    for sampEvent = sampEvents % For each event gather the data
        sampX =    smpMin + sampEvent : sampEvent + smpMax - 1;
        sampResp =      1 + sampEvent : sampEvent + smpMax - 1; % response after event onset         
        if sampX(end) > size(ecnt_af.event,2) % avoid hit the end of raw record     
            report(bDISP,['User: ', num2str(codeUser), ' last event not enough data']);
            errcnt = errcnt + 1; 
            continue
        end
        % Collect responses; the second response appears when the user chandes its decision.
        cdresp=0; idxResp=0; cdresp2=0; idxResp2=0; % Type and latency of response
        responses = ecnt_af.event(1, sampResp);
        idxResp = find(responses > -1); % Any meaningful response
        if isempty(idxResp) % No neet to store an epoch without response
            report(bDISP,['User: ', num2str(codeUser), ' no response for event: ', num2str(sampEvent)]);     
            errcnt = errcnt + 1; 
            continue %This cycle 
        end
        if ~any(responses(idxResp(1)) == codeResps) % the FIRST response is legit
             report(bDISP, ['User:', num2str(codeUser), ...
                 ' broken code response for event: ', num2str(sampEvent),...
                 ' the coode: ', num2str(responses(idxResp)),...
                 ' at samples : ', num2str(sampEvent+idxResp)]);
            errcnt = errcnt + 1;                
            continue % The response must have a valid code.
         end 
         if size(idxResp,2) > 1 % Too many responses, check it NOW I keep it
             cdresp2 = responses(idxResp(2)); % NEW
             idxResp2  = idxResp(2)-1; % NEW
             if cdresp2 > 12                    % TODO fix this!!
                 cdresp2 = 0; % do nothig, it is the next event
                 idxResp2 = 0;
             end
         else
            cdresp2 = 0; % NEW
            idxResp2 = 0; % NEW      
            report(bDISP,['User:', num2str(codeUser), ...
                ' Too many repsponces at: ', num2str(idxResp),...
                ' namely: ' num2str(responses(idxResp))]);
            %continue
         end
        cdresp = responses(idxResp(1)); % response is the target class
        % Store 
        dataX(end+1, :,:) = ecnt_af.data(idxElecs, sampX); % the data
        cdevnt = ecnt_af.event(sampEvent);
        wearehere = wearehere+1; % Count of events, samples
        dataY(end+1,:)    = [codeUser, ...      % USER_   % user name
            cdevnt,...                          % EVENT_  % class target
            cdresp,...                          % RESP_   % user response
            sampEvent,...                       % ONSET_  % start of event
            idxResp(1)-1,...                    % END_    % response
            cdresp2,...                         % RESP2_  % second response, if any 
            idxResp2];                          % END2_   % end in response2
    end   
end
%
report(true, ['Total events discovered: ', num2str(counter), ' lost: ', num2str(errcnt), ' collected: ', num2str(wearehere)]);

% Save help
h.smpMin = smpMin;
h.smpMax = smpMax;
h.codeUsers = codeUsers;
h.codeEvents = codeEvents;
h.nameTasks  = nameTasks;
h.codeTasks  = codeTasks;
h.nameEvents = nameEvents;
h.codeResps  = codeResps;
h.nameResps  = nameResps;
% eval(idxDATAY)
h.idxDATAY   = 'USER_ = 1; EVENT_ = 2; RESP_ = 3; ONSET_ = 4; END_ = 5; RESP2_ = 6; END2_ = 7;';
% Note. Save electrode names and sample rate for all files from one.
% load('/Users/victor/EEGcode/1037/1037_VerbMem_ecnt_af.mat')
h.samplerite = ecnt_af.samplerate;
h.elecnames = ecnt_af.elecnames;
%clear('ecnt_af')

%Cut the data for <2 GB
% dataX(:, :, end-212 : end) = []; Before Apr21
h.smpMin = -16;%-76  % To avoid convert from tMin, tMax
h.smpMax = +204;%+512-308 % -2 -1 (0 1 2 3) ~4 Min=-2, Max=3, Total=6; 
h.idxNeighbours = idxNeighbours;
%% Sale all 2000ms
save('EEG_Recog_elAll_2000ms_Apr28.mat', 'dataX', 'dataY', 'h');
%%
%dataX( :, :, 1:60)          = [];
dataX( :, :, end-307 : end) = []; % Them cut to 800 ms = 204 (=512-308)
save('EEG_Recog_elAll_800ms_Apr28.mat', 'dataX', 'dataY', 'h');
%%
nameElecs = {'A30','A29', 'A28', 'A17', 'A16', 'A15', 'B5', 'B6', 'B7', 'B8', 'B9', 'B10'};
nameElecs = {'D7', 'C21', 'C7', 'A1', 'D31', 'A19', 'B11', 'A15'}; %Maps to the recomennded {'F7', 'Fz', 'F8', 'Cz', 'P7', 'Pz', 'P8', 'O1'}
% idxElecs = [103    85    71     1   127    19    43    15]'

[idxElecs, idxNeighbours] = indexElectrodes(nameElecs); %See below
h.idxNeighbours = []; % Empty. No neighbours for reduced set of electrodes!

dataX = dataX( :, idxElecs, : );
save('EEG_Recog_elRec_800ms_Apr28.mat', 'dataX', 'dataY', 'h');
% 
% down_rate = 20;
% dataX = smooth_down_flat(dataX,down_rate);
% save('EEG_epoch_raw_new_flat', 'matX', 'dataY', 'task');
%%
function report(bDisp, string)
    if bDisp
        disp(string)
    end
end
%%
function [idxElecs, idxNeighbours] = indexElectrodes(nameElecs)
    % Return indexes of electrodes by name and neighbours from an expert
    % table. The first column is the element itself, the next four are
    % nearest neighbours, the last are the second round of neighbours.
    % Minus one -1 means someboby has not so many neighbours. 
    load('ElectrodesMap')% Saved from EEG Google docs table Apr 28    
    % Convert dictionary to indexes  
    idxNeighbours = -1 * ones(size(ElectrodesMap));
    for i = 1 : size(ElectrodesMap,1)
        for j = 1 : size(ElectrodesMap,2) % The first col is electrodes, the rest are their neighbours                        
            idx = ...
                find(strcmp(ElectrodesMap{i,j},... % Find a name 
                            ElectrodesMap{:,1}));  % in dictionary
            if ~isempty(idx)%  Not everybody has many nerighbours
                idxNeighbours(i,j) = idx;             
            end
        end
    end    
    idxElecs = idxNeighbours(:,1);
    % If we have some recomended electrodes
    if ~isempty(nameElecs)
        idxElecs = []; % Must match with nameElecs in size  
        for i = 1 : length(nameElecs)
            idx = ...
                find(strcmp(nameElecs{i},... % Find a name 
                            ElectrodesMap{:,1}));  % in dictionary
            if ~isempty(idx)%  Not everybody has many nerighbours
                idxElecs(end+1,1) = idx;   
            end
        end
        % Check if we found all the electrode names
        if length(nameElecs) ~= length(idxElecs)
            disp('Some electrode names are not found in the dictionary');
        end
    end            
end
%% PYTHON CODE to accompany data structure (draft)
% class EEGdata:
%     def __init__(self):
%         self.samplerate = 0
%         self.elecrodes  = 0
% 
% data = EEGdata()
% 
% print(data.samplerate) # Output: 256
