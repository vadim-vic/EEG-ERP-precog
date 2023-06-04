% Analysis of users' correct and incorrect responses, first and second hit
clc
clear all
close all
load('EEG_Recog_elAll_2000ms_Apr28.mat');
%load('EEG_All.mat');
eval('USER_ = 1; EVENT_ = 2; RESP_ = 3; ONSET_ = 4; END_ = 5; RESP2_ = 6; END2_ = 7;')
codeUsers = [1034,1037,1045,1158,1363,1368,1385,2038,6639,7974,7977,7980,1327];
orderUsers = [13	4	2	1	6	11	12	9	5	8	7	3	10]'; % Keep this order
% The best users are the first, the best delivers maximium accuracy on modelling.
%codeUsers = 2038;

table = [];

for codeUser = codeUsers
    row = [];    
    % Time to response
    idx = find( dataY(:,USER_) == codeUser );        
    tmp = dataY(idx, END_);
    row(end+1) = mean(tmp);                    % Average time to responce
    row(end+1) =  std(tmp);                    % Standard deviation of time
    
    % Time between responce and changed responce, number of changeed responces
    idx = find( dataY(:,USER_) == codeUser & dataY(:,END2_) > 0 );
    if ~isempty(idx)
        tmp = - dataY(idx, END_) + dataY(idx, END2_);
        row(end+1) = length(tmp);              % Number of changes in responces
        row(end+1) = mean(tmp);                % Average time bewteen first and se cond responce
        row(end+1) =  std(tmp);                % Standard deviation of time
    else        
        row(end+1 : end+3) = 0; 
    end
    
    % Number of incorrect responces
    idx = find( dataY(:,USER_) == codeUser & dataY(:,RESP_) <= 2 );
	if ~isempty(idx)
        tmp = dataY(idx, END_);
        row(end+1) = length(tmp);               % Number of incorrect responces
        row(end+1) =  mean(tmp);                % Average time to incorrect responce 
        row(end+1) =  mean(tmp);                % Standard deviation of time
    else
        row(end+1 : end+3) = 0;
    end
    
    % Responce 2 was incorrect
    idx = find( dataY(:,USER_) == codeUser & dataY(:,RESP2_) <= 2 );
    row(end+1) = length(idx);

	table(end+1,:) = row;
end

row = [];
pva = [];

table = [codeUsers' orderUsers table]; % Second is the order to correlate with
for col = table
   [row(end+1), pva(end+1)] = corr(orderUsers, col, 'Type','Spearman');  %Kendall
end
table(end+1,:) = row;
table(end+1,:) = pva;

% CONCLUSION See table and its last row with correltion betweent the first
% column and the other columns
% NO CORRELATION!!!

