
<!-- README.md is generated from README.Rmd. Please edit that file -->
Replication code and data for: "The heterogeneous relationship between income and inequality: a panel co-integration approach"
==============================================================================================================================

[Svenja Flechtern](http://www.svenjaflechtner.de/) and [Claudius Gräbner](https://claudius-graebner.com/)

Published as: Flechtner, S. and Gräbner, C. (2019): The heterogeneous relationship between income and inequality: a panel co-integration approach, *Economics Bulletin*, DOI: [xxx](xxx) (open access).

Description of code
-------------------

The dataset used in the paper gets recreated from the raw data as it can be downloaded from the web via `R/create_dataset.R` (see below).

The estimation results can be replicated via the Stata code in `stata/do-file_Flechtner_Graebner_2019_gdp-ineq-cointegration-short`.

The visualizations and the country classification table can be replicated using the R code in `R/cointegration-results-analysis.R`.

The Stata code has been written by Svenja Flechtner, the R code by Claudius Gräbner.

All code assumes the working directory to be organized as in this Github repo.

Description of results
----------------------

The file `output/cointegration_results` summarizes the results in a readable way. The csv version is used as an input for the visualization in the paper.

It contains the following variables:

<table>
<colgroup>
<col width="11%" />
<col width="88%" />
</colgroup>
<thead>
<tr class="header">
<th>Column</th>
<th align="center">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>country</td>
<td align="center">country name abbreviation as in dataset</td>
</tr>
<tr class="even">
<td>id</td>
<td align="center">id created during analysis (see stata do-file)</td>
</tr>
<tr class="odd">
<td>gini_mkt_coeff</td>
<td align="center">coefficient obtained from PDOLS estimator for market gini; see stata do-file. recovered from stata log file <code>stata/logfile_ginimarketln-GDPpercapitaln</code></td>
</tr>
<tr class="even">
<td>gini_disp_coeff</td>
<td align="center">coefficient obtained from PDOLS estimator for disposable gini; see stata do-file. recovered from stata log file <code>stata/logfile_ginidispln-GDPpercapitaln</code></td>
</tr>
<tr class="odd">
<td>gini_mkt_t</td>
<td align="center">t statistic for coefficient obtained from PDOLS estimator for market gini; see stata do-file. recovered from stata log file <code>output/logfile_ginimarketln-GDPpercapitaln</code></td>
</tr>
<tr class="even">
<td>gini_disp_t</td>
<td align="center">t statistic for coefficient obtained from PDOLS estimator for disposable gini; see stata do-file. recovered from stata log file <code>stata/logfile_ginidispln-GDPpercapitaln</code></td>
</tr>
<tr class="odd">
<td>gini_mkt_t_abs</td>
<td align="center">absolute value of <code>gini_mkt_t</code></td>
</tr>
<tr class="even">
<td>gini_disp_t_abs</td>
<td align="center">absolute value of <code>gini_disp_t</code></td>
</tr>
<tr class="odd">
<td>no_obs</td>
<td align="center">number of observations</td>
</tr>
<tr class="even">
<td>df</td>
<td align="center">degrees of freedom</td>
</tr>
<tr class="odd">
<td>critical_value</td>
<td align="center">Critical values of Student's t distribution with respective number of degrees of freedom for <code>alpha=0.975</code></td>
</tr>
<tr class="even">
<td>gini_mkt_sign5</td>
<td align="center">dummy variable with 1 if <code>gini_mkt_t_abs</code> &gt;= critival_value, 0 otherwise</td>
</tr>
<tr class="odd">
<td>gini_disp_sign5</td>
<td align="center">dummy variable with 1 if <code>gini_disp_t_abs</code> &gt;= critival_value, 0 otherwise</td>
</tr>
</tbody>
</table>

Description of data
-------------------

The dataset gets recreated via `R/create_dataset.R`. Here we assume you have dowloaded the [Penn World Table](https://www.rug.nl/ggdc/productivity/pwt/) 9.1 (downloaded September 17, 2019, named `data/pwt91.dta`) and the [Standardized World Income Inequality Database](https://fsolt.org/swiid/) (downloaded September 17, 2019, named `data/swiid.dta`).

<table style="width:99%;">
<colgroup>
<col width="12%" />
<col width="36%" />
<col width="33%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th>Variable</th>
<th align="center">Description</th>
<th align="center">Unit</th>
<th align="center">Source</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>country</td>
<td align="center">The iso3 country code</td>
<td align="center">iso3c</td>
<td align="center"><a href="https://unstats.un.org/unsd/tradekb/knowledgebase/country-code">Info</a></td>
</tr>
<tr class="even">
<td>year</td>
<td align="center">The year of observation</td>
<td align="center">year</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td>gdp_pc_chppp</td>
<td align="center">Per-capita income (expenditure-side)</td>
<td align="center">Real GDP at chained PPP</td>
<td align="center"><a href="https://www.rug.nl/ggdc/productivity/pwt/">Penn World tables 9.1</a></td>
</tr>
<tr class="even">
<td>gini_solt_disp</td>
<td align="center">Post-tax inequality</td>
<td align="center">Gini index</td>
<td align="center"><a href="https://doi.org/10.7910/DVN/LM4OWF">SWIID Version 8.1</a></td>
</tr>
<tr class="odd">
<td>gini_solt_mkt</td>
<td align="center">Pre-tax inequality</td>
<td align="center">Gini index</td>
<td align="center"><a href="https://doi.org/10.7910/DVN/LM4OWF">SWIID Version 8.1</a></td>
</tr>
</tbody>
</table>

The dataset relevant to reproduce the results is `data/dataset.csv`. The file `data/dataset_raw.csv` is created directly from the raw data and only excludes countries with less than 26 observations. I still contains those without a unit root in their Gini time series. As explained in the paper, these countries have been removed before the analysis and they are not contained in the file `data/dataset.csv` any more. See the file `R/create_dataset.R` for details, and the file `stata/do-file_Flechtner_Graebner_2019_gdp-ineq-cointegration-short_country_unitroots` for the respective unit root tests.

### Descriptive statistics on the sample level

| key                          |     value|
|:-----------------------------|---------:|
| First observation            |   1960.00|
| Last observation             |   2017.00|
| Total number of observations |   3522.00|
| GDP per capita (mean)        |  15362.78|
| GDP per capita (sd)          |  15449.62|
| Post-tax gini (mean)         |     36.78|
| Post-tax gini (sd)           |      8.82|
| Pre-tax gini (mean)          |     45.74|
| Pre-tax gini (sd)            |      6.55|

### Descriptive statistics on the country level

| country             | period    |    n|  GDPpc\_mean|  GDPpc\_sd|  GINIdisp\_mean|  GINIdisp\_sd|  GINImkt\_mean|  GINImkt\_sd|
|:--------------------|:----------|----:|------------:|----------:|---------------:|-------------:|--------------:|------------:|
| Argentina           | 1961-2017 |   57|      8444.26|    5250.34|           39.62|          3.65|          40.51|         2.88|
| Armenia             | 1990-2017 |   28|      5655.97|    2588.70|           37.39|          2.06|          48.57|         1.27|
| Australia           | 1967-2016 |   50|     30132.92|    9359.38|           29.79|          2.38|          44.11|         3.66|
| Austria             | 1983-2017 |   35|     34377.57|    9894.65|           26.60|          1.68|          44.33|         4.11|
| Belgium             | 1979-2016 |   38|     31175.27|    8300.94|           25.00|          1.24|          46.62|         2.69|
| Bangladesh          | 1964-2016 |   53|      1552.67|     536.29|           31.41|          1.92|          37.64|         1.39|
| Bulgaria            | 1989-2017 |   29|     11706.67|    4002.07|           32.27|          1.61|          36.34|         0.59|
| Belarus             | 1990-2017 |   28|     12235.19|    3888.21|           24.02|          0.59|          32.34|         0.95|
| Brazil              | 1960-2017 |   58|      7281.30|    3793.45|           50.32|          2.43|          58.86|         2.21|
| Botswana            | 1985-2015 |   31|      9662.21|    3656.94|           58.25|          0.59|          64.35|         0.62|
| Canada              | 1969-2017 |   49|     31939.30|    8021.50|           29.70|          1.42|          43.56|         2.52|
| Switzerland         | 1980-2015 |   36|     42641.49|    9246.72|           29.76|          1.19|          40.01|         0.51|
| Chile               | 1968-2017 |   50|     11165.09|    5703.41|           46.64|          1.40|          51.58|         1.01|
| China               | 1978-2015 |   38|      4864.58|    3156.10|           35.93|          5.78|          38.83|         6.13|
| Côte d’Ivoire       | 1985-2015 |   31|      2440.58|     275.71|           40.55|          0.47|          45.49|         0.52|
| Colombia            | 1970-2017 |   48|      7761.95|    2224.59|           50.73|          1.05|          53.13|         1.00|
| Costa Rica          | 1961-2017 |   57|      8633.46|    3075.80|           42.65|          2.07|          45.78|         2.33|
| Cyprus              | 1985-2016 |   32|     26286.10|    6014.07|           29.91|          0.33|          47.41|         0.99|
| Czechia             | 1990-2016 |   27|     24297.70|    4917.98|           24.34|          1.68|          43.44|         2.14|
| Germany             | 1960-2016 |   57|     25766.22|   10898.62|           27.07|          1.33|          44.87|         4.43|
| Denmark             | 1976-2017 |   42|     32156.90|    8677.44|           23.79|          1.30|          44.42|         2.17|
| Dominican Republic  | 1986-2016 |   31|      8080.40|    2918.68|           46.09|          1.45|          48.45|         1.19|
| Egypt               | 1975-2015 |   41|      4157.13|    2869.22|           37.56|          2.38|          42.92|         2.54|
| Spain               | 1974-2016 |   43|     22297.42|    8259.73|           31.82|          1.39|          45.47|         2.86|
| Estonia             | 1990-2016 |   27|     17025.31|    7216.35|           33.45|          1.63|          48.33|         1.38|
| Finland             | 1966-2017 |   52|     26348.12|    9612.00|           23.12|          1.93|          43.64|         3.42|
| Fiji                | 1977-2013 |   37|      5741.31|     805.40|           41.15|          1.14|          44.15|         0.92|
| France              | 1962-2016 |   55|     25380.96|    8204.36|           29.15|          1.18|          47.60|         1.07|
| United Kingdom      | 1961-2017 |   57|     24783.06|    9480.48|           30.55|          3.37|          47.25|         5.89|
| Georgia             | 1990-2017 |   28|      5877.69|    3121.20|           36.85|          2.36|          47.39|         2.27|
| Greece              | 1974-2016 |   43|     20054.23|    6057.13|           34.42|          1.41|          49.51|         1.37|
| Guatemala           | 1981-2014 |   34|      4684.20|    1143.23|           49.06|          2.15|          50.74|         2.15|
| Hong Kong SAR China | 1964-2016 |   53|     26631.18|   15785.85|           38.82|          1.56|          43.78|         2.17|
| Honduras            | 1988-2017 |   30|      3389.88|     510.98|           49.56|          1.42|          49.63|         0.89|
| Croatia             | 1990-2016 |   27|     15410.80|    5144.75|           27.34|          1.04|          43.66|         0.87|
| Hungary             | 1970-2017 |   48|     14600.07|    6234.95|           25.36|          2.61|          46.83|         4.33|
| India               | 1973-2012 |   40|      1898.12|    1016.42|           40.51|          3.76|          43.86|         3.01|
| Ireland             | 1973-2017 |   45|     29395.38|   17683.28|           30.90|          1.15|          49.39|         1.44|
| Iran                | 1969-2016 |   48|      8027.91|    5094.69|           42.70|          3.16|          46.05|         2.89|
| Israel              | 1979-2017 |   39|     26875.45|    6689.32|           33.74|          2.31|          48.18|         2.62|
| Jamaica             | 1988-2015 |   28|      6095.00|     973.91|           41.37|          0.43|          42.80|         0.29|
| Jordan              | 1986-2014 |   29|      5104.72|    2172.69|           36.54|          1.34|          40.98|         1.46|
| Japan               | 1961-2015 |   55|     23823.97|   10470.25|           27.72|          2.74|          39.07|         3.43|
| Kazakhstan          | 1990-2017 |   28|     12692.70|    6624.78|           28.32|          2.03|          36.44|         2.03|
| Kenya               | 1976-2015 |   40|      2125.27|     231.93|           46.27|          1.83|          51.88|         1.92|
| South Korea         | 1965-2017 |   53|     15676.64|   11941.71|           29.44|          1.34|          31.85|         1.44|
| Sri Lanka           | 1970-2016 |   47|      4592.56|    2684.15|           44.39|          3.78|          43.27|         2.02|
| Lithuania           | 1990-2016 |   27|     16120.13|    6731.05|           32.44|          2.06|          49.85|         2.74|
| Luxembourg          | 1985-2016 |   32|     65345.61|   21503.00|           26.31|          1.77|          43.37|         3.10|
| Morocco             | 1984-2014 |   31|      4824.66|    1072.70|           39.60|          0.22|          44.30|         0.22|
| Moldova             | 1990-2017 |   28|      3334.31|    1218.45|           36.38|          2.08|          55.32|         1.07|
| Madagascar          | 1962-2012 |   51|      1366.55|     194.73|           42.70|          0.87|          47.06|         1.14|
| Mexico              | 1963-2016 |   54|     11799.48|    2894.60|           48.09|          2.44|          49.09|         2.20|
| Mauritania          | 1987-2014 |   28|      2342.31|     426.41|           38.46|          2.00|          43.49|         2.10|
| Mauritius           | 1987-2012 |   26|     13131.90|    2315.10|           36.64|          0.19|          40.41|         0.10|
| Malawi              | 1969-2016 |   48|      1089.92|     149.60|           47.00|          2.42|          51.84|         2.28|
| Malaysia            | 1970-2016 |   47|     11619.42|    6385.47|           44.21|          2.40|          47.77|         2.60|
| Netherlands         | 1977-2016 |   40|     33795.46|    9744.72|           25.66|          1.05|          45.77|         0.98|
| Norway              | 1970-2017 |   48|     35930.93|   15466.27|           24.66|          1.33|          41.99|         2.48|
| Nepal               | 1977-2010 |   34|      1107.19|     272.21|           38.89|          1.48|          43.40|         1.41|
| New Zealand         | 1982-2017 |   36|     26681.40|    6116.67|           31.25|          2.26|          45.09|         2.04|
| Pakistan            | 1964-2015 |   52|      2577.75|     870.10|           34.15|          0.36|          36.71|         0.45|
| Panama              | 1970-2017 |   48|      9551.02|    4841.43|           49.53|          1.48|          53.62|         1.43|
| Peru                | 1972-2017 |   46|      5802.47|    2687.42|           51.03|          3.11|          54.41|         3.31|
| Philippines         | 1961-2015 |   55|      3564.05|    1264.07|           42.50|          0.83|          47.39|         0.81|
| Poland              | 1983-2016 |   34|     14259.19|    6319.32|           29.35|          2.34|          46.86|         4.28|
| Portugal            | 1968-2016 |   49|     16948.30|    7491.68|           33.47|          0.63|          51.76|         0.84|
| Qatar               | 1988-2013 |   26|     66222.66|   46789.69|           39.18|          0.39|          43.57|         0.47|
| Romania             | 1989-2016 |   28|     11762.35|    5442.18|           29.76|          3.96|          40.09|         4.43|
| Rwanda              | 1984-2016 |   33|      1089.50|     326.06|           42.98|          4.49|          49.02|         4.95|
| Sudan               | 1970-2009 |   40|      1705.41|     422.89|           37.54|          0.93|          41.44|         0.74|
| Singapore           | 1973-2017 |   45|     35482.87|   24028.72|           38.04|          1.08|          42.53|         1.44|
| Sierra Leone        | 1969-2011 |   43|      1211.08|     192.09|           42.98|          2.10|          47.66|         2.04|
| El Salvador         | 1991-2017 |   27|      4992.34|    1377.81|           43.53|          3.35|          45.40|         2.43|
| Slovakia            | 1990-2016 |   27|     19327.05|    5875.30|           24.11|          2.74|          41.49|         2.18|
| Slovenia            | 1990-2016 |   27|     24398.73|    4984.25|           23.78|          0.87|          39.36|         1.72|
| Sweden              | 1960-2017 |   58|     27982.98|   10052.60|           25.78|          4.41|          46.57|         3.35|
| Thailand            | 1962-2017 |   56|      6360.32|    4517.71|           42.51|          1.73|          46.33|         1.89|
| Tunisia             | 1985-2015 |   31|      7888.48|    1979.38|           39.42|          1.52|          43.96|         1.55|
| Turkey              | 1987-2017 |   31|     14550.38|    5319.38|           42.00|          1.42|          44.91|         0.70|
| Taiwan              | 1964-2017 |   54|     21815.52|   14473.78|           28.16|          1.68|          29.81|         1.97|
| Tanzania            | 1969-2015 |   47|      1528.16|     427.83|           41.50|          1.96|          39.76|         1.03|
| Uganda              | 1989-2016 |   28|      1266.95|     344.48|           40.73|          0.68|          46.24|         0.77|
| Uruguay             | 1981-2017 |   37|     12235.05|    4086.30|           39.25|          1.70|          49.91|         2.00|
| United States       | 1961-2017 |   57|     36387.70|   11636.65|           34.28|          2.55|          45.92|         3.36|
| South Africa        | 1975-2015 |   41|      9396.51|    1393.29|           59.23|          0.47|          67.15|         1.19|
| Zambia              | 1976-2015 |   40|      1839.75|     823.82|           52.41|          0.98|          58.35|         1.20|

### Citations for the data

Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015): The Next Generation of the Penn World Table, *American Economic Review*, Vol. 105(10), 3150-3182, available for download at [www.ggdc.net/pwt](www.ggdc.net/pwt)

Solt, Frederick (2019): *Measuring Income Inequality Across Countries and Over Time: The Standardized World Income Inequality Database*, SWIID Version 8.1, May 2019.
