% Low-pass or hilbert followed by down sampling; plus, ERP related features
clc
clear all
close all
load('EEG_epoch_dat3');
idxElecs = [23 28 43 72 80 81 94 127]; 
sampMin = abs(-76); % from step 1, but in fact, we need task structure
sampMax = 300;%???

%X = squeeze(datX(1,idxElecs,:));
%X = datX(:,:,:);
%plotEEG(sampMin, sampMax, sampMax+1, X, [],  idxElecs, 'task_fname');

down_rate = 20;
matX = smooth_down_flat(datX, down_rate);
plot(matX(4,:));

function matX = smooth_down_flat(eegX, down_rate)
    % down_rate = 10;
    X = smoothdata(...
        smoothdata(...
        smoothdata(eegX, 3),3),3);%,3),3);
        %smoothdata(...
        %smoothdata(...
        %    
    dnX = [];    
    for s = down_rate+1 : down_rate : size(X,3)
        dnX(:,:,end+1) = mean(X(:,:, s-down_rate : s-1), 3);
    end
    [m, p, n] =  size(dnX);
    matX = reshape(dnX, m, p*n, 1);
    matX = squeeze(matX(:, :, 1));
end


%plotEEG(samp Min, sampMax, sampMax+1, X5, [],  idxElecs, 'task_fname2');
% X=X5';

%XXX = squeeze(dnX(112,:,:));
%plotEEG(sampMin, [], [], XXX, [],  idxElecs, 'task_fname2');

%dataX = dnX;
%dataY = datY;
%save('data31','dataX','dataY');

%X = [1 2; 3 4; 5 6];
%reshape(X, 1, numel(X));
%dxX = = reshape(X,6,1)
