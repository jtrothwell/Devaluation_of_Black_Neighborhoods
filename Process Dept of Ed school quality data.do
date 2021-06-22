insheet using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\ccd_sch_029_1516_w_2a_011717.csv", clear
keep schid ncessch sch_name mzip mzip4 lzip lzip4
save "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\ccd_sch_029_1516_w_2a_011717.dta", replace

use "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\tract_scores.dta", clear
gen ncessch=NCESSCH
destring ncessch, replace 
merge m:1 ncessch using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\ccd_sch_029_1516_w_2a_011717.dta"

gen scoreH=TOTAL_passed_H/ TOTAL_total
gen scoreL=TOTAL_passed_L/ TOTAL_total
egen score= rowmean(scoreH scoreL)

collapse (count) n_schools=scoreH (mean) score2016=score, by(lzip)
ren lzip zip
format fip %05.0f
save "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\test_Scores_by_zip.dta", replace
