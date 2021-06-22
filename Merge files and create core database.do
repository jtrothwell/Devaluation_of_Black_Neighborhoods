*insheet using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\replication_data\msa_home_values.csv", clear
*drop v4-v355
*ren cbsa CBSA
*save "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\replication_data\msa_home_values.dta", replace

use "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\master_ests03.dta", replace
destring TRACTFP, replace
format TRACTFP %11.0f
merge 1:1 TRACTFP using  "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\med_yr_built_by_tenure2016_5yr.dta"
keep if _merge==3
drop _merge
merge 1:1 TRACTFP using   "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\med_room2016_5yr.dta"
keep if _merge==3
drop _merge
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\walkability05.dta"
drop  if _merge==2
drop _merge
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\accesibility05.dta"
drop  if _merge==2
drop _merge
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\school_proficiency07.dta" 
drop  if _merge==2
drop _merge
*Zillow
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\Zillow_TRACT_MedianValuePerSqft_AllHomes.dta"
drop  if _merge==2
drop _merge
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\Zillow_TRACT_MedianListingPrice_AllHomes.dta"
drop  if _merge==2
drop _merge
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\Zillow_TRACT_MedianListingPricePerSqft_AllHomes.dta"
drop  if _merge==2
drop _merge
**County Business Patterns Revised-ZIP-ZCTA
*merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\Etablishments by Sector by Zip.dta"
*drop  if _merge==2
*drop _merge
**County Business Patterns Revised--ZCTA
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\Etablishments by Sector by ZCTA_only.dta"
drop  if _merge==2
drop _merge
**CHETTY--TRACT
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Book\Databases\Chetty\tract-mobility\merge_tract_outcomes_early.dta"
drop  if _merge==2
drop _merge

mvencode  est0 est11 est21 est22 est23 est31 est42 est44 est48 est51 est52 est53 est54 est55 est56 est61 est62 est71 est72 est81 est99 ///
est441 est442 est443 est444 est445 est446 est447 est448 est481 est712 est721 est722 est811 est812 est813 est4481 est4512 est44511 est51912, mv(0)

foreach x in est0 est11 est21 est22 est23 est31 est42 est44 est48 est51 est52 est53 est54 est55 est56 est61 est62 est71 est72 est81 est99 ///
est441 est442 est443 est444 est445 est446 est447 est448 est481 est712 est721 est722 est811 est812 est813 est4481 est4512 est44511 est51912  {
ren `x' MV_`x'
}

**County Business Patterns Revised--ZCTA
merge 1:1 TRACTFP using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\tract_data\Etablishments by Sector by ZCTA_only.dta"
drop  if _merge==2
drop _merge

gen pct_owner=H2110_total_E/H2000_total_E 
sum pct_owner
gen lnvalue=ln(H2110_medvalue_E)
gen lnpop=ln(D1000_total_E)
gen black_pop=D1000_total_E*(D1000_blacknh_P/100)
gen lnyrblt=ln(h2110_medyear)
egen school_qualityB=rowmean(TOTALSCORE_L TOTALSCORE_H)
egen school_quality=rowmean(TRACTSCORE_L TRACTSCORE_H)

foreach x in med_list_price2012_2016 med_list_sqft2012_2016  med_val_sqft2012_2016 {
gen ln`x'=ln(`x')
}

foreach x in H2110_10plusunits_E H2110_1unitsatt_E H2110_1unitsdet_E H2110_2units_E H2110_34units_E H2110_59units_E H2110_mobilehome_E H2110_novehicle_E  H2110_withelect_E H2110_withgas_E H2110_withkitchen_E H2110_withphone_E H2110_withplumbing_E {
gen `x'P=`x'/H2110_total_E
}

gen gas_elect=H2110_withgas_E +H2110_withelect_E

factor  H2110_withkitchen_E H2110_withphone_E H2110_withplumbing_E
predict factor_infra
factor vprate_mean vrate_mean prate_mean 
predict crime

factor est0 est11 est21 est22 est23 est31 est42 est44 est48 est51 est52 est53 est54 est55 est56 est61 est62 est71 est72 est81 est99 ///
est441 est442 est443 est444 est445 est446 est447 est448 est481 est721 est722 est811 est812 est813 
predict amenities amenities2 amenities3

factor MV_est4481 MV_est4512 MV_est44511 MV_est51912 MV_est712 MV_est722
predict MV_shop
factor est4481 est4512 est44511 est51912 est712 est722
predict shop

factor est441 est442 est443 est444 est445 est446 est447 est448 est481 est721 est722 est811 est812 est813 
predict store

factor est0 est11 est21 est22 est23 est31 est42 est44 est48 est51 est52 est53 est54 est55 est56 est61 est62 est71 est72 est81 est99 
predict sector

cor amenities2 amenities  amenities3 est0 est11 est21 est22 est23 est31 est42 est44 est48 est51 est52 est53 est54 est55 est56 est61 est62 est71 est72 est81 est99 ///
est441 est442 est443 est444 est445 est446 est447 est448 est481 est721 est722 est811 est812 est813 

gen micro=regexm(CBSATYPE, "Micropolitan")
drop if micro==1
drop if CBSA==""

gen b2= D1000_blacknh_P^2
gen b3= D1000_blacknh_P^3
gen b4= D1000_blacknh_P^4

gen black_L5=1 if D1000_blacknh_P<5
gen black_L10=1 if D1000_blacknh_P<10 & D1000_blacknh_P>=5
gen black_L20=1 if D1000_blacknh_P<20 & D1000_blacknh_P>=10
gen black_L30=1 if D1000_blacknh_P<30 & D1000_blacknh_P>=20
gen black_L40=1 if D1000_blacknh_P<40 & D1000_blacknh_P>=30
gen black_L50=1 if D1000_blacknh_P<50 & D1000_blacknh_P>=40
gen black_G50=1 if D1000_blacknh_P<=100 & D1000_blacknh_P>=50
gen black_L1=1 if D1000_blacknh_P<1 & D1000_blacknh_P>=0

replace black_L1=0 if D1000_blacknh_P>=1 & D1000_blacknh_P!=.
replace black_L5=0 if D1000_blacknh_P>=5 & D1000_blacknh_P!=.
replace black_L10=0 if D1000_blacknh_P>=10 | D1000_blacknh_P<5
replace black_L20=0 if D1000_blacknh_P>=20 | D1000_blacknh_P<10
replace black_L30=0 if D1000_blacknh_P>=30 | D1000_blacknh_P<20
replace black_L40=0 if D1000_blacknh_P>=40 | D1000_blacknh_P<30
replace black_L50=0 if D1000_blacknh_P>=50 | D1000_blacknh_P<40
replace black_G50=0 if D1000_blacknh_P<50

*Value by yr built
foreach x in h2110_medvalue2014_later h2110_medvalue2010_2013 h2110_medvalue2000s h2110_medvalue1990s h2110_medvalue1980s h2110_medvalue1970s h2110_medvalue1960s h2110_medvalue1950s h2110_medvalue1940s h2110_medvalue1939_earlier {
gen ln`x'=ln(`x')
areg ln`x' D1000_blacknh_P, ab(CBSA) cl(CBSA)
gen B`x'=_b[D1000_blacknh_P]
}

*Check Zillow
cor H2110_medvalue_E med_list_price2012_2016 med_list_sqft2012_2016  med_val_sqft2012_2016

**KEEP only metros with majority black tract
**Majority black
destring CBSA, replace

merge m:1 CBSA using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\results\WIDE--Assets of black neighborhoods by Metro.dta"
keep if _merge==3
drop _merge


label var lnmed_list_sqft2012_2016 "Zillow median price/sq foot" 
label var jail_pooled_male_p25 "probability of male incarceration by age 25"
label var kfr_pooled_pooled_p25 "upward mobility--measured by income at age 25" 
label var D1000_blacknh_P "Black share of tract population"
label var h2110_medrooms "median number of rooms"
label var h2110_medyear "median year built"
label var H2110_1unitsdet_E "single-family detached, percent of units"
label var H2110_1unitsatt_E  "single-family attached, percent of units" 
label var H2110_mobilehome_E "mobile home, percent of units"
label var H2110_novehicle_E  "homes with no parking, percent of units"
label var gas_elect "gas or electric heating, percent of units"
label var H2110_withkitchen_E  "percent with kitchen, percent of units"
label var W1110_meancommute_E  "mean commute time"
label var W1110_carpooled_P "percent who carpool to work"
label var W1110_pubtrans_P  "percent using public transportation"
label var pct_owner "percent who own home"
label var lnpop  "log of population"
label var D3100_kidsunder18_P "families with children under 18, percent of all"
label var D3110_kidsunder18_P "single-mother families with children under 18, percent of all"
label var D1000_medianage_E "median age"
label var WI_weighted "walkability index"
label var MV_est54  "Number of professional service businesses"
label var MV_est51912 "Number of libraries"
label var MV_est712 "Number of museums and historical sites"
label var MV_est722 "Number of food and drinking places"
label var MV_est447 "Number of eating and drinking places"
label var school_quality "Proficiency rate of 4th-8th grade public school students"

gen exposure="1. Blacks 0%-1%" if  D1000_blacknh_P>=0 & D1000_blacknh_P<1
replace exposure="2. Blacks 1%-5%" if  D1000_blacknh_P>=1 & D1000_blacknh_P<5
replace exposure="3. Blacks 5%-10%" if  D1000_blacknh_P>=5 & D1000_blacknh_P<10
replace exposure="4. Blacks 10%-20%" if  D1000_blacknh_P>=10 & D1000_blacknh_P<20
replace exposure="5. Blacks 20%-50%" if  D1000_blacknh_P>=20 & D1000_blacknh_P<50
replace exposure="6. Blacks 50% or higher" if  D1000_blacknh_P>=50

*Census
merge m:1 CBSA using "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\replication_data\msa_home_values.dta", update
drop if _merge==2
drop _merge

gen relative_track_value=H2110_medvalue_E/msa_median_home_value

save "G:\World_Poll\People\Jonathan_Rothwell\Personal_Data\BROOKINGS METRO\Andre_Perry\Housing_Paper\replication_data\track_level_database.dta", replace