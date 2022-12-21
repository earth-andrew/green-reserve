/*clear 

use rand_coeffs_time_dce2

rename herd herd2
rename good good2
rename bad bad2
//rename self self2
//rename comm comm2
rename alltime alltime2

rename id coeffid

sort coeffid
save rand_coeffs_time_dce2, replace

clear

use rand_coeffs_time_dce1

rename herd herd1
rename good good1
rename bad bad1
//rename self self1
//rename comm comm1
rename alltime alltime1

rename id coeffid

sort coeffid
save rand_coeffs_time_dce1, replace

*/
clear 

use rand_coeffs_self_comm_dce2

merge coeffid using rand_coeffs_self_comm_dce1

drop _merge

sort coeffid

merge coeffid using fullDataTable

gen datenum = date(today,"DMY")
gen age = howoldareyou_
gen workMale = adultmales14_60_
gen workFemale = adultfemales14_60_
encode selectyour_theenumerator_namefro, gen(enumerator)

label define Likert 1 "Strongly disagree" 2 "Disagree" 3 "Agree" 4 "Strongly agree" 
encode ourpasturelandusenowwillaffectth, gen(q1_predce) label(Likert)
encode peopleshouldbeabletoraisehowever, gen(q2_predce) label(Likert)
encode communitymembersshouldcooperatet, gen(q3_predce) label(Likert)
encode communitymembersshouldactcollect, gen(q4_predce) label(Likert)
encode post_ourpasturelandusenowwillaff, gen(q1_postdce) label(Likert)
encode post_peopleshouldbeabletoraiseho, gen(q2_postdce) label(Likert)
encode post_communitymembersshouldcoope, gen(q3_postdce) label(Likert)
encode post_communitymembersshouldactco, gen(q4_postdce) label(Likert)

replace q1_predce = . if q1_predce > 4
replace q2_predce = . if q2_predce > 4
replace q3_predce = . if q3_predce > 4
replace q4_predce = . if q4_predce > 4
replace q1_postdce = . if q1_postdce > 4
replace q2_postdce = . if q2_postdce > 4
replace q3_postdce = . if q3_postdce > 4
replace q4_postdce = . if q4_postdce > 4

gen q1diff = q1_postdce - q1_predce
gen q2diff = q2_postdce - q2_predce
gen q3diff = q3_postdce - q3_predce
gen q4diff = q4_postdce - q4_predce

gen p1name = hhid
gen p2name = hhid
gen p3name = hhid
gen p4name = hhid

merge 1:1 hhid using hhid_sex, keepusing(sex) generate(sex_merge)
drop sex_merge

encode sex, generate(sex_n)

save quest_plus_DCE_coeffs_self_comm, replace

replace sex_n = 0 if sex_n == 2
rename sex_n female

local regList datenum herd_size age female workMale workFemale i.main_animal i.enumerator

reg herd1 `regList'
reg good1 `regList'
reg bad1 `regList'
reg self1 `regList'
reg comm1 `regList'

reg herd2 `regList'
reg good2 `regList'
reg bad2 `regList'
reg self2 `regList'
reg comm2 `regList'

gen herdDiff = herd2 - herd1
gen goodDiff = good2 - good1
gen badDiff = bad2 - bad1
gen selfDiff = self2 - self1
gen commDiff = comm2 - comm1

reg herdDiff `regList'
reg goodDiff `regList'
reg badDiff `regList'
reg selfDiff `regList'
reg commDiff `regList'

/*
reg herd1 datenum
reg good1 datenum
reg bad1 datenum
reg self1 datenum
reg comm1 datenum

reg herd2 datenum
reg good2 datenum
reg bad2 datenum
reg self2 datenum
reg comm2 datenum

reg herdDiff datenum
reg goodDiff datenum
reg badDiff datenum
reg selfDiff datenum
reg commDiff datenum

gen wtp_good_self_1 = good1 / self1
gen wtp_good_comm_1 = good1 / comm1
gen wtp_bad_self_1 = bad1 / self1
gen wtp_bad_comm_1 = bad1 / comm1
gen wtp_herd_self_1 = herd1 / self1
gen wtp_herd_comm_1 = herd1 / comm1

gen wtp_good_self_2 = good2 / self2
gen wtp_good_comm_2 = good2 / comm2
gen wtp_bad_self_2 = bad2 / self2
gen wtp_bad_comm_2 = bad2 / comm2
gen wtp_herd_self_2 = herd2 / self2
gen wtp_herd_comm_2 = herd2 / comm2

reg wtp_good_self_1 `regList'
reg wtp_good_comm_1 `regList'
reg wtp_bad_self_1 `regList'
reg wtp_bad_comm_1 `regList'
reg wtp_herd_self_1 `regList'
reg wtp_herd_comm_1 `regList'

reg wtp_good_self_2 `regList'
reg wtp_good_comm_2 `regList'
reg wtp_bad_self_2 `regList'
reg wtp_bad_comm_2 `regList'
reg wtp_herd_self_2 `regList'
reg wtp_herd_comm_2 `regList'

gen wtp_good_self_diff = wtp_good_self_2 - wtp_good_self_1
gen wtp_good_comm_diff = wtp_good_comm_2 - wtp_good_comm_1
gen wtp_bad_self_diff = wtp_bad_self_2 - wtp_bad_self_1
gen wtp_bad_comm_diff = wtp_bad_comm_2 - wtp_bad_comm_1
gen wtp_herd_self_diff = wtp_herd_self_2 - wtp_herd_self_1
gen wtp_herd_comm_diff = wtp_herd_comm_2 - wtp_herd_comm_1

reg wtp_good_self_diff `regList'
reg wtp_good_comm_diff `regList'
reg wtp_bad_self_diff `regList'
reg wtp_bad_comm_diff `regList'
reg wtp_herd_self_diff `regList'
reg wtp_herd_comm_diff `regList'
