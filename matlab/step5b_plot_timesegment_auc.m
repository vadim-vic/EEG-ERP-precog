% The experient on the optimal time to find ERP segment 
%% Plot for May 9th 
[win, start, auc, acc, samplerate] = load_data();

%% Plot in 2D
close all
figure
hold on

cellLegend = {};
for w = unique(win)'
    idx = win == w;
    
    plot(start(idx), auc(idx), '-o', 'Linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','b'); 
    cellLegend{end+1} = [num2str(round(w/256,2)), ' ms'];
end
legend(cellLegend);
xlabel('Time segment start, ms', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
ylabel('AUC', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');
axis tight
%% Plot in 3D
x = win/256;
y = start/256;
v = auc;
[xq,yq] = meshgrid(...
    linspace(min(x),max(x),10),...
    linspace(min(y),max(y),10));

F.Method = 'natural';
F = scatteredInterpolant(x,y,v);
vq = F(xq,yq); 
close all
figure
hold on
plot3(x,y,v,'mo', 'MarkerSize', 8, 'MarkerFaceColor','m');
xlabel('Length, ms', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Start, ms', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
zlabel('AUC', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');
mesh(xq,yq,vq);
s = surf(xq,yq,vq,'FaceAlpha',0.5);
%title('Natural Neighbor')
%legend('Sample points','Interpolated surface','Location','NorthWest')
% KEEP THER SURFACE LOW OR DELETE THIS PART OF SURFACE!!!
plot3(180/256, 370/256, 0.6,'bo', 'MarkerSize', 12, 'MarkerFaceColor','b');
%% from the experiment 
function [win, start, auc, acc, samplerate] = load_data()
    samplerate = 256; %Hz
    data = [%0	1	2	3	4
    32	0	32	0.6708	0.613636363636364
    32	37	69	0.7909	0.75
    32	74	106	0.6646	0.636363636363636
    32	111	143	0.6211	0.613636363636364
    32	148	180	0.6977	0.636363636363636
    32	185	217	0.6894	0.613636363636364
    32	222	254	0.7723	0.681818181818182
    32	259	291	0.6729	0.613636363636364
    32	296	328	0.7619	0.727272727272727
    32	333	365	0.7412	0.704545454545455
    32	370	402	0.766	0.704545454545455
    52	0	52	0.7081	0.659090909090909
    52	35	87	0.8054	0.75
    52	70	122	0.7474	0.681818181818182
    52	105	157	0.7702	0.727272727272727
    52	140	192	0.8219	0.704545454545455
    52	175	227	0.8075	0.681818181818182
    52	210	262	0.7619	0.704545454545455
    52	245	297	0.735	0.590909090909091
    52	280	332	0.7826	0.772727272727273
    52	315	367	0.735	0.659090909090909
    52	350	402	0.6584	0.568181818181818
    72	0	72	0.7226	0.659090909090909
    72	33	105	0.8178	0.704545454545455
    72	66	138	0.6025	0.545454545454545
    72	99	171	0.766	0.75
    72	132	204	0.8509	0.772727272727273
    72	165	237	0.8385	0.727272727272727
    72	198	270	0.7805	0.636363636363636
    72	231	303	0.8385	0.75
    72	264	336	0.7743	0.704545454545455
    72	297	369	0.6894	0.659090909090909
    72	330	402	0.6791	0.613636363636364
    92	0	92	0.7743	0.681818181818182
    92	31	123	0.7578	0.704545454545455
    92	62	154	0.6729	0.590909090909091
    92	93	185	0.8199	0.704545454545455
    92	124	216	0.8178	0.75
    92	155	247	0.8282	0.727272727272727
    92	186	278	0.8613	0.727272727272727
    92	217	309	0.8012	0.75
    92	248	340	0.8054	0.772727272727273
    92	279	371	0.6522	0.568181818181818
    92	310	402	0.7019	0.681818181818182
    112	0	112	0.7557	0.704545454545455
    112	29	141	0.7723	0.704545454545455
    112	58	170	0.7101	0.568181818181818
    112	87	199	0.8841	0.795454545454545
    112	116	228	0.7992	0.75
    112	145	257	0.8261	0.727272727272727
    112	174	286	0.8778	0.818181818181818
    112	203	315	0.7743	0.659090909090909
    112	232	344	0.7557	0.659090909090909
    112	261	373	0.6894	0.590909090909091
    112	290	402	0.735	0.681818181818182
    132	0	132	0.766	0.636363636363636
    132	27	159	0.8137	0.681818181818182
    132	54	186	0.7329	0.568181818181818
    132	81	213	0.8199	0.704545454545455
    132	108	240	0.8592	0.772727272727273
    132	135	267	0.8696	0.772727272727273
    132	162	294	0.795	0.75
    132	189	321	0.8427	0.75
    132	216	348	0.7619	0.75
    132	243	375	0.6563	0.522727272727273
    132	270	402	0.7764	0.704545454545455
    152	0	152	0.795	0.659090909090909
    152	25	177	0.7371	0.659090909090909
    152	50	202	0.7267	0.659090909090909
    152	75	227	0.766	0.636363636363636
    152	100	252	0.8509	0.772727272727273
    152	125	277	0.8344	0.75
    152	150	302	0.764	0.704545454545455
    152	175	327	0.7888	0.681818181818182
    152	200	352	0.8033	0.75
    152	225	377	0.6501	0.590909090909091
    152	250	402	0.7474	0.659090909090909
    172	0	172	0.7847	0.659090909090909
    172	23	195	0.8116	0.772727272727273
    172	46	218	0.735	0.704545454545455
    172	69	241	0.8075	0.704545454545455
    172	92	264	0.8075	0.681818181818182
    172	115	287	0.8571	0.704545454545455
    172	138	310	0.795	0.704545454545455
    172	161	333	0.7743	0.659090909090909
    172	184	356	0.8075	0.727272727272727
    172	207	379	0.6729	0.568181818181818
    172	230	402	0.7412	0.636363636363636
    %180 370 370 0.65     0.65
    ];

    win     = data(:,1);
    start   = data(:,2);
    auc     = data(:,4);
    acc     = data(:,5);
end

%% Just one sliding window time-segment
x = [0	15	30	45	60	75	90	105	120	135	150	165	180	195	210	225	240	255	270];
y = [7.681	8.012	8.116	7.329	7.412	7.93	8.53	8.406	8.613	8.903	7.847	7.888	8.675	8.427	7.826	7.019	6.957	6.977	7.826];


x = [0	15	30	45	60	75	90	105	120	135	150	165	180	195	210	225	240	255	270];
%128	143	158	173	188	203	218	233	248	263	278	293	308	323	338	353	368	383	398
y = [0.7681	0.8012	0.8116	0.7329	0.7412	0.793	0.853	0.8406	0.8613	0.8903	0.7847	0.7888	0.8675	0.8427	0.7826	0.7019	0.6957	0.6977	0.7826];
z = [0.518018018	0.5225225225	0.5225225225	0.518018018	0.5225225225	0.527027027	0.527027027	0.5315315315	0.5315315315	0.5315315315	0.5202702703	0.5292792793	0.5337837838	0.5247747748	0.5247747748	0.5112612613	0.5157657658	0.5135135135	0.5247747748																		];

xx  = x/256;																		
						
h = figure; 
hold('on');
%set(gcf, 'Position', get(0, 'Screensize'));
pbaspect([3,1,1]);

plot(xx,z,'Linewidth', 2);
axis('tight');
%xticks(linspace(1,204,9));
%xticklabels({'0','100','200','300','400','500','600','700','800'});
xlabel('Latency, msec (256 Hz)', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Average AUC', 'FontSize', 24, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');
hold('off')																		
																		
							