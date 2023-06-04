%﻿Generate LaTeX script for time series plot
clc
%clear all
close all
load('EEG_Recog_elRec_800ms_Apr28.mat')
h.codeUsers;
eval(h.idxDATAY);

% The highest accuracy first
codeUsers = [1158	1045	7980	1037	6639	1363	7977	7974	2038	1327	1368	1385	1034];
codeUser = 1158;

for codeUser = codeUsers
    nameElecs = {'D7', 'C21', 'C7', 'A1', 'D31', 'A19', 'B11', 'A15'}; %Maps to the recomennded 
    nameElecs = {'D7 (F7)', 'C21 (Fz)', 'C7 (F8)', 'A1 (Cz)', 'D31 (P7)', 'A19 (Pz)', 'B11 (P8)', 'A15 (O1)'}; 
    cls = [180, 200];

    idx1 = dataY(:,EVENT_) == cls(1) & dataY(:,USER_) == codeUser & dataY(:,RESP_) > 2;
    idx2 = dataY(:,EVENT_) == cls(2) & dataY(:,USER_) == codeUser & dataY(:,RESP_) > 2;

    eegEX1 = smoothdata(squeeze(mean(dataX(idx1,:,:),1)),2, 'Gaussian', 15); 
    eegEX2 = smoothdata(squeeze(mean(dataX(idx2,:,:),1)),2, 'Gaussian', 15); 
    eegDX1 = smoothdata(squeeze( std(dataX(idx1,:,:),1)),2, 'Gaussian', 15); 
    eegDX2 = smoothdata(squeeze( std(dataX(idx2,:,:),1)),2, 'Gaussian', 15); 

    Xaxis = 'Amplitude';
    task_fname  = [num2str(codeUser),'_1'];
    EEGplot(eegEX1', nameElecs, Xaxis, task_fname);
    task_fname  = [num2str(codeUser),'_2'];
    EEGplot(eegEX2', [], Xaxis, task_fname)
    Xaxis = 'Devation';
    task_fname  = [num2str(codeUser),'_3'];
    EEGplot(eegDX1', [], Xaxis, task_fname);
    task_fname  = [num2str(codeUser),'_4'];
    EEGplot(eegDX2', [], Xaxis, task_fname);
end

task_fname = 'class1=2std';
X = eegDX2';

%%
function EEGplot(X, nameElecs, Xaxis, task_fname)
h = figure; 
hold('on');
set(gcf, 'Position', get(0, 'Screensize'));
pbaspect([3,1,1]);

plot(X,'Linewidth', 2);
axis('tight');
xticks(linspace(1,204,9));
xticklabels({'0','100','200','300','400','500','600','700','800'});
xlabel('Latency, msec (256 Hz)', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
ylabel([Xaxis, ', $\mu$V'], 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');
if ~isempty(nameElecs)
    legend(nameElecs);
end
%title(['Task: ', task], 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');    
PATHfigure = '/Users/victor/Desktop/Figures/';
set(gca,'LooseInset',get(gca,'TightInset'))
saveas(h, [PATHfigure, task_fname,'.png'], 'png');
%saveas(h, [PATHfigure, filename,'.eps'], 'epsc'); % For report
%saveas(h, [PATHfigure, filename,'.svg'], 'svg');
hold('off');
close(h);
end

%% LaTex lines to combine
str0 = '﻿\documentclass[12pt, twoside]{article}\usepackage[utf8]{inputenc}\usepackage{graphicx}\usepackage{caption}\usepackage{subcaption}\begin{document}\pagenumbering{gobble}';
str1 = '\thispagestyle{empty}\begin{figure}\begin{subfigure}{\textwidth}\vspace{-1.5cm}\hspace{-1cm}\includegraphics[width=1.2\textwidth]{';
str2 = '_1.png}\end{subfigure} \\ \begin{subfigure}{\textwidth}\vspace{-1.cm}\hspace{-1cm}\includegraphics[width=1.2\textwidth]{';
str3 = '_2.png}\end{subfigure} \\ \begin{subfigure}{\textwidth}\vspace{1.cm}\hspace{-1cm}\includegraphics[width=0.6\textwidth]{';
str4 = '_3.png}\includegraphics[width=0.6\textwidth]{';
str5 = '_4.png}\end{subfigure}\caption{';
str6 = '}\end{figure}\newpage';
str7 = '﻿\end{document}';

%% Make LaTeX file 
disp(str0);
for codeUser = codeUsers
    txt = num2str(codeUser);
    disp([...
        str1,txt,...
        str2,txt,...
        str3,txt,...
        str4,txt,...
        str5,txt,...
        str6
        ]);
end
disp(str7);