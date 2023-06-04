clc
clear all
close all
idxElecs = [103    85    71     1   127    19    43    15];
load('/Users/victor/EEGcode/1158/1158_VerbMem_ecnt_af.mat');

X = ecnt_af.data(idxElecs(1),165000 : 166782);
X1 = smoothdata(X, 'Gaussian', 15);
X2 = smoothdata(X, 'Gaussian', 300);
plot(X1, 'b-', 'Linewidth', 2);
hold on
plot(X2, 'r-', 'Linewidth', 2);

xlabel(['Latency, samples  at 256', ' Hz'], 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Amplitude, $\mu$V', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');
axis tight

hold off
