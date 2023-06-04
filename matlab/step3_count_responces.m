% ﻿Count users' responses for class balance
% clear all
% close all 
% clc
% %load('EEG_epoch.mat'); % already _cut 
% load('EEG_epoch_raw_new.mat')
% set1 set2 set3 set4 set5 set6 set7
%event =  [140 145 150 160 170 180 200];
codeUsers  = [1034,1037,1045,1158,1363,1368,1385,2038,6639,7974,7977,7980,1327];
%eval(h.idxDATAY);
eval('USER_ = 1; EVENT_ = 2; RESP_ = 3; ONSET_ = 4; END_ = 5; RESP2_ = 6; END2_ = 7;')
%class_balance = [];
clses = [140 145 150 160 170 180 200];
resps = [1 2 11 12];

table=[];
tab = [];
for uu = codeUsers
    for cc = clses %3:3%1:5
        idx = dataY(:,EVENT_) == cc & dataY(:,USER_) == uu;

        idx1 = dataY(:,EVENT_) == cc & dataY(:,USER_) == uu & dataY(:,RESP_) == 1;
        idx2 = dataY(:,EVENT_) == cc & dataY(:,USER_) == uu & dataY(:,RESP_) == 2;
        idx3 = dataY(:,EVENT_) == cc & dataY(:,USER_) == uu & dataY(:,RESP_) == 11;
        idx4 = dataY(:,EVENT_) == cc & dataY(:,USER_) == uu & dataY(:,RESP_) == 12;
        idx5 = dataY(:,EVENT_) == cc & dataY(:,USER_) == uu & dataY(:,RESP2_) > 0;
      tab = [tab, sum(idx), sum(idx1), sum(idx2), sum(idx3), sum(idx4), sum(idx5)];
    end
    table(end+1,:) = [uu tab];
    tab = [];
end
% COUCLUSION SEE table
