
* Title: do-file_Flechtner_Graebner_2019_gdp-ineq-cointegration-short.do
* Created by: Svenja Flechtner 
* Created on: 2018-10-24
* Last modified on: 2019-09-16
* Last modified by: Svenja Flechtner

*** You should have downloaded the folder "gdp-ineq-cointegration-short" with the following three subfolders:
*** 	* data
*** 	* output
***		* Stata

cap log close
clear all
set more off

************************************************************
***** Data preparation ***********************************
************************************************************

cap cd "<Insert your path here>" /* path to folder "gdp-ineq-cointegration-short" */
ap cd "C:\CloudStation1\CloudStation\Paperprojekte\gdp-ineq-short\gdp-ineq-cointegration-short\"

cap import delimited "./data/dataset.csv"
cap import delimited ".\data\dataset.csv"

*** Variables:
***			    country:		country name
***             year:	  		year
*** 			gdp_pc_chppp:  	Expenditure-side real GDP at chained PPPs from Penn World Tables, Feenstra et al (2015)
*** 			gini_disp:		Disposable Gini index, Solt (2016)
***				gini_mkt:		Market Gini index, Solt (2016)

label variable gini_disp "Disposable Gini index, Solt (2016)"
label variable gini_mkt "Market Gini index, Solt (2016)"
label variable gdp_pc_chppp "Expenditure-side real GDP at chained PPPs from Penn World Tables, Feenstra et al (2015)"

egen id = group(country)
gen gdp_pc_chppp_ln = ln(gdp_pc_chppp)
gen gini_mkt_ln=ln(gini_mkt)
gen gini_disp_ln=ln(gini_disp)

xtset id year

************************************************************
***** Gini market - GDP per capita ***********************************
************************************************************

cap log using "./output/logfile_ginimarketln-GDPpercapitaln.smcl", replace
cap log using ".\output\logfile_ginimarketln-GDPpercapitaln.smcl", replace

*** 1 Basic time-series properties: panel unit root tests - integrated of order 1?

xtunitroot ips gdp_pc_chppp_ln, lags(aic 5)
xtunitroot ips gdp_pc_chppp_ln, lags(aic 5) trend
xtunitroot ips gdp_pc_chppp_ln, lags(aic 5) demean 
xtunitroot ips gdp_pc_chppp_ln, lags(aic 5) trend demean
xtunitroot ips gini_mkt_ln, lags(aic 5)
xtunitroot ips gini_mkt_ln, lags(aic 5) trend
xtunitroot ips gini_mkt_ln, lags(aic 5) demean
xtunitroot ips gini_mkt_ln, lags(aic 5) trend demean

** 2 Are the time series cointegrated? ==> long-run relationship

xtcointtest pedroni gini_mkt_ln gdp_pc_chppp_ln
xtcointtest pedroni gini_mkt_ln gdp_pc_chppp_ln, trend
xtcointtest pedroni gini_mkt_ln gdp_pc_chppp_ln, trend ar(same)
xtcointtest westerlund gini_mkt_ln gdp_pc_chppp_ln
xtcointtest westerlund gini_mkt_ln gdp_pc_chppp_ln, allpanels

*** 3 How is long-run relationship? ==> between-dimension group-mean panel DOLS estimator

xtpedroni gdp_pc_chppp_ln gini_mkt_ln, extraobs full notest
 
log close

************************************************************
****** Gini disp - GDP per capita **********************************
************************************************************

cap log using "./output/logfile_ginidispln-GDPpercapitaln.smcl", replace
cap log using ".\output\logfile_ginidispln-GDPpercapitaln.smcl", replace

*** 1 Basic time-series properties: panel unit root tests - integrated of order 1?

xtunitroot ips gdp_pc_chppp_ln, lags(aic 5)
xtunitroot ips gdp_pc_chppp_ln, lags(aic 5) trend
xtunitroot ips gdp_pc_chppp_ln, lags(aic 5) demean
xtunitroot ips gdp_pc_chppp_ln, lags(aic 5) trend demean
xtunitroot ips gini_disp, lags(aic 5)
xtunitroot ips gini_disp, lags(aic 5) trend
xtunitroot ips gini_disp, lags(aic 5) demean
xtunitroot ips gini_disp, lags(aic 5) trend demean

** 2 Are the time series cointegrated? ==> long-run relationship

xtcointtest pedroni gini_disp_ln gdp_pc_chppp_ln
xtcointtest pedroni gini_disp_ln gdp_pc_chppp_ln, trend
xtcointtest pedroni gini_disp_ln gdp_pc_chppp_ln, trend ar(same)
xtcointtest westerlund gini_disp_ln gdp_pc_chppp_ln
xtcointtest westerlund gini_disp_ln gdp_pc_chppp_ln, allpanels

*** 3 How is long-run relationship? ==> between-dimension group-mean panel DOLS estimator

xtpedroni gdp_pc_chppp_ln gini_disp_ln, extraobs full notest

log close

