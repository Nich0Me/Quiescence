%% Two Way mixed design ANOVA || NB/Q Group & Mem/Gen

%% Task and Rule
clear data
data(1:24,:) = [imprQG,imprQM]; 
data(25:57,:) = [imprNBG,imprNBM];

% data(1:25,:) = [DataStructure(Qsbj,9)-DataStructure(Qsbj,8), DataStructure(Qsbj,13)-DataStructure(Qsbj,12)];
% data(26:54,:) = [DataStructure(NBsbj,9)-DataStructure(NBsbj,8), DataStructure(NBsbj,13)-DataStructure(NBsbj,12)];

temp = [repmat({'Quiescence'}, 24, 1); repmat({'NBack'}, 33,1)]; % Nback and Quiescence

data = table(temp, data(:,1), data(:,2),...
    'VariableNames', {'Quiescence', 'D1','D2'});

% define within-subject factor time pressure as 'dataset' structure
within_factor = table({'Generalization', 'Memorization'}', 'VariableNames', {'MemGroup'})

% fit the repeated measures model (GLM)
rm = fitrm(data, 'D1-D2~Quiescence', 'WithinDesign', within_factor);

% output results for factors involving the repeated measures factor
ranova_table = ranova(rm, 'WithinModel', 'MemGroup') 

% get epsilon correction 
correction_table = epsilon(rm)


