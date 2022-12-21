/* clear 

use rand_coeffs_time_dce2

rename herd herd2
rename good good2
rename bad bad2
//rename alltime alltime2
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
//rename alltime alltime1
//rename comm comm1
rename alltime alltime1

rename id coeffid

sort coeffid
save rand_coeffs_time_dce1, replace

*/

clear 

use rand_coeffs_pooled_time_dce2

merge coeffid using rand_coeffs_pooled_time_dce1

drop _merge

sort coeffid

merge coeffid using fullDataTable

merge 1:1 hhid using hhid_sex, keepusing(sex) generate(sex_merge)
drop sex_merge

replace ourpasturelandusenowwillaffectth = "Agree" in 103

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


replace sex_n = 0 if sex_n == 2
rename sex_n female

local regList datenum herd_size age female workMale workFemale i.main_animal i.enumerator // q1_predce q2_predce q3_predce q4_predce

reg herd1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef) replace
reg good1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg bad1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg alltime1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)

reg herd2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg good2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg bad2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg alltime2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)

gen herdDiff = herd2 - herd1
gen goodDiff = good2 - good1
gen badDiff = bad2 - bad1
gen alltimeDiff = alltime2 - alltime1


reg herdDiff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg goodDiff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg badDiff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg alltimeDiff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)

/*
reg herd1 datenum
outreg2 using prefReg.xls, stats(coef)
reg good1 datenum
outreg2 using prefReg.xls, stats(coef)
reg bad1 datenum
outreg2 using prefReg.xls, stats(coef)
reg alltime1 datenum
outreg2 using prefReg.xls, stats(coef)

reg herd2 datenum
outreg2 using prefReg.xls, stats(coef)
reg good2 datenum
outreg2 using prefReg.xls, stats(coef)
reg bad2 datenum
outreg2 using prefReg.xls, stats(coef)
reg alltime2 datenum
outreg2 using prefReg.xls, stats(coef)

reg herdDiff datenum
outreg2 using prefReg.xls, stats(coef)
reg goodDiff datenum
outreg2 using prefReg.xls, stats(coef)
reg badDiff datenum
outreg2 using prefReg.xls, stats(coef)
reg alltimeDiff datenum
outreg2 using prefReg.xls, stats(coef)
*/

gen wtp_good_alltime_1 = good1 / alltime1 

gen wtp_bad_alltime_1 = bad1 / alltime1  

gen wtp_herd_alltime_1 = - herd1/ alltime1  


gen wtp_good_alltime_2 = good2 / alltime2  

gen wtp_bad_alltime_2 = bad2 / alltime2  

gen wtp_herd_alltime_2 = - herd2 / alltime2  


reg wtp_good_alltime_1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef) 
reg wtp_bad_alltime_1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg wtp_herd_alltime_1 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)

reg wtp_good_alltime_2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg wtp_bad_alltime_2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg wtp_herd_alltime_2 `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)

gen wtp_good_alltime_diff = wtp_good_alltime_2 - wtp_good_alltime_1

gen wtp_bad_alltime_diff = wtp_bad_alltime_2 - wtp_bad_alltime_1

gen wtp_herd_alltime_diff = wtp_herd_alltime_2 - wtp_herd_alltime_1


reg wtp_good_alltime_diff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg wtp_bad_alltime_diff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)
reg wtp_herd_alltime_diff `regList', cluster(selectthevillageyouarein)
outreg2 using prefReg.xls, stats(coef)

save quest_plus_DCE_coeffs_pooled_time, replace
