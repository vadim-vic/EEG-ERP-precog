% ﻿Plot a histogram for class balances
% clear all
% close all 
% clc
% load('EEG_epoch_raw_new.mat'); % already _cut 
% set1 set2 set3 set4 set5 set6 set7
event =  [140 145 150 160 170 180 200];
label = {'1_Small', '1_Large', '2_Old', '2_New', '2_Non', '3_Old', '3_New'};
pltitle = {'Encoding, Smaller word', 'Encoding, Larger word', '2_Old', '2_New', '2_Non', 'Recognition, Old word', ' Recognition, New word'};
%task.helpY = {'user','code event','code response','event onset','delay response'}; % Columns 1 2 3 4 5 in dataY 
USER = 1; EVENT = 2; RESP = 3; ONSET = 4; DELAY = 5; RESP2 = 6; DELAY2 = 7; 
class_balance = [];
for i = [1 2 6 7] %size(event,2) % We have seven classification datsets 
    idxEvent = event(i) == dataY(:,EVENT);
    clsResp = unique(dataY(idxEvent,RESP));
    if size(clsResp,1)~=2
        disp(['Error in class lables in ', label{i}]);
        clsResp(1)=[]; % I JUST SAW THE DATA
    end
    %class_balance(end+1,:) = hist(dataY(idxEvent,RESP), tmp);
    idxResp1 = dataY(:,RESP) == clsResp(1);
    idxResp2 = dataY(:,RESP) == clsResp(2);
    % Rewrite the target Y
    datY = -1* ones(size(dataY,1),1);    
    datY(idxResp1) = 0; % First class
    datY(idxResp2) = 1; % Second class
    % Collect the dataset
    idxData  = idxEvent & (idxResp1 | idxResp2);
    datX = dataX(idxData,:,:);
    datY = datY(idxData);    
    idUsers = dataY(idxData,USER);
    
    %save(label{i},'datX','datY', 'idUsers');

    disp([label{i}, ' class balance; ',...
        num2str(sum(idxEvent & (idxResp1))), ' vs ',...
        num2str(sum(idxEvent & (idxResp2)))]);
% Plot histograms in the class balance
    h = figure;
    hist(dataY(idxEvent,RESP),clsResp);
    xlabel(['Task: ',pltitle{i}], 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
    ylabel('Sample size', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
    set(gca, 'FontSize', 24, 'FontName', 'Times');
    saveas(h, ['Hist_', pltitle{i}, '.png'],'png');
    close(h);
end