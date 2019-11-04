
cap log close
clear all
set more off

************************************************************
***** Data preparation ***********************************
************************************************************

cap cd "<Insert your path here>" /* path to folder "gdp-ineq-cointegration-short" */
cap cd /Users/Shared/socio-econ/CloudStation/Paperprojekte/gdp-ineq-short/gdp-ineq-cointegration-short/
cap cd "C:\CloudStation1\CloudStation\Paperprojekte\gdp-ineq-short\gdp-ineq-cointegration-short\"

cap import delimited "./data/dataset_raw.csv"
cap import delimited ".\data\dataset_raw.csv"

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

cap log using "./output/logfile_ginimarketln-unitroots.smcl", replace
cap log using ".\output\logfile_ginimarketln-unitroots.smcl", replace

forval i = 1/102 {
	cap xtunitroot ips gini_mkt_ln if id == `i', lags(aic 5)  
	}




xtunitroot ips gini_mkt_ln if id==	1	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	2	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	3	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	4	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	5	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	6	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	7	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	8	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	9	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	10	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	11	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	12	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	13	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	14	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	15	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	16	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	17	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	18	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	19	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	20	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	21	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	22	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	23	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	24	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	25	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	26	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	27	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	28	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	29	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	30	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	31	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	32	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	33	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	34	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	35	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	36	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	37	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	38	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	39	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	40	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	41	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	42	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	43	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	44	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	45	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	46	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	47	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	48	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	49	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	50	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	51	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	52	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	53	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	54	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	55	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	56	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	57	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	58	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	59	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	60	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	61	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	62	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	63	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	64	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	65	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	66	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	67	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	68	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	69	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	70	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	71	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	72	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	73	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	74	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	75	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	76	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	77	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	78	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	79	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	80	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	81	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	82	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	83	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	84	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	85	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	86	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	87	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	88	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	89	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	90	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	91	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	92	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	93	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	94	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	95	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	96	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	97	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	98	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	99	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	100	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	101	, lags(aic 5)
xtunitroot ips gini_mkt_ln if id==	102	, lags(aic 5)
		
xtunitroot ips gini_mkt_ln if id==	1	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	2	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	3	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	4	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	5	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	6	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	7	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	8	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	9	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	10	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	11	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	12	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	13	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	14	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	15	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	16	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	17	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	18	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	19	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	20	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	21	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	22	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	23	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	24	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	25	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	26	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	27	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	28	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	29	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	30	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	31	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	32	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	33	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	34	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	35	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	36	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	37	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	38	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	39	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	40	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	41	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	42	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	43	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	44	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	45	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	46	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	47	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	48	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	49	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	50	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	51	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	52	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	53	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	54	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	55	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	56	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	57	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	58	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	59	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	60	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	61	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	62	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	63	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	64	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	65	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	66	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	67	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	68	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	69	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	70	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	71	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	72	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	73	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	74	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	75	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	76	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	77	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	78	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	79	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	80	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	81	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	82	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	83	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	84	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	85	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	86	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	87	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	88	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	89	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	90	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	91	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	92	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	93	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	94	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	95	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	96	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	97	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	98	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	99	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	100	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	101	, lags(aic 5) trend
xtunitroot ips gini_mkt_ln if id==	102	, lags(aic 5) trend
		
log close
