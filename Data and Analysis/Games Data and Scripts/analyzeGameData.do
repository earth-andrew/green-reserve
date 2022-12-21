clear all

use gameData

drop if totalroundsgame < 16
drop if round == 1
drop if round == 2

//replace session = 215 if session == 209 & gameid == "1"

gen game_number = gameid
gen rainfall_m1_n = real(rainfall_m1)
gen rainfall_m2_n = real(rainfall_m2)

/*encode gameid, generate(game_number)
gen mean_grass_live = real(mean_grass_live)
gen var_grass_live = real(var_grass_live)
gen mean_grass_cut = real(mean_grass_cut)
gen var_grass_cut = real(var_grass_cut)
gen rainfall_m1 = real(rainfall_m1)
gen rainfall_m2 = real(rainfall_m2)
gen mean_grass_public_used = real(mean_grass_public_used)
gen mean_grass_shared_used = real(mean_grass_shared_used)
gen frac_shared_used = real(frac_shared_used)
*/

gen conflictCount = p1_case_3_4 + p2_case_3_4 + p3_case_3_4 + p4_case_3_4 

reg mean_grass_shared_used i.game_number rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session)
reg mean_grass_cut i.game_number rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session)
reg conflictCount i.game_number round mean_grass_cut frac_shared_used rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session)

collapse (min) roundstartdatetime p1name p2name p3name p4name mean_animals (mean) mean_grass_live mean_grass_cut var_grass_live var_grass_cut mean_grass_public_used mean_grass_shared_used frac_shared_used game_number, by(session)

//reg mean_animals  mean_grass_cut   mean_grass_shared_used frac_shared_used i.game_number

merge 1:1 p1name using hhid_sex, keepusing(sex) generate(sex_merge)
