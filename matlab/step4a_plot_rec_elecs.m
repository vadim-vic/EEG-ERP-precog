% Temporary file to plot electrode tile series
clc
close all
clear all
%load('EEG_Recog_elAll_800ms_Apr28')
%load('UMN_Recog_elAll_800ms_Apr28')
load('EEG_epoch_only3responses_corr')

%load('UMN_Recog_elRec_800ms_Apr28.mat');
USER_ = 1; EVENT_ = 2; RESP_ = 3;
codeUsers = [1034,1037,1045,1158,1363,1368,1385,2038,6639,7974,7977,7980,1327];
codeUser = 1158;
%--- 
idxElec = [128;42;14;10;43;33;33;8;8;10;39;85;103;70;31;37;43];
%--- 
idx = find(dataY(:,USER_) == codeUser &...
        dataY(:,EVENT_) == 200 &...
        dataY(:,RESP_) == 12); 
    
pltX = squeeze(mean(dataX(idx,idxElec,:),1));   
plotEEG(0, 0, pltX, [],  [], 'EEG-Old')  
    
%     
% for i=idx' 
% 	plotEEG(0, 0, squeeze(mean(dataX(i,idxElec,:),1)), [],  [], 'Old-New')  
% end
% CONCLUSION see class_balan

function plotEEG(smin, react, X, DX,  elecnames, task_fname)    
%smax is not used
    h = figure; 
    hold('on');
    set(gcf, 'Position', get(0, 'Screensize'));
    pbaspect([3,1,1]);
    sampseg = size(X,2);
    plot(1:sampseg, X,'Linewidth', 2);
    if ~isempty(DX) % fill the area of the standard deviation
        t1 = 1:sampseg;
        t2 = [t1, fliplr(t1)];
        x1 = smoothdata(X + DX);
        x2 = smoothdata(X - DX);
        inBetween = [x1, fliplr(x2)];
        fill(t2, inBetween,'cyan','FaceAlpha',0.3, 'EdgeColor', 'none');        
    end
    plot(smin,0,'b.', 'MarkerSize', 24);
    plot(smin,0,'r.','MarkerSize', 24);
    plot([smin+1, smin+react+1],[0 0],'r-', 'Linewidth', 3);
    axis('tight');
    xticks(linspace(1,sampseg,15));
    xticklabels({'-300','-200','-100','0','100','200','300','400','500','600','700','800','900','1000', '1200'});
    xlabel(['Latency, sec $\times$ ', '256', ' Hz'], 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
    ylabel('Amplitude, $\mu$V', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
    set(gca, 'FontSize', 24, 'FontName', 'Times');
    if ~isempty(elecnames)
        %legend(elecnames); %elecnames(idxElec,:));
        legend(num2str(elecnames'));
    end
    %title(['Task: ', task], 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');    
    PATHfigure = '/Users/victor/Desktop/Figures/';
    saveas(h, [PATHfigure, task_fname,'.png'], 'png');
    %saveas(h, [PATHfigure, filename,'.eps'], 'epsc'); % For report
	%saveas(h, [PATHfigure, filename,'.svg'], 'svg');
    hold('off');
    close(h);
    %return
end