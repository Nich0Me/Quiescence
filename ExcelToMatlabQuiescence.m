clear all
close all

cd ResultsQ/
DataTable = readtable('14047_torte-q_2020-11-18_20h10.38.787.csv');

FeedColumn = find(strcmpi(DataTable.Properties.VariableNames, 'Feedback'));
RTColumn = find(strcmpi(DataTable.Properties.VariableNames, 'key_resp_rt'));
PrColumn = find(strcmpi(DataTable.Properties.VariableNames, 'probability'));
T1Column = find(strcmpi(DataTable.Properties.VariableNames, 'torta_sx'));
T2Column = find(strcmpi(DataTable.Properties.VariableNames, 'torta_dx'));
RespColumn = find(strcmpi(DataTable.Properties.VariableNames, 'key_resp_keys'));
RatingResponse = find(strcmpi(DataTable.Properties.VariableNames, 'rating_response')); 

for t = 1:120
    
    %% TRAINING
    % Order
    training.trial(t) = t;
    
    % Response
    temp = DataTable(t,RespColumn);
    training.Y(t) = strcmp(cellstr(table2array(temp)),'a');
    
    % Reaction Time
    training.RT(t) = table2array(DataTable(t,RTColumn));
    
    % Feedback
    temp = DataTable(t,FeedColumn);
    training.Feedback(t) = strcmp(cellstr(table2array(temp)),'Correct!');
    
    % Outcome
    if training.Y(t) == 1 && training.Feedback(t) == 1
        training.Outcome(t) = 1;
    elseif training.Y(t) == 0 && training.Feedback(t) == 1
        training.Outcome(t) = 0;
    elseif training.Y(t) == 1 && training.Feedback(t) == 0
        training.Outcome(t) = 0;
    elseif training.Y(t) == 0 && training.Feedback(t) == 0
        training.Outcome(t) = 1;
    else
        error('non existent outcome')
    end
    
    % Too Slow
    if strcmp(cellstr(table2array(temp)),'Too slow :(')
        training.miss(t) = 1;
    else
        training.miss(t) = 0;
    end
    
    % Configuration
    temp = DataTable(t,T1Column);
    temp2 = DataTable(t,T2Column);
    if strcmp(cellstr(table2array(temp)),'t1.png')
        training.slices(t,1) = 1;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            training.slices(t,2) = 1;
            training.conf(t) = 1;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            training.slices(t,2) = 2;
            training.conf(t) = 2;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            training.slices(t,2) = 3;
            training.conf(t) = 3;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            training.slices(t,2) = 4;
            training.conf(t) = 4;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            training.slices(t,2) = 5;
            training.conf(t) = 5;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t2.png')
        training.slices(t,1) = 2;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            training.slices(t,2) = 1;
            training.conf(t) = 6;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            training.slices(t,2) = 2;
            training.conf(t) = 7;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            training.slices(t,2) = 3;
            training.conf(t) = 8;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            training.slices(t,2) = 4;
            training.conf(t) = 9;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            training.slices(t,2) = 5;
            training.conf(t) = 10;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t3.png')
        training.slices(t,1) = 3;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            training.slices(t,2) = 1;
            training.conf(t) = 11;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            training.slices(t,2) = 2;
            training.conf(t) = 12;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            training.slices(t,2) = 3;
            training.conf(t) = 13;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            training.slices(t,2) = 4;
            training.conf(t) = 14;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            training.slices(t,2) = 5;
            training.conf(t) = 15;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t4.png')
        training.slices(t,1) = 4;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            training.slices(t,2) = 1;
            training.conf(t) = 16;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            training.slices(t,2) = 2;
            training.conf(t) = 17;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            training.slices(t,2) = 3;
            training.conf(t) = 18;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            training.slices(t,2) = 4;
            training.conf(t) = 19;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            training.slices(t,2) = 5;
            training.conf(t) = 20;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t5.png')
        training.slices(t,1) = 5;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            training.slices(t,2) = 1;
            training.conf(t) = 21;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            training.slices(t,2) = 2;
            training.conf(t) = 22;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            training.slices(t,2) = 3;
            training.conf(t) = 23;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            training.slices(t,2) = 4;
            training.conf(t) = 24;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            training.slices(t,2) = 5;
            training.conf(t) = 25;
        else
            error('non existent configuration')
        end
        
    else
        error('non existent configuration')
    end
    
    
    
    
    
    
    
    
    
    
    %% PRETEST
    % Order
    pretest.trial(t) = t;
    
    % Response
    temp = DataTable(120+t,RespColumn);
    pretest.Y(t) = strcmp(cellstr(table2array(temp)),'a');
    
    % Reaction Time
    pretest.RT(t) = table2array(DataTable(120+t,RTColumn));
    
    % TooSlow
    temp = DataTable(120+t,FeedColumn);
    if strcmp(cellstr(table2array(temp)),'Too slow :(')
        pretest.miss(t) = 1;
    else
        pretest.miss(t) = 0;
    end
    
    % outcome
    pretest.Outcome(t) = round(table2array(DataTable(120+t,PrColumn)));
    
    % correct
    pretest.Correct(t) = pretest.Outcome(t) == pretest.Y(t);
    
    % conf & slices
    temp = DataTable(120+t,T1Column);
    temp2 = DataTable(120+t,T2Column);
    if strcmp(cellstr(table2array(temp)),'t1.png')
        pretest.slices(t,1) = 1;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            pretest.slices(t,2) = 1;
            pretest.conf(t) = 1;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            pretest.slices(t,2) = 2;
            pretest.conf(t) = 2;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            pretest.slices(t,2) = 3;
            pretest.conf(t) = 3;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            pretest.slices(t,2) = 4;
            pretest.conf(t) = 4;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            pretest.slices(t,2) = 5;
            pretest.conf(t) = 5;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t2.png')
        pretest.slices(t,1) = 2;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            pretest.slices(t,2) = 1;
            pretest.conf(t) = 6;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            pretest.slices(t,2) = 2;
            pretest.conf(t) = 7;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            pretest.slices(t,2) = 3;
            pretest.conf(t) = 8;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            pretest.slices(t,2) = 4;
            pretest.conf(t) = 9;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            pretest.slices(t,2) = 5;
            pretest.conf(t) = 10;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t3.png')
        pretest.slices(t,1) = 3;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            pretest.slices(t,2) = 1;
            pretest.conf(t) = 11;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            pretest.slices(t,2) = 2;
            pretest.conf(t) = 12;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            pretest.slices(t,2) = 3;
            pretest.conf(t) = 13;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            pretest.slices(t,2) = 4;
            pretest.conf(t) = 14;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            pretest.slices(t,2) = 5;
            pretest.conf(t) = 15;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t4.png')
        pretest.slices(t,1) = 4;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            pretest.slices(t,2) = 1;
            pretest.conf(t) = 16;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            pretest.slices(t,2) = 2;
            pretest.conf(t) = 17;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            pretest.slices(t,2) = 3;
            pretest.conf(t) = 18;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            pretest.slices(t,2) = 4;
            pretest.conf(t) = 19;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            pretest.slices(t,2) = 5;
            pretest.conf(t) = 20;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t5.png')
        pretest.slices(t,1) = 5;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            pretest.slices(t,2) = 1;
            pretest.conf(t) = 21;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            pretest.slices(t,2) = 2;
            pretest.conf(t) = 22;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            pretest.slices(t,2) = 3;
            pretest.conf(t) = 23;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            pretest.slices(t,2) = 4;
            pretest.conf(t) = 24;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            pretest.slices(t,2) = 5;
            pretest.conf(t) = 25;
        else
            error('non existent configuration')
        end
        
    else
        error('non existent configuration')
    end
    
    
    
    %% POST-TEST
    % Order
    posttest.trial(t) = t;
    
    % Response
    temp = DataTable(240+t,RespColumn);
    posttest.Y(t) = strcmp(cellstr(table2array(temp)),'a');
    
    % Reaction Time
    posttest.RT(t) = table2array(DataTable(240+t,RTColumn));
    
    % TooSlow
    temp = DataTable(240+t,FeedColumn);
    if strcmp(cellstr(table2array(temp)),'Too slow :(')
        posttest.miss(t) = 1;
    else
        posttest.miss(t) = 0;
    end
    
    % outcome
    posttest.Outcome(t) = round(table2array(DataTable(240+t,PrColumn)));
    
    % correct
    posttest.Correct(t) = posttest.Outcome(t) == posttest.Y(t);
    
    % conf & slices
    temp = DataTable(240+t,T1Column);
    temp2 = DataTable(240+t,T2Column);
    if strcmp(cellstr(table2array(temp)),'t1.png')
        posttest.slices(t,1) = 1;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            posttest.slices(t,2) = 1;
            posttest.conf(t) = 1;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            posttest.slices(t,2) = 2;
            posttest.conf(t) = 2;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            posttest.slices(t,2) = 3;
            posttest.conf(t) = 3;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            posttest.slices(t,2) = 4;
            posttest.conf(t) = 4;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            posttest.slices(t,2) = 5;
            posttest.conf(t) = 5;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t2.png')
        posttest.slices(t,1) = 2;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            posttest.slices(t,2) = 1;
            posttest.conf(t) = 6;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            posttest.slices(t,2) = 2;
            posttest.conf(t) = 7;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            posttest.slices(t,2) = 3;
            posttest.conf(t) = 8;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            posttest.slices(t,2) = 4;
            posttest.conf(t) = 9;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            posttest.slices(t,2) = 5;
            posttest.conf(t) = 10;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t3.png')
        posttest.slices(t,1) = 3;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            posttest.slices(t,2) = 1;
            posttest.conf(t) = 11;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            posttest.slices(t,2) = 2;
            posttest.conf(t) = 12;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            posttest.slices(t,2) = 3;
            posttest.conf(t) = 13;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            posttest.slices(t,2) = 4;
            posttest.conf(t) = 14;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            posttest.slices(t,2) = 5;
            posttest.conf(t) = 15;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t4.png')
        posttest.slices(t,1) = 4;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            posttest.slices(t,2) = 1;
            posttest.conf(t) = 16;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            posttest.slices(t,2) = 2;
            posttest.conf(t) = 17;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            posttest.slices(t,2) = 3;
            posttest.conf(t) = 18;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            posttest.slices(t,2) = 4;
            posttest.conf(t) = 19;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            posttest.slices(t,2) = 5;
            posttest.conf(t) = 20;
        else
            error('non existent configuration')
        end
        
    elseif strcmp(cellstr(table2array(temp)),'t5.png')
        posttest.slices(t,1) = 5;
        
        if strcmp(cellstr(table2array(temp2)),'t1.png')
            posttest.slices(t,2) = 1;
            posttest.conf(t) = 21;
        elseif strcmp(cellstr(table2array(temp2)),'t2.png')
            posttest.slices(t,2) = 2;
            posttest.conf(t) = 22;
        elseif strcmp(cellstr(table2array(temp2)),'t3.png')
            posttest.slices(t,2) = 3;
            posttest.conf(t) = 23;
        elseif strcmp(cellstr(table2array(temp2)),'t4.png')
            posttest.slices(t,2) = 4;
            posttest.conf(t) = 24;
        elseif strcmp(cellstr(table2array(temp2)),'t5.png')
            posttest.slices(t,2) = 5;
            posttest.conf(t) = 25;
        else
            error('non existent configuration')
        end
        
    else
        error('non existent configuration')
    end
    
end

%% Quiescence
Quiescence = table2array(DataTable(361,RatingResponse));

sbj = input('participants number');

mkdir(['/home/nicholas/Documents/MATLAB/QuiescencePavlovia/sbj',num2str(sbj)])
save(['/home/nicholas/Documents/MATLAB/QuiescencePavlovia/sbj',num2str(sbj),'/sbj',num2str(sbj)], 'training', 'pretest','posttest','Quiescence')