% ﻿Split data by labels for two-class classification
%clear all
%close all 
%clc
%load('EEG_epoch.mat'); % already _cut 
% set1 set2 set3 set4 set5 set6 set7
%event =  [140 145 150 160 170 180 200];
codeUsers  = [1034,1037,1045,1158,1363,1368,1385,2038,6639,7974,7977,7980,1327];
eval(h.idxDATAY);
%class_balance = [];
cls = [
    140 145;
    150 160;
    180 200;
    150 170;
    160 170];

class_balan = [];
class1_balan1 = zeros([5,13]);
class1_balan2 = class1_balan1;
for i=1:5 %3:3%1:5
    for j = 1:13
        idx1 = dataY(:,EVENT_) == cls(i,1) & dataY(:,USER_) == codeUsers(j);
        idx2 = dataY(:,EVENT_) == cls(i,2) & dataY(:,USER_) == codeUsers(j);
        idx  = idx1 | idx2; 

        X = dataX(idx,:,:);
        Y = dataY(:,EVENT_);
        tsk = 180+0*Y; % A vector of the same dimensionality
        Y(idx1,1) = 0;
        Y(idx2,1) = 1;
        Y = Y(idx,1);
        %usr = dataY(idx,USER_);    
        %save('EEG_all', 'X', 'Y', 'usr', 'tsk');
        %save(['EEG_',num2str(i), '_', num2str(cls(i,1)), 'vs', num2str(cls(i,2))], 'X', 'Y');
        disp(['class balance: ' num2str(sum(idx1)), ' vs ', num2str(sum(idx2))]); 
        % class1_balan1(i, end+1) = [cls(i,1), cls(i,2), sum(idx1), sum(idx2)];
        class1_balan1(i, j) = sum(idx1);
        class1_balan2(i, j) = sum(idx2);
    end
end
% CONCLUSION see class_balan
