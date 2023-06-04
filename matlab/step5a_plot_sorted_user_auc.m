%% Plot fot the Slides on Friday May 6th 
% AUCs for tree models, each user from the experient 
One = [0.99	0.98	0.97	0.9	0.89	0.84	0.83	0.78	0.74	0.69	0.57	0.52	0.5;
0.99	0.98	0.97	0.9	0.89	0.9	0.84	0.77	0.74	0.7	0.59	0.5	0.51;
0.99	0.98	0.97	0.92	0.9	0.92	0.85	0.81	0.78	0.67	0.57	0.49	0.53];

All = [0.73	0.66	0.51	0.46	0.56	0.49	0.61	0.57	0.6	0.52	0.71	0.66	0.54
0.74	0.67	0.51	0.5	0.57	0.47	0.6	0.55	0.7	0.5	0.73	0.69	0.56
0.68	0.66	0.61	0.52	0.42	0.49	0.56	0.56	0.75	0.55	0.61	0.64	0.47];

leg = {'(a) Gaussian Process',...
'(a) Logistic Regression',...
'(a) Naive Bayes',...
'(b) Gaussian Process',...
'(b) Logistic Regression',...
'(b) Naive Bayes'};

close all
h = figure; 
hold('on');

%set(gcf, 'Position', get(0, 'Screensize'));
pbaspect([3,1,1]);
plot(One', '-o', 'Linewidth', 2, 'MarkerSize', 10, 'MarkerFaceColor','r');
hold on
plot(All', '-o', 'Linewidth', 2, 'MarkerSize', 10, 'MarkerFaceColor','b');
legend(leg)
axis('tight');
xlala = {'1158','1045','7980','1037','6639','1363','7977','7974','2038','1327','1368','1385','1034'};
xticks(1:13);
xticklabels(xlala);%{'0','100','200','300','400','500','600','700','800'});
xlabel('Users, ordered by decreasing of the Gaussian Process classification model accuracy');% Latency, msec (256 Hz)', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Accuracy')%[Xaxis, ', $\mu$V'], 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');

