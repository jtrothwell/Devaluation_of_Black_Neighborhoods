use "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\replication_data\track_level_database.dta", clear

bysort CBSA: egen irank=rank(W3000_medHHI_E), track
bysort CBSA: egen nrank=count(W3000_medHHI_E)
gen iratio=(irank/nrank)*100
xtile bin=iratio, nq(10)
xtile bin20=iratio, nq(20)

gen lnrelative_track_value =ln(relative_track_value )
tab exposure, gen(black_level)

tab bin
cor W3000_medHHI_E bin iratio
label var bin "Within-MSA track income decile"
label var bin "Within-MSA track income rank in 20 groups"

STOP

***
**Appendix Table--**MAIN MODELS--CENSUS
set more off
areg lnvalue D1000_blacknh_P, ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model.xls", excel adjr2 dec(4) label replace
di 50*_b[D1000_blacknh_P]

areg lnvalue D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E , ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model.xls", excel adjr2 dec(4) label 
di 50*_b[D1000_blacknh_P]

areg lnvalue D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 ///
school_quality, ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model.xls", excel adjr2 dec(4) label 
di 50*_b[D1000_blacknh_P]

*ZILLOW
set more off
areg lnmed_list_sqft2012_2016 D1000_blacknh_P, ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model.xls", excel adjr2 dec(4) label 

areg lnmed_list_sqft2012_2016 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E , ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model.xls", excel adjr2 dec(4) label 

areg lnmed_list_sqft2012_2016 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality, ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model.xls", excel adjr2 dec(4) label 
di 50*_b[D1000_blacknh_P]

*Apppendix Table 2. Regression of home values with education and income
areg lnvalue D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
D1200_withBAdegree_P W3000_medHHI_E , ab(CBSA) cl(CBSA)
di 50*_b[D1000_blacknh_P]
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_with_Education_Income.xls", excel adjr2 dec(4) label  replace

areg lnmed_list_sqft2012_2016 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
D1200_withBAdegree_P W3000_medHHI_E , ab(CBSA) cl(CBSA)
di 50*_b[D1000_blacknh_P]
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_with_Education_Income.xls", excel adjr2 dec(4) label 

areg lnvalue bin D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 ///
school_quality, ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_with_Education_Income.xls", excel adjr2 dec(4) label 
di 50*_b[D1000_blacknh_P]

areg lnmed_list_sqft2012_2016 bin D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality, ab(CBSA) cl(CBSA)
di 50*_b[D1000_blacknh_P]
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_with_Education_Income.xls", excel adjr2 dec(4) label 
di 50*_b[D1000_blacknh_P]

*Crime
label var jail_pooled_male_mean "Percent of men ever incarcerated"
areg lnmed_list_sqft2012_2016 jail_pooled_male_mean D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality, ab(CBSA) cl(CBSA)
di 50*_b[D1000_blacknh_P]
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_with_Incarceration.xls", excel adjr2 dec(4) label  replace

areg lnmed_list_sqft2012_2016  jail_pooled_male_p25 kfr_pooled_pooled_p25 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality, ab(CBSA) cl(CBSA)
di 50*_b[D1000_blacknh_P]
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_with_Incarceration.xls", excel adjr2 dec(4) label 

**AEI income bins
erase "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin.xls"
erase "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin.txt"

STOP

*AEI By bin
forval i=1/10 {
areg lnmed_list_sqft2012_2016 D1000_blacknh_P    ///
if bin==`i', ab(CBSA) cl(CBSA)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin_placebo.xls", excel adjr2 dec(4) label 
}

forval i=1/10 {
areg lnmed_list_sqft2012_2016 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
if bin==`i', ab(CBSA) cl(CBSA)
gen bin`i'= _b[D1000_blacknh_P]
gen SE_bin`i'= _se[D1000_blacknh_P]
gen T_bin`i'=bin`i'/SE_bin`i'

gen rooms`i'= _b[h2110_medrooms]
gen SE_rooms`i'= _se[h2110_medrooms]
gen T_rooms`i'=rooms`i'/SE_rooms`i'

gen sch`i'= _b[school_quality]
gen SE_sch`i'= _se[school_quality]
gen T_sch`i'=sch`i'/SE_sch`i'

outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin.xls", excel adjr2 dec(4) label 
}

keep bin1 SE_bin1 T_bin1 rooms1 SE_rooms1 T_rooms1 sch1 SE_sch1 T_sch1 bin2 SE_bin2 T_bin2 rooms2 SE_rooms2 T_rooms2 sch2 SE_sch2 T_sch2 bin3 SE_bin3 T_bin3 rooms3 SE_rooms3 T_rooms3 sch3 SE_sch3 T_sch3 bin4 SE_bin4 T_bin4 rooms4 SE_rooms4 T_rooms4 sch4 SE_sch4 T_sch4 bin5 SE_bin5 T_bin5 rooms5 SE_rooms5 T_rooms5 sch5 SE_sch5 T_sch5 bin6 SE_bin6 T_bin6 rooms6 SE_rooms6 T_rooms6 sch6 SE_sch6 T_sch6 bin7 SE_bin7 T_bin7 rooms7 SE_rooms7 T_rooms7 sch7 SE_sch7 T_sch7 bin8 SE_bin8 T_bin8 rooms8 SE_rooms8 T_rooms8 sch8 SE_sch8 T_sch8 bin9 SE_bin9 T_bin9 rooms9 SE_rooms9 T_rooms9 sch9 SE_sch9 T_sch9 bin10 SE_bin10 T_bin10 rooms10 SE_rooms10 T_rooms10 sch10 SE_sch10 T_sch10 
keep bin* room* sch*
keep in 1
gen n=1
reshape long  bin rooms sch, i(n) j(income)

set obs 11
replace income = 0 in 11
replace bin = -.0046 in 11
replace rooms = .2457 in 11
replace sch = .37 in 11
replace bin=bin*50

graph dot (mean) bin rooms sch , over(income) ///
marker(1, msize(small) msymbol(Oh) mcolor(blue*.7)) ///
marker(2, msize(small) msymbol(Dh) mcolor(red*.7)) ///
marker(3, msize(small) msymbol(O) mcolor(green*.7)) ///
legend(order(1 "Majority Black" 2 "Additional room" 3 "School proficiency" )  region(style(none))  rows(1) span)  ///
blabel(bar, gap(*1.25) position(inside) format(%9.2f) size(small)) ///
title("Effect of majority black status and other variables" "on home values by income decile", span) ///
ytitle("Effect on home values") ///
note("Note: Coefficient of regression models predicting log of median home values overall" "and by track income decile using preferred structural model." "Source: Perry, Rothwell, Harshbarger database. Bin 0 represents all bins. Home value is price/sq foot from Zillow", span) ///
plotregion(color(white)) graphregion(color(white)) yline(0)  
graph export "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Effects_by_Income_Bins.png", replace
graph export "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Effects_by_Income_Bins.pdf", replace

**AEI replication
*AEI By bin--single control
erase "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin_single_replicate.xls"
erase "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin_single_replicate.txt"

tab exposure, gen(black_level)
areg lnmed_list_sqft2012_2016  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P, ab(CBSA) cl(CBSA)

forval i=1/10 {
areg lnmed_list_sqft2012_2016  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin==`i', ab(CBSA) cl(CBSA)
gen bin`i'= _b[black_level6]
gen SE_bin`i'= _se[black_level6]
gen T_bin`i'=bin`i'/SE_bin`i'

outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin_single_replicate.xls", excel adjr2 dec(4) label 
}

drop bin
keep bin1 SE_bin* T_bin* bin*
keep bin* 
keep in 1
gen n=1
reshape long  bin , i(n) j(income)

set obs 11
replace income = 0 in 11
replace bin = -.33 in 11

graph dot (mean) bin  , over(income) ///
marker(1, msize(small) msymbol(Oh) mcolor(blue*.7)) ///
marker(2, msize(small) msymbol(Dh) mcolor(red*.7)) ///
marker(3, msize(small) msymbol(O) mcolor(green*.7)) ///
legend(order(1 "Majority Black" 2 "Additional room" 3 "School proficiency" )  region(style(none))  rows(1) span)  ///
blabel(bar, gap(*1.25) position(inside) format(%9.2f) size(small)) ///
title("Effect of majority black status and other variables" "on home values by income decile", span) ///
ytitle("Effect on home values") ///
note("Note: Coefficient of regression models predicting log of median home values overall" "and by track income decile using AEI's preferred structural model." "Only control variable is share of families with single moms." "Source of data: Perry, Rothwell, Harshbarger database. Bin 0 represents all bins. Home value is price/sq foot from Zillow", span) ///
plotregion(color(white)) graphregion(color(white)) yline(0)  
graph export "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Effects_by_Income_Bins_single_replicate.png", replace
graph export "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Effects_by_Income_Bins_single_replicate.pdf", replace

***Fixed effects regeression--AEI replication--20 group
*AEI By bin--single control
erase "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin20_single_replicate.xls"
erase "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin20_single_replicate.txt"

egen Zlnvalue=std(lnvalue)
egen ZRlnvalue=std(lnvalue) if bin20>=7 & bin20<=12

*with original controls
reghdfe lnmed_list_sqft2012_2016 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
, ab(CBSA bin) vce(cl CBSA bin)
di 50*_b[D1000_blacknh_P]

reghdfe lnvalue D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
, ab(CBSA bin) vce(cl CBSA bin)
di 50*_b[D1000_blacknh_P]

reghdfe lnmed_list_sqft2012_2016 D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin20)
di 50*_b[D1000_blacknh_P]

reghdfe lnvalue D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 school_quality ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin20)
di 50*_b[D1000_blacknh_P]

tab bin20
sum  lnvalue if bin20>=8 & bin20<=12
sum  lnvalue if (bin20<8 | bin20>12) & bin20!=.
di 9,961/29,461
di 5/21

*with AEI controls
reghdfe lnrelative_track_value  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin) vce(cl CBSA bin)
reghdfe lnmed_list_sqft2012_2016  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin) vce(cl CBSA bin)
reghdfe lnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin) vce(cl CBSA bin)
reghdfe Zlnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin) vce(cl CBSA bin)

*restrict bins
reghdfe lnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if relative_track_value>=.7 & relative_track_value<=1.1, ab(CBSA bin) vce(cl CBSA bin)

*middle class bins
reghdfe lnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin)
reghdfe lnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin)
reghdfe Zlnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin)
reghdfe ZRlnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin)
reghdfe lnmed_list_sqft2012_2016 black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20>=8 & bin20<=12, ab(CBSA bin) vce(cl CBSA bin)

sum Zlnvalue lnvalue 
sum Zlnvalue lnvalue if bin20>=7 & bin20<=12

*not-middle class bins
reghdfe lnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20<7 | bin20>12, ab(CBSA bin) vce(cl CBSA bin)
reghdfe Zlnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20<7 | bin20>12, ab(CBSA bin) vce(cl CBSA bin)

reghdfe lnvalue black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20<7 | bin20>12, ab(CBSA bin) vce(cl CBSA bin)


sum relative_track_value

outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_Simple_by_Bine.xls", excel adjr2 dec(4) label  replace
reghdfe lnvalue  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin) vce(cl CBSA bin)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_Simple_by_Bine.xls", excel adjr2 dec(4) label 
reghdfe lnmed_list_sqft2012_2016  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin20) vce(cl CBSA bin20)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_Simple_by_Bine.xls", excel adjr2 dec(4) label 
reghdfe lnvalue  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
, ab(CBSA bin20) vce(cl CBSA bin20)
outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_Simple_by_Bine.xls", excel adjr2 dec(4) label 

**full model with income bins
reghdfe  lnvalue D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 ///
school_quality, ab(CBSA bin20) vce(cl CBSA bin20)
di 50*_b[D1000_blacknh_P]

**full model with income bins
reghdfe  lnmed_list_sqft2012_2016   D1000_blacknh_P   ///
h2110_medrooms h2110_medyear H2110_1unitsdet_E H2110_1unitsatt_E  H2110_mobilehome_E H2110_novehicle_E  ///
gas_elect H2110_withkitchen_E  ///
W1110_meancommute_E W1110_carpooled_P W1110_pubtrans_P pct_owner ///
lnpop D3100_kidsunder18_P D3110_kidsunder18_P D1000_medianage_E ///
WI_weighted MV_est54  MV_est51912 MV_est712 MV_est722 MV_est447 ///
school_quality, ab(CBSA bin20) vce(cl CBSA bin20)
di 50*_b[D1000_blacknh_P]


forval i=1/20 {
areg lnmed_list_sqft2012_2016  black_level2 black_level3 black_level4 black_level5 black_level6  D3110_kidsunder18_P ///
if bin20==`i', ab(CBSA) cl(CBSA)
gen bin20`i'= _b[black_level6]
gen SE_bin20`i'= _se[black_level6]
gen T_bin20`i'=bin20`i'/SE_bin20`i'

outreg2 using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Track_Level_Property_Devaluation_Model_AEI_by_bin20_single_replicate.xls", excel adjr2 dec(4) label 
}

drop bin bin20
keep bin201 SE_bin20* T_bin20* bin20*
keep bin20* 
keep in 1
gen n=1
reshape long  bin20 , i(n) j(income)

set obs 21
replace income = 0 in 21
replace bin = -.33 in 21

graph dot (mean) bin20  , over(income) ///
marker(1, msize(small) msymbol(Oh) mcolor(blue*.7)) ///
marker(2, msize(small) msymbol(Dh) mcolor(red*.7)) ///
marker(3, msize(small) msymbol(O) mcolor(green*.7)) ///
legend(order(1 "Majority Black" 2 "Additional room" 3 "School proficiency" )  region(style(none))  rows(1) span)  ///
blabel(bar, gap(*1.25) position(inside) format(%9.2f) size(small)) ///
title("Effect of majority black status and other variables" "on home values by 20 income groups", span) ///
ytitle("Effect on home values") ///
note("Note: Coefficient of regression models predicting log of median home values overall" "and by track income decile using AEI's preferred structural model with 20 groups." "Only control variable is share of families with single moms." "Source of data: Perry, Rothwell, Harshbarger database. Bin 0 represents all bins." "Home value is price/sq foot from Zillow", span) ///
plotregion(color(white)) graphregion(color(white)) yline(0)  
graph export "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Effects_by_Income_Bins20_single_replicate.png", replace
graph export "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\output\Effects_by_Income_Bins20_single_replicate.pdf", replace
