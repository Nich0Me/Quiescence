%% Two Way mixed design ANOVA || NB/Q Group & Mem/Gen

%% Task and Rule
clear data
data(1:25,:) = [imprQG,imprQM]; 
data(26:54,:) = [imprNBG,imprNBM];

temp = [repmat({'Quiescence'}, 25, 1); repmat({'NBack'}, 29,1)]; % Nback and Quiescence

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


