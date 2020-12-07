clear all
close all

path = './';
TotSub = 100;
threshold = 0.90;
for sbj = 1:TotSub
    
    load([path,'sbj',num2str(sbj),'/sbj',num2str(sbj)])
    
    %% 1 & 2 -> Mean Training - Threshold Training
    TrAcc = training.Feedback(training.miss==0);
    threshold1 = binoinv(threshold,length(TrAcc),0.5)/length(TrAcc);
    
    DataStructure(sbj,1) = mean(TrAcc);
    DataStructure(sbj,2) = mean(TrAcc) > threshold1;
    
    %% 3 & 4 -> Mean PreTest - Threshold PreTest
    T1Acc = pretest.Correct(pretest.miss==0);
    threshold2 = binoinv(threshold,length(T1Acc),0.5)/length(T1Acc);
    
    DataStructure(sbj,3) = mean(T1Acc);
    DataStructure(sbj,4) = mean(T1Acc) > threshold2;
    
    %% 5 & 6 -> Mean PreTest - Threshold PreTest
    T2Acc = posttest.Correct(posttest.miss==0);
    threshold3 = binoinv(threshold,length(T2Acc),0.5)/length(T2Acc);
    
    DataStructure(sbj,5) = mean(T2Acc);
    DataStructure(sbj,6) = mean(T2Acc) > threshold3;
    
    %% 7 -> Threshold Last 50 Trials Training
    threshold4 = binoinv(threshold,60,0.5)/50;
    if length(TrAcc)-59 <= 0
        DataStructure(sbj,7) = NaN;
    else
        DataStructure(sbj,7) = mean(TrAcc(end-59: end)) > threshold4;
    end
    %% 8 & 9 -> PreTest New / Old Configurations
    OldConf = unique(training.conf);
    tempIdx1 = find(sum(pretest.conf' == OldConf,2)' & pretest.miss==0);
    
    OldAcc = mean(pretest.Correct(tempIdx1));
    DataStructure(sbj,8) = OldAcc;
    
    temp = unique(pretest.conf);
    NewConf = temp(~ismember(unique(temp),unique(training.conf)));
    tempIdx2 = find(sum(pretest.conf' == NewConf,2)' & pretest.miss==0);
    
    NewAcc = mean(pretest.Correct(tempIdx2));
    DataStructure(sbj,9) = NewAcc;
    
    %% 10 & 11 -> Threshold old and new conf
    threshold5 = binoinv(threshold,length(pretest.Correct(tempIdx1)),0.5)/length(pretest.Correct(tempIdx1));
    DataStructure(sbj,10) = OldAcc > threshold5;
    
    threshold6 = binoinv(threshold,length(pretest.Correct(tempIdx2)),0.5)/length(pretest.Correct(tempIdx2));
    DataStructure(sbj,11) = NewAcc > threshold6;
    
    %% 12 & 13 -> PostTest New / Old Configurations
    OldConf = unique(training.conf);
    tempIdx1 = find(sum(posttest.conf' == OldConf,2)' & posttest.miss==0);
    
    OldAcc = mean(posttest.Correct(tempIdx1));
    DataStructure(sbj,12) = OldAcc;
    
    temp = unique(posttest.conf);
    NewConf = temp(~ismember(unique(temp),unique(training.conf)));
    tempIdx2 = find(sum(posttest.conf' == NewConf,2)' & posttest.miss==0);
    
    NewAcc = mean(posttest.Correct(tempIdx2));
    DataStructure(sbj,13) = NewAcc;
    
    %% 14 & 15 -> Threshold old and new conf
    threshold5 = binoinv(threshold,length(posttest.Correct(tempIdx1)),0.5)/length(posttest.Correct(tempIdx1));
    DataStructure(sbj,14) = OldAcc > threshold5;
    
    threshold6 = binoinv(threshold,length(posttest.Correct(tempIdx2)),0.5)/length(posttest.Correct(tempIdx2));
    DataStructure(sbj,15) = NewAcc > threshold6;
    
    %% 16/18 -> TruePositive / False Negative
    temp = nback.block1.letter(1:end-2);
    idx1 = find(temp == nback.block1.letter(3:end))+2;
    
    temp = nback.block2.letter(1:end-2);
    idx2 = find(temp == nback.block2.letter(3:end))+2;
    
    temp = nback.block3.letter(1:end-2);
    idx3 = find(temp == nback.block3.letter(3:end))+2;
    
    temp = nback.block4.letter(1:end-2);
    idx4 = find(temp == nback.block4.letter(3:end))+2;
    
    TruePositive = (sum(nback.block1.correct(idx1))+sum(nback.block2.correct(idx2))+sum(nback.block3.correct(idx3))+sum(nback.block4.correct(idx4)))/(length(idx1)+length(idx2)+length(idx3)+length(idx4));
    TP = (sum(nback.block1.correct(idx1))+sum(nback.block2.correct(idx2))+sum(nback.block3.correct(idx3))+sum(nback.block4.correct(idx4)));
    DataStructure(sbj,16) = TruePositive;
    
    FalseNegative = (sum(nback.block1.button(idx1)==0)+sum(nback.block2.button(idx2)==0)+sum(nback.block3.button(idx3)==0)+sum(nback.block4.button(idx4)==0))/(length(idx1)+length(idx2)+length(idx3)+length(idx4));
    DataStructure(sbj,18) = FalseNegative;
    
    %% 17/19 -> True Negative / FalsePositive
    temp = nback.block1.letter(1:end-2);
    idx1 = find(temp ~= nback.block1.letter(3:end))+2;
    
    temp = nback.block2.letter(1:end-2);
    idx2 = find(temp ~= nback.block2.letter(3:end))+2;
    
    temp = nback.block3.letter(1:end-2);
    idx3 = find(temp ~= nback.block3.letter(3:end))+2;
    
    temp = nback.block4.letter(1:end-2);
    idx4 = find(temp ~= nback.block4.letter(3:end))+2;
    
    TrueNegative = (sum(nback.block1.correct(idx1))+sum(nback.block2.correct(idx2))+sum(nback.block3.correct(idx3))+sum(nback.block4.correct(idx4)))/(length(idx1)+length(idx2)+length(idx3)+length(idx4));
    DataStructure(sbj,17) = TrueNegative;
    
    FalsePositive = (sum(nback.block1.button(idx1)==1)+sum(nback.block2.button(idx2)==1)+sum(nback.block3.button(idx3)==1)+sum(nback.block4.button(idx4)==1))/(length(idx1)+length(idx2)+length(idx3)+length(idx4));
    FP = (sum(nback.block1.button(idx1)==1)+sum(nback.block2.button(idx2)==1)+sum(nback.block3.button(idx3)==1)+sum(nback.block4.button(idx4)==1));
    DataStructure(sbj,19) = FalsePositive;
    
    %% 20 -> FM SCORE
    PPV = TP/(TP+FP);
    FM = sqrt(PPV*TruePositive);
    DataStructure(sbj,20) = FM;
    
    %% 21 NB or Quiescence
    if sbj > 40 && sbj < 91
        DataStructure(sbj, 21) = 0;
    else
        DataStructure(sbj, 21) = 1;
    end
    
    %% 22 Quiescence Score
    if sbj > 40 && sbj < 91
        DataStructure(sbj, 22) = Quiescence;
    end
    
    %% 23-24 Mean accuracy per block OverTime
    TrAcc = training.Feedback(training.miss==0);
    TrialN = training.trial(training.miss==0);
    
    Temp1 = find(TrialN <= 60);
    Temp2 = find(TrialN > 60);
    
    DataStructure(sbj,23) = mean(TrAcc(Temp1));
    DataStructure(sbj,24) = mean(TrAcc(Temp2));
    
    %% 25-26 Mean accuracy PreTest OverTime
    T1Acc = pretest.Correct(pretest.miss==0);
    TrialN = pretest.trial(pretest.miss==0);
    
    Temp1 = find(TrialN <= 60);
    Temp2 = find(TrialN > 60);
    
    DataStructure(sbj,25) = mean(T1Acc(Temp1));
    DataStructure(sbj,26) = mean(T1Acc(Temp2));
    
    %% 29-32 Pretest Old And New Configurations overtime
    OldConf = unique(training.conf);
    TrialN = pretest.trial;
    tempIdx1 = find(sum(pretest.conf' == OldConf,2)' & pretest.miss==0 & TrialN <= 60 & pretest.miss==0);
    tempIdx2 = find(sum(pretest.conf' == OldConf,2)' & pretest.miss==0 & TrialN > 60 & pretest.miss==0);
    
    DataStructure(sbj,29) = mean(pretest.Correct(tempIdx1));
    DataStructure(sbj,30) = mean(pretest.Correct(tempIdx2));
    
    temp = unique(pretest.conf);
    NewConf = temp(~ismember(unique(temp),unique(training.conf)));
    tempIdx1 = find(sum(pretest.conf' == NewConf,2)' & pretest.miss==0 & TrialN <= 60 & pretest.miss==0);
    tempIdx2 = find(sum(pretest.conf' == NewConf,2)' & pretest.miss==0 & TrialN > 60 & pretest.miss==0);
    
    DataStructure(sbj,31) = mean(pretest.Correct(tempIdx1));
    DataStructure(sbj,32) = mean(pretest.Correct(tempIdx2));
    
    %% 27-28 Mean accuracy PostTest Overtime
    T2Acc = posttest.Correct(posttest.miss==0);
    TrialN = posttest.trial(posttest.miss==0);
    
    Temp1 = find(TrialN <= 50);
    Temp2 = find(TrialN > 60);
    
    DataStructure(sbj,27) = mean(T2Acc(Temp1));
    DataStructure(sbj,28) = mean(T2Acc(Temp2));
    
    %% 33-34 Pretest Old And New Configurations overtime
    TrialN = posttest.trial;
    OldConf = unique(training.conf);
    tempIdx1 = find(sum(posttest.conf' == OldConf,2)' & posttest.miss==0 & TrialN <= 60 & posttest.miss==0);
    tempIdx2 = find(sum(posttest.conf' == OldConf,2)' & posttest.miss==0 & TrialN > 60 & posttest.miss==0);
    
    DataStructure(sbj,33) = mean(posttest.Correct(tempIdx1));
    DataStructure(sbj,34) = mean(posttest.Correct(tempIdx2));
    
    temp = unique(posttest.conf);
    NewConf = temp(~ismember(unique(temp),unique(training.conf)));
    tempIdx1 = find(sum(posttest.conf' == NewConf,2)' & posttest.miss==0 & TrialN <= 60 & posttest.miss==0);
    tempIdx2 = find(sum(posttest.conf' == NewConf,2)' & posttest.miss==0 & TrialN > 60 & posttest.miss==0);
    
    DataStructure(sbj,35) = mean(posttest.Correct(tempIdx1));
    DataStructure(sbj,36) = mean(posttest.Correct(tempIdx2));
    
end

dec_array = get_sbj_table();
DataStructure(:,[37,38]) = dec_array;
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
%% Select subject
sbjIdx = (sum(DataStructure(:,[2,4,6,7,10,11,14,15])') > 0  | (DataStructure(:,20) > 0.65)') & (DataStructure(:,37) == 0)';
sbjIdx([19,23, 40]) = 0;

%% GENERAL Plot accuracy training - pretest - posttest
figure
subplot(1,3,1)
bar(mean(DataStructure(sbjIdx,1)))
hold on
errorbar(mean(DataStructure(sbjIdx,1)), std(DataStructure(sbjIdx,1))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('Accuracy Training')

subplot(1,3,2)
bar(mean(DataStructure(sbjIdx,3)))
hold on
errorbar(mean(DataStructure(sbjIdx,3)), std(DataStructure(sbjIdx,3))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('Accuracy PreTest')

subplot(1,3,3)
bar(mean(DataStructure(sbjIdx,5)))
hold on
errorbar(mean(DataStructure(sbjIdx,5)), std(DataStructure(sbjIdx,5))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('Accuracy PostTest')

%% GENERAL Plot PreTest old vs New Configurations
figure
subplot(1,2,1)
bar(mean(DataStructure(sbjIdx,8)))
hold on
errorbar(mean(DataStructure(sbjIdx,8)), std(DataStructure(sbjIdx,8))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('PreTest Old Conf')

subplot(1,2,2)
bar(mean(DataStructure(sbjIdx,9)))
hold on
errorbar(mean(DataStructure(sbjIdx,9)), std(DataStructure(sbjIdx,9))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('PreTest New Conf')

%% GENERAL Plot PostTest old vs new configurations
figure
subplot(1,2,1)
bar(mean(DataStructure(sbjIdx,12)))
hold on
errorbar(mean(DataStructure(sbjIdx,12)), std(DataStructure(sbjIdx,12))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('PostTest Old Conf')

subplot(1,2,2)
bar(mean(DataStructure(sbjIdx,13)))
hold on
errorbar(mean(DataStructure(sbjIdx,13)), std(DataStructure(sbjIdx,13))./sqrt(sum(sbjIdx)), 'k')
ylim([0.4, 0.8])
grid on
title('PostTest New Conf')

%% Correlation improvement and NBack Score
NBsbj = sbjIdx' & DataStructure(:,21) == 1;
NBsbjImp = sbjIdx' & DataStructure(:,21) == 1 & (DataStructure(:,5)-DataStructure(:,3)) > 0;
figure

imprNB = DataStructure(NBsbj,5)-DataStructure(NBsbj,3);
plot(DataStructure(NBsbj,20), imprNB,'o')
ylabel('Improvement')
xlabel('FM score')
lsline

%% Correlation between improvement old and new and Nback Score
figure
subplot(1,2,1)
imprNBM = DataStructure(NBsbj,12)-DataStructure(NBsbj,8);
plot(DataStructure(NBsbj,20), imprNBM,'o')
ylabel('Improvement Memorization')
xlabel('FM score')
lsline

subplot(1,2,2)
imprNBG = DataStructure(NBsbj,13)-DataStructure(NBsbj,9);
plot(DataStructure(NBsbj,20), imprNBG,'o')
ylabel('Improvement Generalization')
xlabel('FM score')
lsline

%% N-BACK PreTest old vs New Configurations
figure
subplot(1,2,1)
bar(mean(DataStructure(NBsbj,8)))
hold on
errorbar(mean(DataStructure(NBsbj,8)), std(DataStructure(NBsbj,8))./sqrt(sum(NBsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('NBACK PreTest Old Conf')

subplot(1,2,2)
bar(mean(DataStructure(NBsbj,9)))
hold on
errorbar(mean(DataStructure(NBsbj,9)), std(DataStructure(NBsbj,9))./sqrt(sum(NBsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('NBACK PreTest New Conf')

%% N-BACK Plot PostTest old vs new configurations
figure
subplot(1,2,1)
bar(mean(DataStructure(NBsbj,12)))
hold on
errorbar(mean(DataStructure(NBsbj,12)), std(DataStructure(NBsbj,12))./sqrt(sum(NBsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('NBACK PostTest Old Conf')

subplot(1,2,2)
bar(mean(DataStructure(NBsbj,13)))
hold on
errorbar(mean(DataStructure(NBsbj,13)), std(DataStructure(NBsbj,13))./sqrt(sum(NBsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('NBACK PostTest New Conf')

%% QUIESCENCE
Qsbj = sbjIdx' & DataStructure(:,21) == 0;

QsbjImp = sbjIdx' & DataStructure(:,21) == 0 & (DataStructure(:,5)-DataStructure(:,3)) > 0;
%% Correlation improvement and Quiescence Score
figure

imprQ = DataStructure(Qsbj,5)-DataStructure(Qsbj,3);
plot(DataStructure(Qsbj,22), imprQ,'o')
ylabel('Improvement')
xlabel('Quiescence Score')
lsline


%% Correlation between improvement old and new and Nback Score
figure
subplot(1,2,1)
imprQM = DataStructure(Qsbj,12)-DataStructure(Qsbj,8);
plot(DataStructure(Qsbj,22), imprQM,'o')
ylabel('Improvement Memorization')
xlabel('Quiescence Score')
lsline

subplot(1,2,2)
imprQG = DataStructure(Qsbj,13)-DataStructure(Qsbj,9);
plot(DataStructure(Qsbj,22), imprQG,'o')
ylabel('Improvement Generalization')
xlabel('Quiescence Score')
lsline

%% QUIESCENCE PreTest old vs New Configurations
figure
subplot(1,2,1)
bar(mean(DataStructure(Qsbj,8)))
hold on
errorbar(mean(DataStructure(Qsbj,8)), std(DataStructure(Qsbj,8))./sqrt(sum(Qsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('QUIESCENCE PreTest Old Conf')

subplot(1,2,2)
bar(mean(DataStructure(Qsbj,9)))
hold on
errorbar(mean(DataStructure(Qsbj,9)), std(DataStructure(Qsbj,9))./sqrt(sum(Qsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('QUIESCENCE PreTest New Conf')
%% QUIESCENCE Plot PostTest old vs new configurations
figure
subplot(1,2,1)
bar(mean(DataStructure(Qsbj,12)))
hold on
errorbar(mean(DataStructure(Qsbj,12)), std(DataStructure(Qsbj,12))./sqrt(sum(Qsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('QUIESCENCE PostTest Old Conf')

subplot(1,2,2)
bar(mean(DataStructure(Qsbj,13)))
hold on
errorbar(mean(DataStructure(Qsbj,13)), std(DataStructure(Qsbj,13))./sqrt(sum(Qsbj)), 'k')
ylim([0.4, 0.8])
grid on
title('QUIESCENCE PostTest New Conf')

%% IMPROVEMENTS COMPARISONS
figure
bar([mean(imprNB), mean(imprQ)])
hold on
errorbar([mean(imprNB), mean(imprQ)], [std(imprNB)./sqrt(length(imprNB)), std(imprQ)./sqrt(length(imprQ))], 'k')
ylim([-0.05, 0.05])
set(gca,'xticklabel', {'NB', 'Quie'})
title('Improvement')

figure
subplot(1,2,1)
bar([mean(imprNBM), mean(imprQM)])
hold on
errorbar([mean(imprNBM), mean(imprQM)], [std(imprNBM)./sqrt(length(imprNBM)), std(imprQM)./sqrt(length(imprQM))], 'k')
ylim([-0.05, 0.05])
set(gca,'xticklabel', {'NB', 'Quie'})
title('Improvement in Memorization')

subplot(1,2,2)
bar([mean(imprNBG), mean(imprQG)])
hold on
errorbar([mean(imprNBG), mean(imprQG)], [std(imprNBG)./sqrt(length(imprNBG)), std(imprQG)./sqrt(length(imprQG))], 'k')
ylim([-0.05, 0.05])
set(gca,'xticklabel', {'NB', 'Quie'})
title('Improvement in Generalization')

%% Memorization and Quiescence overtime
% 23-24 Mean accuracy per block
% 25-26 Mean accuracy PreTest
% 27-28 Mean accuracy PreTest
figure
subplot(1,3,1)
errorbar(mean(DataStructure(Qsbj,[23:24])), std(DataStructure(Qsbj,[23:24]))./sqrt(sum(Qsbj)))
hold on
errorbar(mean(DataStructure(NBsbj,[23:24])), std(DataStructure(NBsbj,[23:24]))./sqrt(sum(NBsbj)))
xlim([0.5, 2.5])
legend('Quiescence', 'NB')
title('Accuracy training')

subplot(1,3,2)
errorbar(mean(DataStructure(Qsbj,[25:26])), std(DataStructure(Qsbj,[25:26]))./sqrt(sum(Qsbj)))
hold on
errorbar(mean(DataStructure(NBsbj,[25:26])), std(DataStructure(NBsbj,[25:26]))./sqrt(sum(NBsbj)))
xlim([0.5, 2.5])
legend('Quiescence', 'NB')
title('Accuracy pretest')

subplot(1,3,3)
errorbar(mean(DataStructure(Qsbj,[26:27])), std(DataStructure(Qsbj,[26:27]))./sqrt(sum(Qsbj)))
hold on
errorbar(mean(DataStructure(NBsbj,[26:27])), std(DataStructure(NBsbj,[26:27]))./sqrt(sum(NBsbj)))
xlim([0.5, 2.5])
legend('Quiescence', 'NB')
title('Accuracy posttest')


% %% Accuracy Overtime Old and New Configurations
% % 29-30 Mean accuracy old conf Overtime PRETEST
% % 31-32 Mean accuracy new conf overtime PRETEST
% % 33-34 Mean accuracy old conf Overtime POSTTEST
% % 35-36 Mean accuracy new conf overtime POSTTEST
% figure
% subplot(1,2,1)
% errorbar(mean(DataStructure(Qsbj,[29:30])), std(DataStructure(Qsbj,[29:30]))./sqrt(sum(Qsbj)), 'r')
% hold on
% errorbar(mean(DataStructure(Qsbj,[31:32])), std(DataStructure(Qsbj,[31:32]))./sqrt(sum(Qsbj)), 'r--')
% 
% errorbar(mean(DataStructure(NBsbj,[29:30])), std(DataStructure(NBsbj,[29:30]))./sqrt(sum(NBsbj)), 'b')
% errorbar(mean(DataStructure(NBsbj,[31:32])), std(DataStructure(NBsbj,[31:32]))./sqrt(sum(NBsbj)), 'b--')
% xlim([0.5, 2.5])
% legend('Quie old', 'Quie new', 'NB old', 'NB new')
% title('Accuracy pretest')
% 
% subplot(1,2,2)
% errorbar(mean(DataStructure(Qsbj,[33:34])), std(DataStructure(Qsbj,[33:34]))./sqrt(sum(Qsbj)), 'r')
% hold on
% errorbar(mean(DataStructure(Qsbj,[35:36])), std(DataStructure(Qsbj,[35:36]))./sqrt(sum(Qsbj)), 'r--')
% 
% errorbar(mean(DataStructure(NBsbj,[33:34])), std(DataStructure(NBsbj,[33:34]))./sqrt(sum(NBsbj)), 'b')
% errorbar(mean(DataStructure(NBsbj,[35:36])), std(DataStructure(NBsbj,[35:36]))./sqrt(sum(NBsbj)), 'b--')
% xlim([0.5, 2.5])
% legend('Quie old', 'Quie new', 'NB old', 'NB new')
% title('Accuracy posttest')

%% QUIESCENCE Improvement By Training
% Correlation improvement and Quiescence Score
figure
subplot(1,3,1)
imprQ = DataStructure(Qsbj,5)-DataStructure(Qsbj,3);
plot(DataStructure(Qsbj,1), imprQ,'o')
ylabel('Improvement')
xlabel('Training Accuracy')
lsline

subplot(1,3,2)
imprQM = DataStructure(Qsbj,12)-DataStructure(Qsbj,8);
plot(DataStructure(Qsbj,1), imprQM,'o')
ylabel('Improvement Memorization')
xlabel('Training Accuracy')
lsline

subplot(1,3,3)
imprQG = DataStructure(Qsbj,13)-DataStructure(Qsbj,9);
plot(DataStructure(Qsbj,1), imprQG,'o')
ylabel('Improvement Generalization')
xlabel('Training Accuracy')
lsline
sgtitle('Quiescence: Training over Improvements')

%% NBACK Improvement by Training
figure

subplot(1,3,1)
imprNB = DataStructure(NBsbj,5)-DataStructure(NBsbj,3);
plot(DataStructure(NBsbj,1), imprNB,'o')
ylabel('Improvement')
xlabel('Training Accuracy')
lsline

subplot(1,3,2)
imprNBM = DataStructure(NBsbj,12)-DataStructure(NBsbj,8);
plot(DataStructure(NBsbj,1), imprNBM,'o')
ylabel('Improvement Memorization')
xlabel('Training Accuracy')
lsline

subplot(1,3,3)
imprNBG = DataStructure(NBsbj,13)-DataStructure(NBsbj,9);
plot(DataStructure(NBsbj,1), imprNBG,'o')
ylabel('Improvement Generalization')
xlabel('Training Accuracy')
lsline
sgtitle('NBACK: Training over Improvements')