% Plot electrodes and density in 3d and projection
%step6_plot_electrode_hat
load eeg_May23_unfilt.mat

freq = [0.  1. 65.  0.  0.  0. 65.  1.  0. 16. 30.  0.  0.  0. 52.  0.  0.  0. ...
 70. 15.  1. 13.  3.  0. 13.  0.  0.  1. 52.  3. 13.  3. 14. 14.  0. 13. ... 
  1.  0. 52.  0.  1.  0.  1.  0.  0. 16.  0.  0. 16.  0.  0. 66.  0. 17. ...
 13.  0. 52.  0. 19. 14. 17.  0. 52.  0.  0.  0.  2.  1. 34. 15. 52. 16. ... 
  1.  3.  0. 18.  3. 66. 55.  0.  0.  1. 14.  3.  0.  1.  3.  0.  0. 19. ...
 16.  1. 13. 14. 53.  0.  0. 30.  0.  1.  0. 16. 44.  1.  0.  0. 66.  0. ...
  0. 13. 17.  0.  0.  0. 16. 52. 30.  0.  0. 17. 66.  1.  0.  0. 14. 17. ...
  0.  0];

%%
close all
plot3(posElec(:,1),posElec(:,2),posElec(:,3), 'b.', 'Markersize', 24)
text(0.005+posElec(:,1),posElec(:,2),posElec(:,3), nameElec, 'FontName', 'Times')
hold on
set(gca,'XColor', 'none','YColor','none','ZColor','none')

for i = 1:length(freq)
    plot3(posElec(i,1),posElec(i,2),posElec(i,3), 'r.', 'Markersize', 2*(freq(i)+1))
end
%%
close all

f = inline('((z-min(z)) ./ (max(z) - min(z)))');
x1 = 2*(f(posElec(:,1))-0.5);
y1 = 2*(f(posElec(:,2))-0.5);
z = f(posElec(:,3))-0.15;
x = x1 ./ (1-z);
y = y1 ./ (1-z);

plot(x,y, 'b.', 'Markersize', 24)
text(0.03 + x,y, nameElec, 'FontName', 'Times')
hold on
set(gca,'XColor', 'none','YColor','none')
for i = 1:length(freq)
    plot(x(i),y(i), 'r.', 'Markersize', 2*(freq(i)+1))
end
%%
