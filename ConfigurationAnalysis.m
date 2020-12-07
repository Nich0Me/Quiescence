clear all
close all

path = '/home/nicholas/Documents/MATLAB/QuiescencePavlovia/';
TotSub = 80;
threshold = 0.95;

counter = 1;
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
    
    %% Select subject
    if (sum(DataStructure(sbj,[2,4,6,7,10,11,14,15])') > 0 & sbj~= 19 & sbj~= 23)
        confOrder = pretest.conf(pretest.miss==0);
        confAcc = pretest.Correct(pretest.miss==0);
        
        confs = unique(confOrder);
        confs = sort(confs);
        for k = 1:length(confs)
            idx = find(confOrder == confs(k));
            PretestConfAcc(counter,k) = mean(confAcc(idx));
        end
        
        confOrder = posttest.conf(posttest.miss==0);
        confAcc = posttest.Correct(posttest.miss==0);
        
        confs = unique(confOrder);
        confs = sort(confs);
        for k = 1:length(confs)
            idx = find(confOrder == confs(k));
            PosttestConfAcc(counter,k) = mean(confAcc(idx));
        end
        
        counter = counter+1;
    else
    end
    
    
end


temp = mean(PosttestConfAcc-PretestConfAcc);
temp2 = std(PosttestConfAcc-PretestConfAcc)./sqrt(size(PosttestConfAcc,1));

MeanMatrix(1:12) = temp(1:12);
MeanMatrix(14:25) = temp(13:end);
SemMatrix(1:12) = temp2(1:12);
SemMatrix(14:25) = temp2(13:end);

MeanMatrix = reshape(MeanMatrix, [5,5]);
SemMatrix = reshape(SemMatrix, [5,5]);

figure
imagesc(MeanMatrix)
colormap gray

figure
imagesc(SemMatrix)
colormap gray