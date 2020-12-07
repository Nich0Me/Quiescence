clear all
close all

cd Results2B/
DataTable = readtable('14114_torte-2b_2020-12-01_12h30.17.864.csv');

FeedColumn = find(strcmpi(DataTable.Properties.VariableNames, 'Feedback'));
RTColumn = find(strcmpi(DataTable.Properties.VariableNames, 'key_resp_rt'));
PrColumn = find(strcmpi(DataTable.Properties.VariableNames, 'probability'));
T1Column = find(strcmpi(DataTable.Properties.VariableNames, 'torta_sx'));
T2Column = find(strcmpi(DataTable.Properties.VariableNames, 'torta_dx'));

for t = 1:120
    
    %% TRAINING
    % Order
    training.trial(t) = t;
    
    % Response
    temp = DataTable(t,13);
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
    temp = DataTable(120+t,13);
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
    temp = DataTable(380+t,13);
    posttest.Y(t) = strcmp(cellstr(table2array(temp)),'a');
    
    % Reaction Time
    posttest.RT(t) = table2array(DataTable(380+t,RTColumn));
    
    % TooSlow
    temp = DataTable(380+t,FeedColumn);
    if strcmp(cellstr(table2array(temp)),'Too slow :(')
        posttest.miss(t) = 1;
    else
        posttest.miss(t) = 0;
    end
    
    % outcome
    posttest.Outcome(t) = round(table2array(DataTable(380+t,PrColumn)));
    
    % correct
    posttest.Correct(t) = posttest.Outcome(t) == posttest.Y(t);
    
    % conf & slices
    temp = DataTable(380+t,T1Column);
    temp2 = DataTable(380+t,T2Column);
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

%% N-BACK

for k = 1:35
    
    %% BLOCK 1
    
    % order
    nback.block1.trial(k) = k;
    
    % letter
    nback.block1.letter(k) = table2array(DataTable(240+k,50));
    
    % Button
    temp = DataTable(240+k,44);
    nback.block1.button(k) = strcmp(cellstr(table2array(temp)),'space');
    
    % RT
    
    if nback.block1.button(k) == 1
        nback.block1.RT(k) = table2array(DataTable(240+k,51));
    else
        nback.block1.RT(k) = 0;
    end
    
    if k > 2
        if nback.block1.letter(k) == nback.block1.letter(k-2) & nback.block1.button(k) == 1
            nback.block1.correct(k) = 1;
        elseif nback.block1.letter(k) ~= nback.block1.letter(k-2) & nback.block1.button(k) == 0
            nback.block1.correct(k) = 1;
        else
            nback.block1.correct(k) = 0;
        end
    end
    
    %% BLOCK 2
    
    % order
    nback.block2.trial(k) = k;
    
    % letter
    nback.block2.letter(k) = table2array(DataTable(275+k,50));
    
    % Button
    temp = DataTable(275+k,44);
    nback.block2.button(k) = strcmp(cellstr(table2array(temp)),'space');
    
    % RT
    
    if nback.block2.button(k) == 1
        nback.block2.RT(k) = table2array(DataTable(275+k,51));
    else
        nback.block2.RT(k) = 0;
    end
    
    if k > 2
        if nback.block2.letter(k) == nback.block2.letter(k-2) & nback.block2.button(k) == 1
            nback.block2.correct(k) = 1;
        elseif nback.block2.letter(k) ~= nback.block2.letter(k-2) & nback.block2.button(k) == 0
            nback.block2.correct(k) = 1;
        else
            nback.block2.correct(k) = 0;
        end
    end
    
    
    %% BLOCK 3
    
    % order
    nback.block3.trial(k) = k;
    
    % letter
    nback.block3.letter(k) = table2array(DataTable(310+k,50));
    
    % Button
    temp = DataTable(310+k,44);
    nback.block3.button(k) = strcmp(cellstr(table2array(temp)),'space');
    
    % RT
    
    if nback.block3.button(k) == 1
        nback.block3.RT(k) = table2array(DataTable(310+k,51));
    else
        nback.block3.RT(k) = 0;
    end
    
    if k > 2
        if nback.block3.letter(k) == nback.block3.letter(k-2) & nback.block3.button(k) == 1
            nback.block3.correct(k) = 1;
        elseif nback.block3.letter(k) ~= nback.block3.letter(k-2) & nback.block3.button(k) == 0
            nback.block3.correct(k) = 1;
        else
            nback.block3.correct(k) = 0;
        end
    end
    
    %% BLOCK 4
    
    % order
    nback.block4.trial(k) = k;
    
    % letter
    nback.block4.letter(k) = table2array(DataTable(345+k,50));
    
    % Button
    temp = DataTable(345+k,44);
    nback.block4.button(k) = strcmp(cellstr(table2array(temp)),'space');
    
    % RT
    
    if nback.block4.button(k) == 1
        nback.block4.RT(k) = table2array(DataTable(345+k,51));
    else
        nback.block4.RT(k) = 0;
    end
    
    if k > 2
        if nback.block4.letter(k) == nback.block4.letter(k-2) & nback.block4.button(k) == 1
            nback.block4.correct(k) = 1;
        elseif nback.block4.letter(k) ~= nback.block4.letter(k-2) & nback.block4.button(k) == 0
            nback.block4.correct(k) = 1;
        else
            nback.block4.correct(k) = 0;
        end
    end
    
    
    
end


sbj = input('participants number');

mkdir(['/home/nicholas/Documents/MATLAB/QuiescencePavlovia/sbj',num2str(sbj)])
save(['/home/nicholas/Documents/MATLAB/QuiescencePavlovia/sbj',num2str(sbj),'/sbj',num2str(sbj)], 'training', 'pretest','posttest','nback')