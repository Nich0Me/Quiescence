
clear all
close all
load imp_data

% Bootstrap samples
bootsamps=10000;

% K-Nearest neighbour smoothing
K=20;
xx=[0.4:0.01:0.82]';

% Active Wake
x=x1;
y=y1G;

keep=find(isnan(y)==0);
x=x(keep);
y=y(keep);

[my,y05,y95] = boot_knn_smooth(x,y,xx,K,bootsamps);

subplot(1,2,1);
xconf = [xx' xx(end:-1:1)'];
yconf = [y95 y05(end:-1:1)];
p = fill(xconf,yconf,'blue');
p.FaceColor = [0.8 0.8 1.0];
p.EdgeColor = 'none';
grid on
hold on
plot(xx,my,'b');
plot(x,y,'b+');
ylim([-0.2 0.2]);
xlabel('Training Accuracy');
ylabel('Generalization Improvement');
title('Active Wake');

% Offline Wake
x=x2;
y=y2G;

keep=find(isnan(y)==0);
x=x(keep);
y=y(keep);

[my,y05,y95] = boot_knn_smooth(x,y,xx,K,bootsamps);

subplot(1,2,2);
xconf = [xx' xx(end:-1:1)'];
yconf = [y95 y05(end:-1:1)];
p = fill(xconf,yconf,'red');
p.FaceColor = [1 0.8 0.8];
p.EdgeColor = 'none';
grid on
hold on
plot(xx,my,'r');
plot(x,y,'ro');
ylim([-0.2 0.2]);
xlabel('Training Accuracy');
ylabel('Generalization Improvement');
title('Offline Wake');
