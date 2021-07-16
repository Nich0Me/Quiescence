%% Two Way mixed design ANOVA || NB/Q Group & Mem/Gen
%% T-Tests

%% Task and Rule
clear data
data(1:34,:) = [imprQG,imprQM]; 
data(35:58,:) = [imprNBG,imprNBM];

% data(1:25,:) = [DataStructure(Qsbj,9)-DataStructure(Qsbj,8), DataStructure(Qsbj,13)-DataStructure(Qsbj,12)];
% data(26:54,:) = [DataStructure(NBsbj,9)-DataStructure(NBsbj,8), DataStructure(NBsbj,13)-DataStructure(NBsbj,12)];

temp = [repmat({'Quiescence'}, 34, 1); repmat({'NBack'}, 24,1)]; % Nback and Quiescence

data = table(temp, data(:,1), data(:,2),...
    'VariableNames', {'Delay', 'D1','D2'});

% define within-subject factor time pressure as 'dataset' structure
within_factor = table({'Generalization', 'Memorization'}', 'VariableNames', {'Novelty'})

% fit the repeated measures model (GLM)
rm = fitrm(data, 'D1-D2~Delay', 'WithinDesign', within_factor);

% output results for factors involving the repeated measures factor
ranova_table = ranova(rm, 'WithinModel', 'Novelty') 

% get epsilon correction 
correction_table = epsilon(rm)

[h, p, ci, st] = ttest(imprQG)
[h, p, ci, st] = ttest(imprQM)
[h, p, ci, st] = ttest(imprNBG)
[h, p, ci, st] = ttest(imprNBM)


[h, p, ci, st] = ttest2(imprQG,imprNBG)
[h, p, ci, st] = ttest2(imprQM, imprNBM)

[h, p, ci, st] = ttest(imprQG, imprQM)
[h, p, ci, st] = ttest(imprNBG, imprNBM)

