%% PLOTS FOR PAPER
close all
%% TASK AND SUBSPACE
figure
C = [.02 .43 .84;
    .96 .2 .2];
CE = [.03 .3 .7;
    .8,.15,.15];

C2 = [.70 .02 .43;
    .05 .76 .99];
CE2 = [.73 .23 .47;
    .1,.8,.95];

subplot(1,2,1)
set(gca,'xticklabel',{[]})
ax = superbar([mean(imprNB), mean(imprQ)],'BarFaceColor', C, 'E', [std(imprNB)./sqrt(length(imprNB)), std(imprQ)./sqrt(length(imprQ))], 'ErrorbarColor', CE);
legend(ax,{'Active','Offline'})
ylim([-0.03 0.05])
ylabel('Improvement')
grid on
set(gca, 'FontName', 'Arial')
set(gca,'FontSize',12)

subplot(1,2,2)
set(gca,'xticklabel',{[]})
ax = superbar([mean([imprNBG; imprQG]), mean([imprNBM; imprQM])],'BarFaceColor', C2, 'E', [std([imprNBG; imprQG])./sqrt(length([imprNBG; imprQG])), std([imprNBM; imprQM])./sqrt(length([imprNBM; imprQM]))], 'ErrorbarColor', CE2);
legend(ax,{'New','Old'})
ylim([-0.03 0.05])
ylabel('Improvement')
grid on
set(gca, 'FontName', 'Arial')
set(gca,'FontSize',12)


figure
subplot(1,2,1)
ax = superbar([mean(imprNBM), mean(imprQM)],'BarFaceColor', C, 'E', [std(imprNBM)./sqrt(length(imprNBM)), std(imprQM)./sqrt(length(imprQM))], 'ErrorbarColor', CE);
legend(ax,{'Active','Offline'})
ylim([-0.04 0.07])
ylabel('Improvement')
grid on
title('Memorization')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize',12)


subplot(1,2,2)
ax = superbar([mean(imprNBG), mean(imprQG)],'BarFaceColor', C, 'E', [std(imprNBG)./sqrt(length(imprNBG)), std(imprQG)./sqrt(length(imprQG))], 'ErrorbarColor', CE);
legend(ax,{'Active','Offline'})
ylim([-0.04 0.07])
ylabel('Improvement')
grid on
title('Generalization')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize',12)


%% Plot Correlation
h = figure('Color', [1,1,1]);
s1 = plot(DataStructure(Qsbj,1), imprQG, 'o','Color', [.8,.15,.15]);
set(s1, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)

s2 = plot(DataStructure(NBsbj,1), imprNBG, '+','Color', [.03 .3 .7]);
set(s2, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)
%%% axis display 
xlabel('Training', 'FontSize', 15)
ylabel('Improvement', 'FontSize', 15)
set(gca, 'FontSize', 15, 'YMinorTick','on','XMinorTick','on')
legend([s1(1) s2(1)],'Offline','Active')
grid on
title('Generalization')


%% Plot Correlation
h = figure('Color', [1,1,1]);
s1 = plot(DataStructure(Qsbj,1), imprQM, 'o','Color', [.8,.15,.15]);
set(s1, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)

s2 = plot(DataStructure(NBsbj,1), imprNBM, '+','Color', [.03 .3 .7]);
set(s2, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)
%%% axis display 
xlabel('Training', 'FontSize', 15)
ylabel('Improvement', 'FontSize', 15)
set(gca, 'FontSize', 15, 'YMinorTick','on','XMinorTick','on')
legend([s1(1) s2(1)],'Offline','Active')
grid on
title('Memorization')


