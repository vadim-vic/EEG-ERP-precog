% Plot the time to the first user response
clear all
close all 
clc
load('EEG_epoch_raw')

% Plot users' time response
h = figure;
set(gcf, 'Position', get(0, 'Screensize'));
plot(dataY(:,5));
hold on
axis tight
for user = task.codeUsers
    idx = find(user == dataY(:,1));
    meanResp = mean(dataY(idx, 5));
    stdResp  = std(dataY(idx, 5));
    try
    plot([min(idx) max(idx)],[meanResp meanResp], 'r-', 'LineWidth', 2);
    text(min(idx), meanResp, num2str(user), 'VerticalAlignment','top','FontName', 'Times','FontSize', 24);
    plot([min(idx) max(idx)],[meanResp-stdResp meanResp-stdResp], 'y-', 'LineWidth', 1);
    plot([min(idx) max(idx)],[meanResp+stdResp meanResp+stdResp], 'y-', 'LineWidth', 1);
    %plot(min(idx), meanResp, max(idx),meanResp, 'r-', 'LineWidth', 2);
    catch
        disp ok
    end
end
xlabel('Users','FontSize', 24, 'FontName', 'Times');
ylabel('Response time, samples 256 Hz','FontSize', 24, 'FontName', 'Times');
set(gca, 'FontSize', 24, 'FontName', 'Times');
saveas(h, 'Average response time.png','png');
saveas(h, 'Average response time.eps','psc2');
%CONCLUSION 1
%Cut the last samples of epoch ou to 300 from onset
% 512 - 212 = 300
%save('EEE_epoch_raw_cut', 'dataX', 'dataY', 'task');
%CONCLUSION 2
% Shall we use only two users? 1368 7977

