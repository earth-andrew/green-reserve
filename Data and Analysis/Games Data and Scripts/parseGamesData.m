fileList = dir(fullfile(pwd, '**/*.csv'));

dataset = table;

for indexF = 1:length(fileList)
    
    fprintf(['File ' num2str(indexF) 'of ' num2str(length(fileList)) '\n']);
    
    currentFileName = fileList(indexF).name;
    currentFileFolder = fileList(indexF).folder;
    currentFile = fopen([currentFileFolder '/' currentFileName],'r');
    
    currentData = cell(0,1);
    doneReading = 0;
    while(~doneReading)
        newLine = fgetl(currentFile);
        if(newLine == -1)
            doneReading = 1;
        else
            currentData{end+1,1} = newLine;
        end
    end
    
    fclose(currentFile);
    
    
    underScores = strfind(currentFileName,'_');
    sessionID = currentFileName(1:underScores(1)-1);
    gameTag = currentFileName(underScores(1)+1:underScores(2)-1);
    p1Name = currentFileName(underScores(2)+1:underScores(3)-1);
    p2Name = currentFileName(underScores(4)+1:underScores(5)-1);
    p3Name = currentFileName(underScores(5)+1:underScores(6)-1);
    p4Name = currentFileName(underScores(6)+1:underScores(7)-1);
    
    startShared = strfind(currentData,'Choosing shared land');
    startPrivate = strfind(currentData,'Choosing private land');
    startPasture = strfind(currentData, 'Beginning ');
    nextPasture = strfind(currentData, 'Advancing');
    nextUpdate = strfind(currentData, 'Updating');
    p1Move = strfind(currentData, '- Player 1');
    p2Move = strfind(currentData, '- Player 2');
    p3Move = strfind(currentData, '- Player 3');
    p4Move = strfind(currentData, '- Player 4');
    
    case_3_0 = strfind(currentData,'Case 3.0');
    case_3_1 = strfind(currentData,'Case 3.1 ');
    case_3_2 = strfind(currentData,'Case 3.2');
    case_3_3 = strfind(currentData,'Case 3.3');
    case_3_4 = strfind(currentData,'Case 3.4');
    case_3_5 = strfind(currentData,'Case 3.5');
    case_3_6 = strfind(currentData,'Case 3.6');
    case_3_7 = strfind(currentData,'Case 3.7');
    case_3_8 = strfind(currentData,'Case 3.8');
    case_3_9 = strfind(currentData,'Case 3.9');
    case_3_10 = strfind(currentData,'Case 3.10');
    case_3_11 = strfind(currentData,'Case 3.11');
    case_3_12 = strfind(currentData,'Case 3.12');
    case_3_13 = strfind(currentData,'Case 3.13');
    case_3_14 = strfind(currentData,'Case 3.14');
    case_3_15 = strfind(currentData,'Case 3.15');
    
    unselected = strfind(currentData, 'unselected');
    
    animalCount_p1 = strfind(currentData,'Player 1 has animal at');
    animalCount_p2 = strfind(currentData,'Player 2 has animal at');
    animalCount_p3 = strfind(currentData,'Player 3 has animal at');
    animalCount_p4 = strfind(currentData,'Player 4 has animal at');
    
    animalLoss_p1 = strfind(currentData,[p1Name ' lost one animal']);
    animalLoss_p2 = strfind(currentData,[p2Name ' lost one animal']);
    animalLoss_p3 = strfind(currentData,[p3Name ' lost one animal']);
    animalLoss_p4 = strfind(currentData,[p4Name ' lost one animal']);

    grassCount = strfind(currentData, 'live grass;');
    
    
    sessionID = strfind(currentData, 'sessionID:');
    grassK = strfind(currentData, 'grassK:');
    gameTag = strfind(currentData, 'gameID:')';
    grassRound = strfind(currentData,'grass_');
    
    numRounds = sum(cell2mat(startPasture)) + sum(cell2mat(nextPasture));
    gameTable = table('Size',[numRounds 0]);
    gameTable.p1name(:) = string(p1Name);
    gameTable.p2name(:) = string(p2Name);
    gameTable.p3name(:) = string(p3Name);
    gameTable.p4name(:) = string(p4Name);
    gameTable.round = zeros(numRounds,1);
    gameTable.roundStartDateTime = zeros(numRounds,1);
    gameTable.roundStartString(:) = "";
    gameTable.p1_case_3_2 = zeros(numRounds,1);
    gameTable.p2_case_3_2 = zeros(numRounds,1);
    gameTable.p3_case_3_2 = zeros(numRounds,1);
    gameTable.p4_case_3_2 = zeros(numRounds,1);
    gameTable.p1_case_3_3 = zeros(numRounds,1);
    gameTable.p2_case_3_3 = zeros(numRounds,1);
    gameTable.p3_case_3_3 = zeros(numRounds,1);
    gameTable.p4_case_3_3 = zeros(numRounds,1);
    gameTable.p1_case_3_4 = zeros(numRounds,1);
    gameTable.p2_case_3_4 = zeros(numRounds,1);
    gameTable.p3_case_3_4 = zeros(numRounds,1);
    gameTable.p4_case_3_4 = zeros(numRounds,1);
    gameTable.p1_case_3_5 = zeros(numRounds,1);
    gameTable.p2_case_3_5 = zeros(numRounds,1);
    gameTable.p3_case_3_5 = zeros(numRounds,1);
    gameTable.p4_case_3_5 = zeros(numRounds,1);
    gameTable.p1_case_3_6 = zeros(numRounds,1);
    gameTable.p2_case_3_6 = zeros(numRounds,1);
    gameTable.p3_case_3_6 = zeros(numRounds,1);
    gameTable.p4_case_3_6 = zeros(numRounds,1);
    gameTable.p1_case_3_7 = zeros(numRounds,1);
    gameTable.p2_case_3_7 = zeros(numRounds,1);
    gameTable.p3_case_3_7 = zeros(numRounds,1);
    gameTable.p4_case_3_7 = zeros(numRounds,1);
    gameTable.p1_case_3_8 = zeros(numRounds,1);
    gameTable.p2_case_3_8 = zeros(numRounds,1);
    gameTable.p3_case_3_8 = zeros(numRounds,1);
    gameTable.p4_case_3_8 = zeros(numRounds,1);
    gameTable.p1_case_3_9 = zeros(numRounds,1);
    gameTable.p2_case_3_9 = zeros(numRounds,1);
    gameTable.p3_case_3_9 = zeros(numRounds,1);
    gameTable.p4_case_3_9 = zeros(numRounds,1);
    gameTable.p1_case_3_10 = zeros(numRounds,1);
    gameTable.p2_case_3_10 = zeros(numRounds,1);
    gameTable.p3_case_3_10 = zeros(numRounds,1);
    gameTable.p4_case_3_10 = zeros(numRounds,1);
    gameTable.p1_case_3_11 = zeros(numRounds,1);
    gameTable.p2_case_3_11 = zeros(numRounds,1);
    gameTable.p3_case_3_11 = zeros(numRounds,1);
    gameTable.p4_case_3_11 = zeros(numRounds,1);
    gameTable.p1_case_3_12 = zeros(numRounds,1);
    gameTable.p2_case_3_12 = zeros(numRounds,1);
    gameTable.p3_case_3_12 = zeros(numRounds,1);
    gameTable.p4_case_3_12 = zeros(numRounds,1);
    gameTable.p1_case_3_13 = zeros(numRounds,1);
    gameTable.p2_case_3_13 = zeros(numRounds,1);
    gameTable.p3_case_3_13 = zeros(numRounds,1);
    gameTable.p4_case_3_13 = zeros(numRounds,1);
    gameTable.p1_case_3_14 = zeros(numRounds,1);
    gameTable.p2_case_3_14 = zeros(numRounds,1);
    gameTable.p3_case_3_14 = zeros(numRounds,1);
    gameTable.p4_case_3_14 = zeros(numRounds,1);
    gameTable.p1_case_3_15 = zeros(numRounds,1);
    gameTable.p2_case_3_15 = zeros(numRounds,1);
    gameTable.p3_case_3_15 = zeros(numRounds,1);
    gameTable.p4_case_3_15 = zeros(numRounds,1);
    gameTable.p1_round_time = zeros(numRounds,1);
    gameTable.p2_round_time = zeros(numRounds,1);
    gameTable.p3_round_time = zeros(numRounds,1);
    gameTable.p4_round_time = zeros(numRounds,1);
    gameTable.p1_animals = zeros(numRounds,1);
    gameTable.p2_animals = zeros(numRounds,1);
    gameTable.p3_animals = zeros(numRounds,1);
    gameTable.p4_animals = zeros(numRounds,1);
    gameTable.p1_animal_loss = zeros(numRounds,1);
    gameTable.p2_animal_loss = zeros(numRounds,1);
    gameTable.p3_animal_loss = zeros(numRounds,1);
    gameTable.p4_animal_loss = zeros(numRounds,1);
    gameTable.patch_0_0_live = zeros(numRounds,1);
    gameTable.patch_1_0_live = zeros(numRounds,1);
    gameTable.patch_2_0_live = zeros(numRounds,1);
    gameTable.patch_3_0_live = zeros(numRounds,1);
    gameTable.patch_4_0_live = zeros(numRounds,1);
    gameTable.patch_5_0_live = zeros(numRounds,1);
    gameTable.patch_0_1_live = zeros(numRounds,1);
    gameTable.patch_1_1_live = zeros(numRounds,1);
    gameTable.patch_2_1_live = zeros(numRounds,1);
    gameTable.patch_3_1_live = zeros(numRounds,1);
    gameTable.patch_4_1_live = zeros(numRounds,1);
    gameTable.patch_5_1_live = zeros(numRounds,1);
    gameTable.patch_0_2_live = zeros(numRounds,1);
    gameTable.patch_1_2_live = zeros(numRounds,1);
    gameTable.patch_2_2_live = zeros(numRounds,1);
    gameTable.patch_3_2_live = zeros(numRounds,1);
    gameTable.patch_4_2_live = zeros(numRounds,1);
    gameTable.patch_5_2_live = zeros(numRounds,1);
    gameTable.patch_0_3_live = zeros(numRounds,1);
    gameTable.patch_1_3_live = zeros(numRounds,1);
    gameTable.patch_2_3_live = zeros(numRounds,1);
    gameTable.patch_3_3_live = zeros(numRounds,1);
    gameTable.patch_4_3_live = zeros(numRounds,1);
    gameTable.patch_5_3_live = zeros(numRounds,1);
    gameTable.patch_0_4_live = zeros(numRounds,1);
    gameTable.patch_1_4_live = zeros(numRounds,1);
    gameTable.patch_2_4_live = zeros(numRounds,1);
    gameTable.patch_3_4_live = zeros(numRounds,1);
    gameTable.patch_4_4_live = zeros(numRounds,1);
    gameTable.patch_5_4_live = zeros(numRounds,1);
    gameTable.patch_0_5_live = zeros(numRounds,1);
    gameTable.patch_1_5_live = zeros(numRounds,1);
    gameTable.patch_2_5_live = zeros(numRounds,1);
    gameTable.patch_3_5_live = zeros(numRounds,1);
    gameTable.patch_4_5_live = zeros(numRounds,1);
    gameTable.patch_5_5_live = zeros(numRounds,1);
    gameTable.patch_0_0_cut = zeros(numRounds,1);
    gameTable.patch_1_0_cut = zeros(numRounds,1);
    gameTable.patch_2_0_cut = zeros(numRounds,1);
    gameTable.patch_3_0_cut = zeros(numRounds,1);
    gameTable.patch_4_0_cut = zeros(numRounds,1);
    gameTable.patch_5_0_cut = zeros(numRounds,1);
    gameTable.patch_0_1_cut = zeros(numRounds,1);
    gameTable.patch_1_1_cut = zeros(numRounds,1);
    gameTable.patch_2_1_cut = zeros(numRounds,1);
    gameTable.patch_3_1_cut = zeros(numRounds,1);
    gameTable.patch_4_1_cut = zeros(numRounds,1);
    gameTable.patch_5_1_cut = zeros(numRounds,1);
    gameTable.patch_0_2_cut = zeros(numRounds,1);
    gameTable.patch_1_2_cut = zeros(numRounds,1);
    gameTable.patch_2_2_cut = zeros(numRounds,1);
    gameTable.patch_3_2_cut = zeros(numRounds,1);
    gameTable.patch_4_2_cut = zeros(numRounds,1);
    gameTable.patch_5_2_cut = zeros(numRounds,1);
    gameTable.patch_0_3_cut = zeros(numRounds,1);
    gameTable.patch_1_3_cut = zeros(numRounds,1);
    gameTable.patch_2_3_cut = zeros(numRounds,1);
    gameTable.patch_3_3_cut = zeros(numRounds,1);
    gameTable.patch_4_3_cut = zeros(numRounds,1);
    gameTable.patch_5_3_cut = zeros(numRounds,1);
    gameTable.patch_0_4_cut = zeros(numRounds,1);
    gameTable.patch_1_4_cut = zeros(numRounds,1);
    gameTable.patch_2_4_cut = zeros(numRounds,1);
    gameTable.patch_3_4_cut = zeros(numRounds,1);
    gameTable.patch_4_4_cut = zeros(numRounds,1);
    gameTable.patch_5_4_cut = zeros(numRounds,1);
    gameTable.patch_0_5_cut = zeros(numRounds,1);
    gameTable.patch_1_5_cut = zeros(numRounds,1);
    gameTable.patch_2_5_cut = zeros(numRounds,1);
    gameTable.patch_3_5_cut = zeros(numRounds,1);
    gameTable.patch_4_5_cut = zeros(numRounds,1);
    gameTable.patch_5_5_cut = zeros(numRounds,1);
    gameTable.patch_0_0_shared = zeros(numRounds,1);
    gameTable.patch_1_0_shared = zeros(numRounds,1);
    gameTable.patch_2_0_shared = zeros(numRounds,1);
    gameTable.patch_3_0_shared = zeros(numRounds,1);
    gameTable.patch_4_0_shared = zeros(numRounds,1);
    gameTable.patch_5_0_shared = zeros(numRounds,1);
    gameTable.patch_0_1_shared = zeros(numRounds,1);
    gameTable.patch_1_1_shared = zeros(numRounds,1);
    gameTable.patch_2_1_shared = zeros(numRounds,1);
    gameTable.patch_3_1_shared = zeros(numRounds,1);
    gameTable.patch_4_1_shared = zeros(numRounds,1);
    gameTable.patch_5_1_shared = zeros(numRounds,1);
    gameTable.patch_0_2_shared = zeros(numRounds,1);
    gameTable.patch_1_2_shared = zeros(numRounds,1);
    gameTable.patch_2_2_shared = zeros(numRounds,1);
    gameTable.patch_3_2_shared = zeros(numRounds,1);
    gameTable.patch_4_2_shared = zeros(numRounds,1);
    gameTable.patch_5_2_shared = zeros(numRounds,1);
    gameTable.patch_0_3_shared = zeros(numRounds,1);
    gameTable.patch_1_3_shared = zeros(numRounds,1);
    gameTable.patch_2_3_shared = zeros(numRounds,1);
    gameTable.patch_3_3_shared = zeros(numRounds,1);
    gameTable.patch_4_3_shared = zeros(numRounds,1);
    gameTable.patch_5_3_shared = zeros(numRounds,1);
    gameTable.patch_0_4_shared = zeros(numRounds,1);
    gameTable.patch_1_4_shared = zeros(numRounds,1);
    gameTable.patch_2_4_shared = zeros(numRounds,1);
    gameTable.patch_3_4_shared = zeros(numRounds,1);
    gameTable.patch_4_4_shared = zeros(numRounds,1);
    gameTable.patch_5_4_shared = zeros(numRounds,1);
    gameTable.patch_0_5_shared = zeros(numRounds,1);
    gameTable.patch_1_5_shared = zeros(numRounds,1);
    gameTable.patch_2_5_shared = zeros(numRounds,1);
    gameTable.patch_3_5_shared = zeros(numRounds,1);
    gameTable.patch_4_5_shared = zeros(numRounds,1);
    gameTable.patch_5_5_shared = zeros(numRounds,1);
    gameTable.patch_0_0_private = zeros(numRounds,1);
    gameTable.patch_1_0_private = zeros(numRounds,1);
    gameTable.patch_2_0_private = zeros(numRounds,1);
    gameTable.patch_3_0_private = zeros(numRounds,1);
    gameTable.patch_4_0_private = zeros(numRounds,1);
    gameTable.patch_5_0_private = zeros(numRounds,1);
    gameTable.patch_0_1_private = zeros(numRounds,1);
    gameTable.patch_1_1_private = zeros(numRounds,1);
    gameTable.patch_2_1_private = zeros(numRounds,1);
    gameTable.patch_3_1_private = zeros(numRounds,1);
    gameTable.patch_4_1_private = zeros(numRounds,1);
    gameTable.patch_5_1_private = zeros(numRounds,1);
    gameTable.patch_0_2_private = zeros(numRounds,1);
    gameTable.patch_1_2_private = zeros(numRounds,1);
    gameTable.patch_2_2_private = zeros(numRounds,1);
    gameTable.patch_3_2_private = zeros(numRounds,1);
    gameTable.patch_4_2_private = zeros(numRounds,1);
    gameTable.patch_5_2_private = zeros(numRounds,1);
    gameTable.patch_0_3_private = zeros(numRounds,1);
    gameTable.patch_1_3_private = zeros(numRounds,1);
    gameTable.patch_2_3_private = zeros(numRounds,1);
    gameTable.patch_3_3_private = zeros(numRounds,1);
    gameTable.patch_4_3_private = zeros(numRounds,1);
    gameTable.patch_5_3_private = zeros(numRounds,1);
    gameTable.patch_0_4_private = zeros(numRounds,1);
    gameTable.patch_1_4_private = zeros(numRounds,1);
    gameTable.patch_2_4_private = zeros(numRounds,1);
    gameTable.patch_3_4_private = zeros(numRounds,1);
    gameTable.patch_4_4_private = zeros(numRounds,1);
    gameTable.patch_5_4_private = zeros(numRounds,1);
    gameTable.patch_0_5_private = zeros(numRounds,1);
    gameTable.patch_1_5_private = zeros(numRounds,1);
    gameTable.patch_2_5_private = zeros(numRounds,1);
    gameTable.patch_3_5_private = zeros(numRounds,1);
    gameTable.patch_4_5_private = zeros(numRounds,1);
    gameTable.patch_5_5_private = zeros(numRounds,1);
    gameTable.rainfall = zeros(numRounds,1);
    
    gameTable.rainfall_m1 = zeros(numRounds,1) * NaN;
    gameTable.rainfall_m2 = zeros(numRounds,1) * NaN;
    gameTable.mean_grass_live = zeros(numRounds,1);
    gameTable.mean_grass_cut = zeros(numRounds,1);
    gameTable.var_grass_live = zeros(numRounds,1);
    gameTable.var_grass_cut = zeros(numRounds,1);
    gameTable.frac_shared = zeros(numRounds,1);
    gameTable.frac_private = zeros(numRounds,1);
    gameTable.frac_public_used = zeros(numRounds,1);
    gameTable.frac_shared_used = zeros(numRounds,1);
    gameTable.frac_private_used = zeros(numRounds,1);
    gameTable.mean_grass_public_used = zeros(numRounds,1);
    gameTable.mean_grass_shared_used = zeros(numRounds,1);
    gameTable.mean_animals = zeros(numRounds,1);
    gameTable.var_animals = zeros(numRounds,1);
   
    gameTable.grassCapacity = zeros(numRounds,1);
    currentRound = 0;
    
    live_grass = zeros(6) * NaN;
    cut_grass = zeros(6) * NaN;
    count_shared = 0;
    count_private = 0;
    shared_map = zeros(6);
    private_map = zeros(6);
    
     gameTable.fullFileName(:) = string(currentFileName);
     gameTable.totalRoundsGame(:) = numRounds;
     
    for indexJ = 1:size(currentData,1)
        
  
        
        if(~isempty(sessionID{indexJ}))
            temp = textscan(currentData{indexJ}, 'sessionID: %d');
            gameTable.session(:) = temp{1};
        end
        if(~isempty(gameTag{indexJ}))
            temp = textscan(currentData{indexJ}, 'gameID: %q');
            gameTable.gameID(:) = string(temp);
        end
        if(~isempty(grassK{indexJ}))
            temp = textscan(currentData{indexJ}, 'grassK: %d');
            gameTable.grassCapacity(:) = temp{1};
        end
        
        if(~isempty(grassRound{indexJ}))
            temp = textscan(currentData{indexJ}, 'grass_%d: %d');
            roundNumber = temp{1};
            if roundNumber <= numRounds
                gameTable.rainfall(temp{1}) = temp{2};
                
                if roundNumber - 1 > 0
                    gameTable.rainfall_m1(temp{1}-1) = temp{2};
                end
                if roundNumber - 2 > 0
                    gameTable.rainfall_m2(temp{1}-2) = temp{2};
                end             
            end           
        end
        
        
        if(~isempty(startPasture{indexJ}))
            currentRound = 1;
            gameTable.round(currentRound) = currentRound;
            temp = textscan(currentData{indexJ}, 'Beginning pasturing phases at %q %q %q');
            try
                roundTime = datenum([temp{1}{1} ' ' temp{2}{1} ' ' temp{3}{1}],'HH:MM:SS.FFF PM dd-mmm-yyyy');
            catch
                temp = textscan(currentData{indexJ}, 'Beginning pasture phases at %q %q %q');
                roundTime = datenum([temp{1}{1} ' ' temp{2}{1} ' ' temp{3}{1}],'HH:MM:SS.FFF PM dd-mmm-yyyy');
            end
            gameTable.roundStartDateTime(currentRound) = roundTime;
            gameTable.roundStartString(currentRound) = datestr(roundTime);
            live_grass = zeros(6) * NaN;
            cut_grass = zeros(6) * NaN;
        end
        
        if(~isempty(nextPasture{indexJ}))
            
            %%last vars from previous round
            public_map = 1 - shared_map - private_map;
            gameTable.mean_grass_live(currentRound) = mean(live_grass(:));
            gameTable.mean_grass_cut(currentRound) = mean(cut_grass(:));
            gameTable.var_grass_live(currentRound) = var(live_grass(:));
            gameTable.var_grass_cut(currentRound) = var(cut_grass(:));
            gameTable.frac_shared(currentRound) = sum(shared_map(:))/36;
            gameTable.frac_private(currentRound) = sum(private_map(:))/36;
            gameTable.frac_public_used(currentRound) = sum((live_grass(:) < gameTable.grassCapacity(currentRound)) .* public_map(:)) / sum(public_map(:));
            gameTable.frac_shared_used(currentRound) = sum((live_grass(:) < gameTable.grassCapacity(currentRound)) .* shared_map(:)) / sum(shared_map(:));
            gameTable.frac_private_used(currentRound) = sum((live_grass(:) < gameTable.grassCapacity(currentRound)) .* private_map(:)) / sum(private_map(:));
            gameTable.mean_grass_public_used(currentRound) = mean(live_grass(public_map == 1));
            gameTable.mean_grass_shared_used(currentRound) = mean(live_grass(shared_map == 1));
            
            animal_count = [gameTable.p1_animals(currentRound) gameTable.p2_animals(currentRound) ...
                gameTable.p3_animals(currentRound) gameTable.p4_animals(currentRound)];
            gameTable.mean_animals(currentRound) = mean(animal_count);
            gameTable.var_animals(currentRound) = var(animal_count);
            
            %%next round
            currentRound = currentRound + 1;
            gameTable.round(currentRound) = currentRound;
            temp = textscan(currentData{indexJ}, 'Advancing to next phase at %q %q %q');
            try
                roundTime = datenum([temp{1}{1} ' ' temp{2}{1} ' ' temp{3}{1}],'HH:MM:SS.FFF PM dd-mmm-yyyy');
            catch
                temp = textscan(currentData{indexJ}, 'Advancing to next year at%q %q %q');
                roundTime = datenum([temp{1}{1} ' ' temp{2}{1} ' ' temp{3}{1}],'HH:MM:SS.FFF PM dd-mmm-yyyy');
            end
            gameTable.roundStartDateTime(currentRound) = roundTime;
            gameTable.roundStartString(currentRound) = datestr(roundTime);
            live_grass = zeros(6) * NaN;
            cut_grass = zeros(6) * NaN;
        end
        
        
        if(~isempty(case_3_2{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_2(currentRound) = gameTable.p1_case_3_2(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_2(currentRound) = gameTable.p2_case_3_2(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_2(currentRound) = gameTable.p3_case_3_2(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_2(currentRound) = gameTable.p4_case_3_2(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_3{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_3(currentRound) = gameTable.p1_case_3_3(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_3(currentRound) = gameTable.p2_case_3_3(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_3(currentRound) = gameTable.p3_case_3_3(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_3(currentRound) = gameTable.p4_case_3_3(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_4{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_4(currentRound) = gameTable.p1_case_3_4(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_4(currentRound) = gameTable.p2_case_3_4(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_4(currentRound) = gameTable.p3_case_3_4(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_4(currentRound) = gameTable.p4_case_3_4(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_5{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_5(currentRound) = gameTable.p1_case_3_5(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_5(currentRound) = gameTable.p2_case_3_5(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_5(currentRound) = gameTable.p3_case_3_5(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_5(currentRound) = gameTable.p4_case_3_5(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_6{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_6(currentRound) = gameTable.p1_case_3_6(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_6(currentRound) = gameTable.p2_case_3_6(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_6(currentRound) = gameTable.p3_case_3_6(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_6(currentRound) = gameTable.p4_case_3_6(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_7{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_7(currentRound) = gameTable.p1_case_3_7(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_7(currentRound) = gameTable.p2_case_3_7(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_7(currentRound) = gameTable.p3_case_3_7(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_7(currentRound) = gameTable.p4_case_3_7(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_8{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_8(currentRound) = gameTable.p1_case_3_8(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_8(currentRound) = gameTable.p2_case_3_8(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_8(currentRound) = gameTable.p3_case_3_8(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_8(currentRound) = gameTable.p4_case_3_8(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_9{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_9(currentRound) = gameTable.p1_case_3_9(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_9(currentRound) = gameTable.p2_case_3_9(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_9(currentRound) = gameTable.p3_case_3_9(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_9(currentRound) = gameTable.p4_case_3_9(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_10{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_10(currentRound) = gameTable.p1_case_3_10(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_10(currentRound) = gameTable.p2_case_3_10(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_10(currentRound) = gameTable.p3_case_3_10(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_10(currentRound) = gameTable.p4_case_3_10(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_11{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_11(currentRound) = gameTable.p1_case_3_11(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_11(currentRound) = gameTable.p2_case_3_11(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_11(currentRound) = gameTable.p3_case_3_11(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_11(currentRound) = gameTable.p4_case_3_11(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_12{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_12(currentRound) = gameTable.p1_case_3_12(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_12(currentRound) = gameTable.p2_case_3_12(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_12(currentRound) = gameTable.p3_case_3_12(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_12(currentRound) = gameTable.p4_case_3_12(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_13{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_13(currentRound) = gameTable.p1_case_3_13(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_13(currentRound) = gameTable.p2_case_3_13(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_13(currentRound) = gameTable.p3_case_3_13(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_13(currentRound) = gameTable.p4_case_3_13(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_14{indexJ}))
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_14(currentRound) = gameTable.p1_case_3_14(currentRound) + 1;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_14(currentRound) = gameTable.p2_case_3_14(currentRound) + 1;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_14(currentRound) = gameTable.p3_case_3_14(currentRound) + 1;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_14(currentRound) = gameTable.p4_case_3_14(currentRound) + 1;
            end
        end
        
        if(~isempty(case_3_15{indexJ}) && currentRound > 0)
            temp = textscan(currentData{indexJ},'Case 3.15 - Player %d clicked confirm at %q %q %q');
            clickTime = datenum([temp{2}{1} ' ' temp{3}{1} ' ' temp{4}{1}],'HH:MM:SS.FFF PM dd-mmm-yyyy');
            
            if(~isempty(p1Move{indexJ}))
                gameTable.p1_case_3_15(currentRound) = gameTable.p1_case_3_15(currentRound) + 1;
                gameTable.p1_round_time(currentRound) = clickTime - roundTime;
            elseif(~isempty(p2Move{indexJ}))
                gameTable.p2_case_3_15(currentRound) = gameTable.p2_case_3_15(currentRound) + 1;
                gameTable.p2_round_time(currentRound) = clickTime - roundTime;
            elseif(~isempty(p3Move{indexJ}))
                gameTable.p3_case_3_15(currentRound) = gameTable.p3_case_3_15(currentRound) + 1;
                gameTable.p3_round_time(currentRound) = clickTime - roundTime;
            elseif(~isempty(p4Move{indexJ}))
                gameTable.p4_case_3_15(currentRound) = gameTable.p4_case_3_15(currentRound) + 1;
                gameTable.p4_round_time(currentRound) = clickTime - roundTime;
            end
        end
        
        if(~isempty(animalCount_p1{indexJ}))
            gameTable.p1_animals(currentRound) = gameTable.p1_animals(currentRound) + 1;
        elseif(~isempty(animalCount_p2{indexJ}))
            gameTable.p2_animals(currentRound) = gameTable.p2_animals(currentRound) + 1;
        elseif(~isempty(animalCount_p3{indexJ}))
            gameTable.p3_animals(currentRound) = gameTable.p3_animals(currentRound) + 1;
        elseif(~isempty(animalCount_p4{indexJ}))
            gameTable.p4_animals(currentRound) = gameTable.p4_animals(currentRound) + 1;
        end

        if(~isempty(animalLoss_p1{indexJ}))
            gameTable.p1_animal_loss(currentRound) = gameTable.p1_animal_loss(currentRound) + 1;
        elseif(~isempty(animalLoss_p2{indexJ}))
            gameTable.p2_animal_loss(currentRound) = gameTable.p2_animal_loss(currentRound) + 1;
        elseif(~isempty(animalLoss_p3{indexJ}))
            gameTable.p3_animal_loss(currentRound) = gameTable.p3_animal_loss(currentRound) + 1;
        elseif(~isempty(animalLoss_p4{indexJ}))
            gameTable.p4_animal_loss(currentRound) = gameTable.p4_animal_loss(currentRound) + 1;
        end

        if(~isempty(grassCount{indexJ}))
            numberList = textscan(currentData{indexJ}, 'Patch %d %d has %f live grass; %f cut grass');
            xCoord = numberList{1};
            yCoord = numberList{2};
            switch xCoord
                
                case 0
                    switch yCoord
                        case 0
                            gameTable.patch_0_0_live(currentRound) = numberList{3};
                            gameTable.patch_0_0_cut(currentRound) = numberList{4};
                            live_grass(1,1) = numberList{3};
                            cut_grass(1,1) = numberList{4};
                        case 1
                            gameTable.patch_0_1_live(currentRound) = numberList{3};
                            gameTable.patch_0_1_cut(currentRound) = numberList{4};
                            live_grass(1,2) = numberList{3};
                            cut_grass(1,2) = numberList{4};
                        case 2
                            gameTable.patch_0_2_live(currentRound) = numberList{3};
                            gameTable.patch_0_2_cut(currentRound) = numberList{4};
                            live_grass(1,3) = numberList{3};
                            cut_grass(1,3) = numberList{4};
                        case 3
                            gameTable.patch_0_3_live(currentRound) = numberList{3};
                            gameTable.patch_0_3_cut(currentRound) = numberList{4};
                            live_grass(1,4) = numberList{3};
                            cut_grass(1,4) = numberList{4};
                        case 4
                            gameTable.patch_0_4_live(currentRound) = numberList{3};
                            gameTable.patch_0_4_cut(currentRound) = numberList{4};
                            live_grass(1,5) = numberList{3};
                            cut_grass(1,5) = numberList{4};
                        case 5
                            gameTable.patch_0_5_live(currentRound) = numberList{3};
                            gameTable.patch_0_5_cut(currentRound) = numberList{4};
                            live_grass(1,6) = numberList{3};
                            cut_grass(1,6) = numberList{4};
                    end
                case 1
                    switch yCoord
                        case 0
                            gameTable.patch_1_0_live(currentRound) = numberList{3};
                            gameTable.patch_1_0_cut(currentRound) = numberList{4};
                            live_grass(2,1) = numberList{3};
                            cut_grass(2,1) = numberList{4};
                        case 1
                            gameTable.patch_1_1_live(currentRound) = numberList{3};
                            gameTable.patch_1_1_cut(currentRound) = numberList{4};
                            live_grass(2,2) = numberList{3};
                            cut_grass(2,2) = numberList{4};
                        case 2
                            gameTable.patch_1_2_live(currentRound) = numberList{3};
                            gameTable.patch_1_2_cut(currentRound) = numberList{4};
                            live_grass(2,3) = numberList{3};
                            cut_grass(2,3) = numberList{4};
                        case 3
                            gameTable.patch_1_3_live(currentRound) = numberList{3};
                            gameTable.patch_1_3_cut(currentRound) = numberList{4};
                            live_grass(2,4) = numberList{3};
                            cut_grass(2,4) = numberList{4};
                        case 4
                            gameTable.patch_1_4_live(currentRound) = numberList{3};
                            gameTable.patch_1_4_cut(currentRound) = numberList{4};
                            live_grass(2,5) = numberList{3};
                            cut_grass(2,5) = numberList{4};
                        case 5
                            gameTable.patch_1_5_live(currentRound) = numberList{3};
                            gameTable.patch_1_5_cut(currentRound) = numberList{4};
                            live_grass(2,6) = numberList{3};
                            cut_grass(2,6) = numberList{4};
                    end
                case 2
                    switch yCoord
                        case 0
                            gameTable.patch_2_0_live(currentRound) = numberList{3};
                            gameTable.patch_2_0_cut(currentRound) = numberList{4};
                            live_grass(3,1) = numberList{3};
                            cut_grass(3,1) = numberList{4};
                        case 1
                            gameTable.patch_2_1_live(currentRound) = numberList{3};
                            gameTable.patch_2_1_cut(currentRound) = numberList{4};
                            live_grass(3,2) = numberList{3};
                            cut_grass(3,2) = numberList{4};
                        case 2
                            gameTable.patch_2_2_live(currentRound) = numberList{3};
                            gameTable.patch_2_2_cut(currentRound) = numberList{4};
                            live_grass(3,3) = numberList{3};
                            cut_grass(3,3) = numberList{4};
                        case 3
                            gameTable.patch_2_3_live(currentRound) = numberList{3};
                            gameTable.patch_2_3_cut(currentRound) = numberList{4};
                            live_grass(3,4) = numberList{3};
                            cut_grass(3,4) = numberList{4};
                        case 4
                            gameTable.patch_2_4_live(currentRound) = numberList{3};
                            gameTable.patch_2_4_cut(currentRound) = numberList{4};
                            live_grass(3,5) = numberList{3};
                            cut_grass(3,5) = numberList{4};
                        case 5
                            gameTable.patch_2_5_live(currentRound) = numberList{3};
                            gameTable.patch_2_5_cut(currentRound) = numberList{4};
                            live_grass(3,6) = numberList{3};
                            cut_grass(3,6) = numberList{4};
                    end
                case 3
                    switch yCoord
                        case 0
                            gameTable.patch_3_0_live(currentRound) = numberList{3};
                            gameTable.patch_3_0_cut(currentRound) = numberList{4};
                            live_grass(4,1) = numberList{3};
                            cut_grass(4,1) = numberList{4};
                       case 1
                            gameTable.patch_3_1_live(currentRound) = numberList{3};
                            gameTable.patch_3_1_cut(currentRound) = numberList{4};
                            live_grass(4,2) = numberList{3};
                            cut_grass(4,2) = numberList{4};
                        case 2
                            gameTable.patch_3_2_live(currentRound) = numberList{3};
                            gameTable.patch_3_2_cut(currentRound) = numberList{4};
                            live_grass(4,3) = numberList{3};
                            cut_grass(4,3) = numberList{4};
                        case 3
                            gameTable.patch_3_3_live(currentRound) = numberList{3};
                            gameTable.patch_3_3_cut(currentRound) = numberList{4};
                            live_grass(4,4) = numberList{3};
                            cut_grass(4,4) = numberList{4};
                        case 4
                            gameTable.patch_3_4_live(currentRound) = numberList{3};
                            gameTable.patch_3_4_cut(currentRound) = numberList{4};
                            live_grass(4,5) = numberList{3};
                            cut_grass(4,5) = numberList{4};
                        case 5
                            gameTable.patch_3_5_live(currentRound) = numberList{3};
                            gameTable.patch_3_5_cut(currentRound) = numberList{4};
                            live_grass(4,6) = numberList{3};
                            cut_grass(4,6) = numberList{4};
                    end
                case 4
                    switch yCoord
                        case 0
                            gameTable.patch_4_0_live(currentRound) = numberList{3};
                            gameTable.patch_4_0_cut(currentRound) = numberList{4};
                            live_grass(5,1) = numberList{3};
                            cut_grass(5,1) = numberList{4};
                        case 1
                            gameTable.patch_4_1_live(currentRound) = numberList{3};
                            gameTable.patch_4_1_cut(currentRound) = numberList{4};
                            live_grass(5,2) = numberList{3};
                            cut_grass(5,2) = numberList{4};
                        case 2
                            gameTable.patch_4_2_live(currentRound) = numberList{3};
                            gameTable.patch_4_2_cut(currentRound) = numberList{4};
                            live_grass(5,3) = numberList{3};
                            cut_grass(5,3) = numberList{4};
                        case 3
                            gameTable.patch_4_3_live(currentRound) = numberList{3};
                            gameTable.patch_4_3_cut(currentRound) = numberList{4};
                            live_grass(5,4) = numberList{3};
                            cut_grass(5,4) = numberList{4};
                        case 4
                            gameTable.patch_4_4_live(currentRound) = numberList{3};
                            gameTable.patch_4_4_cut(currentRound) = numberList{4};
                            live_grass(5,5) = numberList{3};
                            cut_grass(5,5) = numberList{4};
                        case 5
                            gameTable.patch_4_5_live(currentRound) = numberList{3};
                            gameTable.patch_4_5_cut(currentRound) = numberList{4};
                            live_grass(5,6) = numberList{3};
                            cut_grass(5,6) = numberList{4};
                    end
                case 5
                    switch yCoord
                        case 0
                            gameTable.patch_5_0_live(currentRound) = numberList{3};
                            gameTable.patch_5_0_cut(currentRound) = numberList{4};
                            live_grass(6,1) = numberList{3};
                            cut_grass(6,1) = numberList{4};
                        case 1
                            gameTable.patch_5_1_live(currentRound) = numberList{3};
                            gameTable.patch_5_1_cut(currentRound) = numberList{4};
                            live_grass(6,2) = numberList{3};
                            cut_grass(6,2) = numberList{4};
                        case 2
                            gameTable.patch_5_2_live(currentRound) = numberList{3};
                            gameTable.patch_5_2_cut(currentRound) = numberList{4};
                            live_grass(6,3) = numberList{3};
                            cut_grass(6,3) = numberList{4};
                        case 3
                            gameTable.patch_5_3_live(currentRound) = numberList{3};
                            gameTable.patch_5_3_cut(currentRound) = numberList{4};
                            live_grass(6,4) = numberList{3};
                            cut_grass(6,4) = numberList{4};
                        case 4
                            gameTable.patch_5_4_live(currentRound) = numberList{3};
                            gameTable.patch_5_4_cut(currentRound) = numberList{4};
                            live_grass(6,5) = numberList{3};
                            cut_grass(6,5) = numberList{4};
                        case 5
                            gameTable.patch_5_5_live(currentRound) = numberList{3};
                            gameTable.patch_5_5_cut(currentRound) = numberList{4};
                            live_grass(6,6) = numberList{3};
                            cut_grass(6,6) = numberList{4};
                    end
            end
            
        end
        
        if(~isempty(case_3_0{indexJ}))
            if(~isempty(unselected{indexJ}))
                numberList = textscan(currentData{indexJ}, 'Case 3.0 - Player %d unselected patch %d %d at %q %q %q');
                state = 0;
            else
                numberList = textscan(currentData{indexJ}, 'Case 3.0 - Player %d selected patch %d %d at %q %q %q');
                state = 1;
            end
            xCoord = numberList{2};
            yCoord = numberList{3};
            switch xCoord
                
                case 0
                    switch yCoord
                        case 0
                            gameTable.patch_0_0_shared(:) = state;
                            shared_map(1,1) = 1;
                        case 1
                            gameTable.patch_0_1_shared(:) = state;
                            shared_map(1,2) = 1;
                        case 2
                            gameTable.patch_0_2_shared(:) = state;
                            shared_map(1,3) = 1;
                        case 3
                            gameTable.patch_0_3_shared(:) = state;
                            shared_map(1,4) = 1;
                        case 4
                            gameTable.patch_0_4_shared(:) = state;
                            shared_map(1,5) = 1;
                        case 5
                            gameTable.patch_0_5_shared(:) = state;
                            shared_map(1,6) = 1;
                    end
                case 1
                    switch yCoord
                        case 0
                            gameTable.patch_1_0_shared(:) = state;
                            shared_map(2,1) = 1;
                        case 1
                            gameTable.patch_1_1_shared(:) = state;
                            shared_map(2,2) = 1;
                        case 2
                            gameTable.patch_1_2_shared(:) = state;
                            shared_map(2,3) = 1;
                        case 3
                            gameTable.patch_1_3_shared(:) = state;
                            shared_map(2,4) = 1;
                        case 4
                            gameTable.patch_1_4_shared(:) = state;
                            shared_map(2,5) = 1;
                        case 5
                            gameTable.patch_1_5_shared(:) = state;
                            shared_map(2,6) = 1;
                    end
                case 2
                    switch yCoord
                        case 0
                            gameTable.patch_2_0_shared(:) = state;
                            shared_map(3,1) = 1;
                        case 1
                            gameTable.patch_2_1_shared(:) = state;
                            shared_map(3,2) = 1;
                        case 2
                            gameTable.patch_2_2_shared(:) = state;
                            shared_map(3,3) = 1;
                        case 3
                            gameTable.patch_2_3_shared(:) = state;
                            shared_map(3,4) = 1;
                        case 4
                            gameTable.patch_2_4_shared(:) = state;
                            shared_map(3,5) = 1;
                        case 5
                            gameTable.patch_2_5_shared(:) = state;
                            shared_map(3,6) = 1;
                    end
                case 3
                    switch yCoord
                        case 0
                            gameTable.patch_3_0_shared(:) = state;
                            shared_map(4,1) = 1;
                        case 1
                            gameTable.patch_3_1_shared(:) = state;
                            shared_map(4,2) = 1;
                        case 2
                            gameTable.patch_3_2_shared(:) = state;
                            shared_map(4,3) = 1;
                        case 3
                            gameTable.patch_3_3_shared(:) = state;
                            shared_map(4,4) = 1;
                        case 4
                            gameTable.patch_3_4_shared(:) = state;
                            shared_map(4,5) = 1;
                        case 5
                            gameTable.patch_3_5_shared(:) = state;
                            shared_map(4,6) = 1;
                    end
                case 4
                    switch yCoord
                        case 0
                            gameTable.patch_4_0_shared(:) = state;
                            shared_map(5,1) = 1;
                        case 1
                            gameTable.patch_4_1_shared(:) = state;
                            shared_map(5,2) = 1;
                        case 2
                            gameTable.patch_4_2_shared(:) = state;
                            shared_map(5,3) = 1;
                        case 3
                            gameTable.patch_4_3_shared(:) = state;
                            shared_map(5,4) = 1;
                        case 4
                            gameTable.patch_4_4_shared(:) = state;
                            shared_map(5,5) = 1;
                        case 5
                            gameTable.patch_4_5_shared(:) = state;
                            shared_map(5,6) = 1;
                    end
                case 5
                    switch yCoord
                        case 0
                            gameTable.patch_5_0_shared(:) = state;
                            shared_map(6,1) = 1;
                        case 1
                            gameTable.patch_5_1_shared(:) = state;
                            shared_map(6,2) = 1;
                        case 2
                            gameTable.patch_5_2_shared(:) = state;
                            shared_map(6,3) = 1;
                        case 3
                            gameTable.patch_5_3_shared(:) = state;
                            shared_map(6,4) = 1;
                        case 4
                            gameTable.patch_5_4_shared(:) = state;
                            shared_map(6,5) = 1;
                        case 5
                            gameTable.patch_5_5_shared(:) = state;
                            shared_map(6,6) = 1;
                    end
            end
            
        end
        
        if(~isempty(case_3_1{indexJ}))
            if(~isempty(unselected{indexJ}))
                numberList = textscan(currentData{indexJ}, 'Case 3.1 - Player %d unselected patch %d %d at %q %q %q');
                state = 0;
            else
                numberList = textscan(currentData{indexJ}, 'Case 3.1 - Player %d selected patch %d %d at %q %q %q');
                state = 1;
            end
            xCoord = numberList{2};
            yCoord = numberList{3};
            switch xCoord
                
                case 0
                    switch yCoord
                        case 0
                            gameTable.patch_0_0_private(:) = state;
                            private_map(1,1) = 1;
                        case 1
                            gameTable.patch_0_1_private(:) = state;
                            private_map(1,2) = 1;
                        case 2
                            gameTable.patch_0_2_private(:) = state;
                            private_map(1,3) = 1;
                        case 3
                            gameTable.patch_0_3_private(:) = state;
                            private_map(1,4) = 1;
                        case 4
                            gameTable.patch_0_4_private(:) = state;
                            private_map(1,5) = 1;
                        case 5
                            gameTable.patch_0_5_private(:) = state;
                            private_map(1,6) = 1;
                    end
                case 1
                    switch yCoord
                        case 0
                            gameTable.patch_1_0_private(:) = state;
                            private_map(2,1) = 1;
                        case 1
                            gameTable.patch_1_1_private(:) = state;
                            private_map(2,2) = 1;
                        case 2
                            gameTable.patch_1_2_private(:) = state;
                            private_map(2,3) = 1;
                        case 3
                            gameTable.patch_1_3_private(:) = state;
                            private_map(2,4) = 1;
                        case 4
                            gameTable.patch_1_4_private(:) = state;
                            private_map(2,5) = 1;
                        case 5
                            gameTable.patch_1_5_private(:) = state;
                            private_map(2,6) = 1;
                    end
                case 2
                    switch yCoord
                        case 0
                            gameTable.patch_2_0_private(:) = state;
                            private_map(3,1) = 1;
                        case 1
                            gameTable.patch_2_1_private(:) = state;
                            private_map(3,2) = 1;
                        case 2
                            gameTable.patch_2_2_private(:) = state;
                            private_map(3,3) = 1;
                        case 3
                            gameTable.patch_2_3_private(:) = state;
                            private_map(3,4) = 1;
                        case 4
                            gameTable.patch_2_4_private(:) = state;
                            private_map(3,5) = 1;
                        case 5
                            gameTable.patch_2_5_private(:) = state;
                            private_map(3,6) = 1;
                    end
                case 3
                    switch yCoord
                        case 0
                            gameTable.patch_3_0_private(:) = state;
                            private_map(4,1) = 1;
                        case 1
                            gameTable.patch_3_1_private(:) = state;
                            private_map(4,2) = 1;
                        case 2
                            gameTable.patch_3_2_private(:) = state;
                            private_map(4,3) = 1;
                        case 3
                            gameTable.patch_3_3_private(:) = state;
                            private_map(4,4) = 1;
                        case 4
                            gameTable.patch_3_4_private(:) = state;
                            private_map(4,5) = 1;
                        case 5
                            gameTable.patch_3_5_private(:) = state;
                            private_map(4,6) = 1;
                    end
                case 4
                    switch yCoord
                        case 0
                            gameTable.patch_4_0_private(:) = state;
                            private_map(5,1) = 1;
                        case 1
                            gameTable.patch_4_1_private(:) = state;
                            private_map(5,2) = 1;
                        case 2
                            gameTable.patch_4_2_private(:) = state;
                            private_map(5,3) = 1;
                        case 3
                            gameTable.patch_4_3_private(:) = state;
                            private_map(5,4) = 1;
                        case 4
                            gameTable.patch_4_4_private(:) = state;
                            private_map(5,5) = 1;
                        case 5
                            gameTable.patch_4_5_private(:) = state;
                            private_map(5,6) = 1;
                    end
                case 5
                    switch yCoord
                        case 0
                            gameTable.patch_5_0_private(:) = state;
                            private_map(6,1) = 1;
                        case 1
                            gameTable.patch_5_1_private(:) = state;
                            private_map(6,2) = 1;
                        case 2
                            gameTable.patch_5_2_private(:) = state;
                            private_map(6,3) = 1;
                        case 3
                            gameTable.patch_5_3_private(:) = state;
                            private_map(6,4) = 1;
                        case 4
                            gameTable.patch_5_4_private(:) = state;
                            private_map(6,5) = 1;
                        case 5
                            gameTable.patch_5_5_private(:) = state;
                            private_map(6,6) = 1;
                    end
            end
            
        end
        
    end
    
    %%last vars from previous round
    public_map = 1 - shared_map - private_map;
    gameTable.mean_grass_live(currentRound) = mean(live_grass(:));
    gameTable.mean_grass_cut(currentRound) = mean(cut_grass(:));
    gameTable.var_grass_live(currentRound) = var(live_grass(:));
    gameTable.var_grass_cut(currentRound) = var(cut_grass(:));
    gameTable.frac_shared(currentRound) = sum(shared_map(:))/36;
    gameTable.frac_private(currentRound) = sum(private_map(:))/36;
    gameTable.frac_public_used(currentRound) = sum((live_grass(:) < gameTable.grassCapacity(currentRound)) .* public_map(:)) / sum(public_map(:));
    gameTable.frac_shared_used(currentRound) = sum((live_grass(:) < gameTable.grassCapacity(currentRound)) .* shared_map(:)) / sum(shared_map(:));
    gameTable.frac_private_used(currentRound) = sum((live_grass(:) < gameTable.grassCapacity(currentRound)) .* private_map(:)) / sum(private_map(:));
    gameTable.mean_grass_public_used(currentRound) = mean(live_grass(public_map == 1));
    gameTable.mean_grass_shared_used(currentRound) = mean(live_grass(shared_map == 1));
    
    animal_count = [gameTable.p1_animals(currentRound) gameTable.p2_animals(currentRound) ...
        gameTable.p3_animals(currentRound) gameTable.p4_animals(currentRound)];
    gameTable.mean_animals(currentRound) = mean(animal_count);
    gameTable.var_animals(currentRound) = var(animal_count);
    
    dataset = [dataset; gameTable];
end
dataset = [dataset(:,end-1:end) dataset(:,1:end-2)];

%$%dataset(isnan(dataset.gameID),:) = [];

gameEnds = find(dataset.round == 16);

dataset2 = table();
for indexI = 1:length(gameEnds)
    if(dataset.rainfall(gameEnds(indexI)-15) == 5)
        dataset2 = [dataset2; dataset(gameEnds(indexI)-15:gameEnds(indexI),:)];
    end
end

dataset = dataset2;
gameEnds = find(dataset.round == 16);


%%alternate measure for total animals ... cumulative losses
dataset.p1_animals(dataset.round == 1) = 10;
dataset.p1_animals(dataset.round == 2) = dataset.p1_animals(dataset.round == 1) - dataset.p1_animal_loss(dataset.round == 1);
dataset.p1_animals(dataset.round == 3) = dataset.p1_animals(dataset.round == 2) - dataset.p1_animal_loss(dataset.round == 2);
dataset.p1_animals(dataset.round == 4) = dataset.p1_animals(dataset.round == 3) - dataset.p1_animal_loss(dataset.round == 3);
dataset.p1_animals(dataset.round == 5) = dataset.p1_animals(dataset.round == 4) - dataset.p1_animal_loss(dataset.round == 4);
dataset.p1_animals(dataset.round == 6) = dataset.p1_animals(dataset.round == 5) - dataset.p1_animal_loss(dataset.round == 5);
dataset.p1_animals(dataset.round == 7) = dataset.p1_animals(dataset.round == 6) - dataset.p1_animal_loss(dataset.round == 6);
dataset.p1_animals(dataset.round == 8) = dataset.p1_animals(dataset.round == 7) - dataset.p1_animal_loss(dataset.round == 7);
dataset.p1_animals(dataset.round == 9) = dataset.p1_animals(dataset.round == 8) - dataset.p1_animal_loss(dataset.round == 8);
dataset.p1_animals(dataset.round == 10) = dataset.p1_animals(dataset.round == 9) - dataset.p1_animal_loss(dataset.round == 9);
dataset.p1_animals(dataset.round == 11) = dataset.p1_animals(dataset.round == 10) - dataset.p1_animal_loss(dataset.round == 10);
dataset.p1_animals(dataset.round == 12) = dataset.p1_animals(dataset.round == 11) - dataset.p1_animal_loss(dataset.round == 11);
dataset.p1_animals(dataset.round == 13) = dataset.p1_animals(dataset.round == 12) - dataset.p1_animal_loss(dataset.round == 12);
dataset.p1_animals(dataset.round == 14) = dataset.p1_animals(dataset.round == 13) - dataset.p1_animal_loss(dataset.round == 13);
dataset.p1_animals(dataset.round == 15) = dataset.p1_animals(dataset.round == 14) - dataset.p1_animal_loss(dataset.round == 14);
dataset.p1_animals(dataset.round == 16) = dataset.p1_animals(dataset.round == 15) - dataset.p1_animal_loss(dataset.round == 15);
dataset.p2_animals(dataset.round == 1) = 10;
dataset.p2_animals(dataset.round == 2) = dataset.p2_animals(dataset.round == 1) - dataset.p2_animal_loss(dataset.round == 1);
dataset.p2_animals(dataset.round == 3) = dataset.p2_animals(dataset.round == 2) - dataset.p2_animal_loss(dataset.round == 2);
dataset.p2_animals(dataset.round == 4) = dataset.p2_animals(dataset.round == 3) - dataset.p2_animal_loss(dataset.round == 3);
dataset.p2_animals(dataset.round == 5) = dataset.p2_animals(dataset.round == 4) - dataset.p2_animal_loss(dataset.round == 4);
dataset.p2_animals(dataset.round == 6) = dataset.p2_animals(dataset.round == 5) - dataset.p2_animal_loss(dataset.round == 5);
dataset.p2_animals(dataset.round == 7) = dataset.p2_animals(dataset.round == 6) - dataset.p2_animal_loss(dataset.round == 6);
dataset.p2_animals(dataset.round == 8) = dataset.p2_animals(dataset.round == 7) - dataset.p2_animal_loss(dataset.round == 7);
dataset.p2_animals(dataset.round == 9) = dataset.p2_animals(dataset.round == 8) - dataset.p2_animal_loss(dataset.round == 8);
dataset.p2_animals(dataset.round == 10) = dataset.p2_animals(dataset.round == 9) - dataset.p2_animal_loss(dataset.round == 9);
dataset.p2_animals(dataset.round == 11) = dataset.p2_animals(dataset.round == 10) - dataset.p2_animal_loss(dataset.round == 10);
dataset.p2_animals(dataset.round == 12) = dataset.p2_animals(dataset.round == 11) - dataset.p2_animal_loss(dataset.round == 11);
dataset.p2_animals(dataset.round == 13) = dataset.p2_animals(dataset.round == 12) - dataset.p2_animal_loss(dataset.round == 12);
dataset.p2_animals(dataset.round == 14) = dataset.p2_animals(dataset.round == 13) - dataset.p2_animal_loss(dataset.round == 13);
dataset.p2_animals(dataset.round == 15) = dataset.p2_animals(dataset.round == 14) - dataset.p2_animal_loss(dataset.round == 14);
dataset.p2_animals(dataset.round == 16) = dataset.p2_animals(dataset.round == 15) - dataset.p2_animal_loss(dataset.round == 15);
dataset.p3_animals(dataset.round == 1) = 10;
dataset.p3_animals(dataset.round == 2) = dataset.p3_animals(dataset.round == 1) - dataset.p3_animal_loss(dataset.round == 1);
dataset.p3_animals(dataset.round == 3) = dataset.p3_animals(dataset.round == 2) - dataset.p3_animal_loss(dataset.round == 2);
dataset.p3_animals(dataset.round == 4) = dataset.p3_animals(dataset.round == 3) - dataset.p3_animal_loss(dataset.round == 3);
dataset.p3_animals(dataset.round == 5) = dataset.p3_animals(dataset.round == 4) - dataset.p3_animal_loss(dataset.round == 4);
dataset.p3_animals(dataset.round == 6) = dataset.p3_animals(dataset.round == 5) - dataset.p3_animal_loss(dataset.round == 5);
dataset.p3_animals(dataset.round == 7) = dataset.p3_animals(dataset.round == 6) - dataset.p3_animal_loss(dataset.round == 6);
dataset.p3_animals(dataset.round == 8) = dataset.p3_animals(dataset.round == 7) - dataset.p3_animal_loss(dataset.round == 7);
dataset.p3_animals(dataset.round == 9) = dataset.p3_animals(dataset.round == 8) - dataset.p3_animal_loss(dataset.round == 8);
dataset.p3_animals(dataset.round == 10) = dataset.p3_animals(dataset.round == 9) - dataset.p3_animal_loss(dataset.round == 9);
dataset.p3_animals(dataset.round == 11) = dataset.p3_animals(dataset.round == 10) - dataset.p3_animal_loss(dataset.round == 10);
dataset.p3_animals(dataset.round == 12) = dataset.p3_animals(dataset.round == 11) - dataset.p3_animal_loss(dataset.round == 11);
dataset.p3_animals(dataset.round == 13) = dataset.p3_animals(dataset.round == 12) - dataset.p3_animal_loss(dataset.round == 12);
dataset.p3_animals(dataset.round == 14) = dataset.p3_animals(dataset.round == 13) - dataset.p3_animal_loss(dataset.round == 13);
dataset.p3_animals(dataset.round == 15) = dataset.p3_animals(dataset.round == 14) - dataset.p3_animal_loss(dataset.round == 14);
dataset.p3_animals(dataset.round == 16) = dataset.p3_animals(dataset.round == 15) - dataset.p3_animal_loss(dataset.round == 15);
dataset.p4_animals(dataset.round == 1) = 10;
dataset.p4_animals(dataset.round == 2) = dataset.p4_animals(dataset.round == 1) - dataset.p4_animal_loss(dataset.round == 1);
dataset.p4_animals(dataset.round == 3) = dataset.p4_animals(dataset.round == 2) - dataset.p4_animal_loss(dataset.round == 2);
dataset.p4_animals(dataset.round == 4) = dataset.p4_animals(dataset.round == 3) - dataset.p4_animal_loss(dataset.round == 3);
dataset.p4_animals(dataset.round == 5) = dataset.p4_animals(dataset.round == 4) - dataset.p4_animal_loss(dataset.round == 4);
dataset.p4_animals(dataset.round == 6) = dataset.p4_animals(dataset.round == 5) - dataset.p4_animal_loss(dataset.round == 5);
dataset.p4_animals(dataset.round == 7) = dataset.p4_animals(dataset.round == 6) - dataset.p4_animal_loss(dataset.round == 6);
dataset.p4_animals(dataset.round == 8) = dataset.p4_animals(dataset.round == 7) - dataset.p4_animal_loss(dataset.round == 7);
dataset.p4_animals(dataset.round == 9) = dataset.p4_animals(dataset.round == 8) - dataset.p4_animal_loss(dataset.round == 8);
dataset.p4_animals(dataset.round == 10) = dataset.p4_animals(dataset.round == 9) - dataset.p4_animal_loss(dataset.round == 9);
dataset.p4_animals(dataset.round == 11) = dataset.p4_animals(dataset.round == 10) - dataset.p4_animal_loss(dataset.round == 10);
dataset.p4_animals(dataset.round == 12) = dataset.p4_animals(dataset.round == 11) - dataset.p4_animal_loss(dataset.round == 11);
dataset.p4_animals(dataset.round == 13) = dataset.p4_animals(dataset.round == 12) - dataset.p4_animal_loss(dataset.round == 12);
dataset.p4_animals(dataset.round == 14) = dataset.p4_animals(dataset.round == 13) - dataset.p4_animal_loss(dataset.round == 13);
dataset.p4_animals(dataset.round == 15) = dataset.p4_animals(dataset.round == 14) - dataset.p4_animal_loss(dataset.round == 14);
dataset.p4_animals(dataset.round == 16) = dataset.p4_animals(dataset.round == 15) - dataset.p4_animal_loss(dataset.round == 15);

dataset.mean_animals(dataset.round == 1) = mean([dataset.p1_animals(dataset.round == 1) ...
    dataset.p2_animals(dataset.round == 1) dataset.p3_animals(dataset.round == 1) dataset.p4_animals(dataset.round == 1)],2);
dataset.mean_animals(dataset.round == 2) = mean([dataset.p1_animals(dataset.round == 2) ...
    dataset.p2_animals(dataset.round == 2) dataset.p3_animals(dataset.round == 2) dataset.p4_animals(dataset.round == 2)],2);
dataset.mean_animals(dataset.round == 3) = mean([dataset.p1_animals(dataset.round == 3) ...
    dataset.p2_animals(dataset.round == 3) dataset.p3_animals(dataset.round == 3) dataset.p4_animals(dataset.round == 3)],2);
dataset.mean_animals(dataset.round == 4) = mean([dataset.p1_animals(dataset.round == 4) ...
    dataset.p2_animals(dataset.round == 4) dataset.p3_animals(dataset.round == 4) dataset.p4_animals(dataset.round == 4)],2);
dataset.mean_animals(dataset.round == 5) = mean([dataset.p1_animals(dataset.round == 5) ...
    dataset.p2_animals(dataset.round == 5) dataset.p3_animals(dataset.round == 5) dataset.p4_animals(dataset.round == 5)],2);
dataset.mean_animals(dataset.round == 6) = mean([dataset.p1_animals(dataset.round == 6) ...
    dataset.p2_animals(dataset.round == 6) dataset.p3_animals(dataset.round == 6) dataset.p4_animals(dataset.round == 6)],2);
dataset.mean_animals(dataset.round == 7) = mean([dataset.p1_animals(dataset.round == 7) ...
    dataset.p2_animals(dataset.round == 7) dataset.p3_animals(dataset.round == 7) dataset.p4_animals(dataset.round == 7)],2);
dataset.mean_animals(dataset.round == 8) = mean([dataset.p1_animals(dataset.round == 8) ...
    dataset.p2_animals(dataset.round == 8) dataset.p3_animals(dataset.round == 8) dataset.p4_animals(dataset.round == 8)],2);
dataset.mean_animals(dataset.round == 9) = mean([dataset.p1_animals(dataset.round == 9) ...
    dataset.p2_animals(dataset.round == 9) dataset.p3_animals(dataset.round == 9) dataset.p4_animals(dataset.round == 9)],2);
dataset.mean_animals(dataset.round == 10) = mean([dataset.p1_animals(dataset.round == 10) ...
    dataset.p2_animals(dataset.round == 10) dataset.p3_animals(dataset.round == 10) dataset.p4_animals(dataset.round == 10)],2);
dataset.mean_animals(dataset.round == 11) = mean([dataset.p1_animals(dataset.round == 11) ...
    dataset.p2_animals(dataset.round == 11) dataset.p3_animals(dataset.round == 11) dataset.p4_animals(dataset.round == 11)],2);
dataset.mean_animals(dataset.round == 12) = mean([dataset.p1_animals(dataset.round == 12) ...
    dataset.p2_animals(dataset.round == 12) dataset.p3_animals(dataset.round == 12) dataset.p4_animals(dataset.round == 12)],2);
dataset.mean_animals(dataset.round == 13) = mean([dataset.p1_animals(dataset.round == 13) ...
    dataset.p2_animals(dataset.round == 13) dataset.p3_animals(dataset.round == 13) dataset.p4_animals(dataset.round == 13)],2);
dataset.mean_animals(dataset.round == 14) = mean([dataset.p1_animals(dataset.round == 14) ...
    dataset.p2_animals(dataset.round == 14) dataset.p3_animals(dataset.round == 14) dataset.p4_animals(dataset.round == 14)],2);
dataset.mean_animals(dataset.round == 15) = mean([dataset.p1_animals(dataset.round == 15) ...
    dataset.p2_animals(dataset.round == 15) dataset.p3_animals(dataset.round == 15) dataset.p4_animals(dataset.round == 15)],2);
dataset.mean_animals(dataset.round == 16) = mean([dataset.p1_animals(dataset.round == 16) ...
    dataset.p2_animals(dataset.round == 16) dataset.p3_animals(dataset.round == 16) dataset.p4_animals(dataset.round == 16)],2);
%%


writetable(dataset,'gameData.csv');