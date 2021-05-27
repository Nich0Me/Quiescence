%% Plot RT

%% DATA STRUCTURE LEGEND
% 1 Training accuracy
% 2 Is it over threshold?
% 3 Pretest accuracy
% 4 Is pretest over threshold?
% 5 Posttest accuracy
% 6 Is Posttest over threshold?
% 7 Are the last 50 trials of training over threshold?
% 8 PreTest Old configurations
% 9 PreTest New configurations
% 10 Are Old-Pretest over threshold?
% 11 Are New-Pretest over threshold?
% 12 Posttest Old configurations
% 13 Posttest New configurations
% 14 Are Old-Posttest over threshold?
% 15 Are New-Posttest over threshold?
% 16 NB True Positive 
% 17 NB True Negative
% 18 NB False Negative
% 19 NB False Positive
% 20 NB Weighted Score (FM)
% 21 NB(1) or Quiescence(0)
% 22 Quiescence Score
% 23-24 Mean accuracy Overtime
% 25-26 Mean accuracy Overtime
% 27-28 Mean accuracy overtime
% 29-30 Mean accuracy old conf Overtime PRETEST
% 31-32 Mean accuracy new conf overtime PRETEST
% 33-34 Mean accuracy old conf Overtime POSTTEST
% 35-36 Mean accuracy new conf overtime POSTTEST
% 37 1 if declared
% 38 when they declared, 1 if training, 2 if pretest, 3 if distractor, 4 if posttest
% 39 Age of Participants
% 40 Sex, 1=Male
% 41 Break Length
% 42-44 mean RT training, pretest, posttest
% 45-46 mean RT for old and new stimuli pretest
% 47-48 mean RT for old and new stimuli posttest


figure
subplot(1,3,1)
bar([mean(DataStructure(NBsbj,42)),mean(DataStructure(Qsbj,42))])
hold on
errorbar([mean(DataStructure(NBsbj,42)),mean(DataStructure(Qsbj,42))],[std(DataStructure(NBsbj,42))/sqrt(sum(NBsbj)),std(DataStructure(Qsbj,42))/sqrt(sum(Qsbj))])
title('Training')
set(gca,'xticklabel', {'Active', 'Offline'})
set(gca,'fontsize', 14);

subplot(1,3,2)
bar([mean(DataStructure(NBsbj,43)),mean(DataStructure(Qsbj,43))])
hold on
errorbar([mean(DataStructure(NBsbj,43)),mean(DataStructure(Qsbj,43))],[std(DataStructure(NBsbj,43))/sqrt(sum(NBsbj)),std(DataStructure(Qsbj,43))/sqrt(sum(Qsbj))])
title('PreTest')
set(gca,'xticklabel', {'Active', 'Offline'})
set(gca,'fontsize', 14);

subplot(1,3,3)
bar([mean(DataStructure(NBsbj,44)),mean(DataStructure(Qsbj,44))])
hold on
errorbar([mean(DataStructure(NBsbj,44)),mean(DataStructure(Qsbj,44))],[std(DataStructure(NBsbj,44))/sqrt(sum(NBsbj)),std(DataStructure(Qsbj,44))/sqrt(sum(Qsbj))])
title('PostTest')
set(gca,'xticklabel', {'Active', 'Offline'})
set(gca,'fontsize', 14);

sgtitle('Reaction Time')

%% Quiescience Old/New Pretest/Posttest
figure
subplot(1,2,1)
bar([mean(DataStructure(Qsbj,45)),mean(DataStructure(Qsbj,46))])
hold on
errorbar([mean(DataStructure(Qsbj,45)),mean(DataStructure(Qsbj,46))],[std(DataStructure(Qsbj,45))/sqrt(sum(Qsbj)),std(DataStructure(Qsbj,46))/sqrt(sum(Qsbj))])
title('PreTest')
set(gca,'xticklabel', {'Old', 'New'})
set(gca,'fontsize', 14);

subplot(1,2,2)
bar([mean(DataStructure(Qsbj,47)),mean(DataStructure(Qsbj,48))])
hold on
errorbar([mean(DataStructure(Qsbj,47)),mean(DataStructure(Qsbj,48))],[std(DataStructure(Qsbj,47))/sqrt(sum(Qsbj)),std(DataStructure(Qsbj,48))/sqrt(sum(Qsbj))])
title('PostTest')
set(gca,'xticklabel', {'Old', 'New'})
set(gca,'fontsize', 14);

sgtitle('Offline')

figure
subplot(1,2,1)
bar([mean(DataStructure(NBsbj,45)),mean(DataStructure(NBsbj,46))])
hold on
errorbar([mean(DataStructure(NBsbj,45)),mean(DataStructure(NBsbj,46))],[std(DataStructure(NBsbj,45))/sqrt(sum(NBsbj)),std(DataStructure(NBsbj,46))/sqrt(sum(NBsbj))])
title('PreTest')
set(gca,'xticklabel', {'Old', 'New'})
set(gca,'fontsize', 14);

subplot(1,2,2)
bar([mean(DataStructure(NBsbj,47)),mean(DataStructure(NBsbj,48))])
hold on
errorbar([mean(DataStructure(NBsbj,47)),mean(DataStructure(NBsbj,48))],[std(DataStructure(NBsbj,47))/sqrt(sum(NBsbj)),std(DataStructure(NBsbj,48))/sqrt(sum(NBsbj))])
title('PostTest')
set(gca,'xticklabel', {'Old', 'New'})
set(gca,'fontsize', 14);

sgtitle('Active')

%% CORRELATIONs
% 1 Training accuracy
% 3 Pretest accuracy
% 5 Posttest accuracy

% 8 PreTest Old configurations
% 9 PreTest New configurations
% 12 Posttest Old configurations
% 13 Posttest New configurations

% 42-44 mean RT training, pretest, posttest
% 45-46 mean RT for old and new stimuli pretest
% 47-48 mean RT for old and new stimuli posttest

% Accuracy Post-Test and RT
figure
subplot(1,2,1)
plot(DataStructure(Qsbj,13),DataStructure(Qsbj,48),'o')
xlabel('Accuracy')
ylabel('RT')
lsline
hold on
plot(DataStructure(Qsbj,12),DataStructure(Qsbj,47),'o')
lsline
legend('Generalization', '','Memorization')
title('Quiescence')

subplot(1,2,2)
plot(DataStructure(NBsbj,13),DataStructure(NBsbj,48),'o')
xlabel('Accuracy')
ylabel('RT')
lsline
hold on
plot(DataStructure(NBsbj,12),DataStructure(NBsbj,47),'o')
lsline
legend('Generalization', '','Memorization')
title('NBack')
sgtitle(' Post-Test')

% Accuracy Pre-Test and RT
figure
subplot(1,2,1)
plot(DataStructure(Qsbj,9),DataStructure(Qsbj,46),'o')
xlabel('Accuracy')
ylabel('RT')
lsline
hold on
plot(DataStructure(Qsbj,8),DataStructure(Qsbj,45),'o')
lsline
legend('Generalization', '','Memorization')
title('Quiescence')

subplot(1,2,2)
plot(DataStructure(NBsbj,9),DataStructure(NBsbj,46),'o')
xlabel('Accuracy')
ylabel('RT')
lsline
hold on
plot(DataStructure(NBsbj,8),DataStructure(NBsbj,45),'o')
lsline
legend('Generalization', '','Memorization')
title('NBack')
sgtitle(' Pre-Test')

% Improvement and RT in Post-Test
figure
subplot(1,2,1)
plot(imprQG,DataStructure(Qsbj,48),'o')
xlabel('Improvement')
ylabel('RT')
lsline
hold on
plot(imprQM,DataStructure(Qsbj,47),'o')
lsline
legend('Generalization', '','Memorization')
title('Quiescence')

subplot(1,2,2)
plot(imprNBG,DataStructure(NBsbj,48),'o')
xlabel('Improvement')
ylabel('RT')
lsline
hold on
plot(imprNBM,DataStructure(NBsbj,47),'o')
lsline
legend('Generalization', '','Memorization')
title('2back')
sgtitle('Improvement in Post Test')

% Improvement and RT in Pre-Test
figure
subplot(1,2,1)
plot(imprQG,DataStructure(Qsbj,46),'o')
xlabel('Improvement')
ylabel('RT')
lsline
hold on
plot(imprQM,DataStructure(Qsbj,45),'o')
lsline
legend('Generalization', '','Memorization')
title('Quiescence')

subplot(1,2,2)
plot(imprNBG,DataStructure(NBsbj,46),'o')
xlabel('Improvement')
ylabel('RT')
lsline
hold on
plot(imprNBM,DataStructure(NBsbj,45),'o')
lsline
legend('Generalization', '','Memorization')
title('2back')
sgtitle('Improvement and RT in PreTest')

% Improvement and difference in RT
figure
subplot(1,2,1)
plot(imprQG,DataStructure(Qsbj,48)-DataStructure(Qsbj,46),'o')
xlabel('Improvement')
ylabel('RT Post-Pre')
lsline
hold on
plot(imprQM,DataStructure(Qsbj,47)-DataStructure(Qsbj,45),'o')
lsline
legend('Generalization', '','Memorization')
title('Quiescence')

subplot(1,2,2)
plot(imprNBG,DataStructure(NBsbj,48)-DataStructure(NBsbj,46),'o')
xlabel('Improvement')
ylabel('RT Post-Pre')
lsline
hold on
plot(imprNBM,DataStructure(NBsbj,47)-DataStructure(NBsbj,46),'o')
lsline
legend('Generalization', '','Memorization')
title('2back')
sgtitle('Improvement')