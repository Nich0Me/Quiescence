function dec_array = get_sbj_table()
tabletemp = readtable('QuiescencePavloviaParticipants.xlsx');

dec_array = table2array(tabletemp(1:100, 7));

for r = 1:length(dec_array)
    if strcmp(table2array(tabletemp(r,8)), 'T1')
        dec_array(r,2) = 1;
    elseif strcmp(table2array(tabletemp(r,8)), 'T2')
        dec_array(r,2) = 2;
    elseif strcmp(table2array(tabletemp(r,8)), 'T3')
        dec_array(r,2) = 3;
    elseif strcmp(table2array(tabletemp(r,8)), 'T4')
        dec_array(r,2) = 4;
    else
        error('No Time Condition')
    end
end
idxAge = find(strcmpi(tabletemp.Properties.VariableNames, 'Age'));
dec_array(:,3) = table2array(tabletemp(1:100,idxAge));

idxSex = find(strcmpi(tabletemp.Properties.VariableNames, 'Sex'));
dec_array(:,4) = strcmp(table2array(tabletemp(1:100,idxSex)),'Male');
end