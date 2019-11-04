rm(list = ls())
library(countrycode)
library(data.table)
library(tidyverse)
library(haven)
library(here)

#' Test uniqueness of data table
#'
#' Tests whether a data.table has unique rows.
#'
#' @param data_table A data frame of data table of which uniqueness should
#'  be tested.
#' @param index_vars Vector of strings, which specify the columns of
#'  data_table according to which uniqueness should be tested
#'  (e.g. country and year).
#' @return TRUE if data_table is unique, FALSE and a warning if it is not.
#' @family update_dataset_helpers
#' @import data.table
#' @export
test_uniqueness <- function(data_table, index_vars, print_pos=TRUE){
  data_table <- data.table::as.data.table(data_table)
  if (nrow(data_table)!=data.table::uniqueN(data_table, by = index_vars)){
    warning(paste0("Rows in the data.table: ", nrow(data_table),
                   ", rows in the unique data.table:",
                   data.table::uniqueN(data_table, by = index_vars)))
    return(FALSE)
  } else {
    if (print_pos){
      print(paste0("No duplicates in ", as.list(sys.call()[[2]])))
    }
    return(TRUE)
  }
}

# Get Penn World Tables 9.1----------------------------------------------------
pwt_data <- read_dta(
  here("data/pwt91.dta")
) %>%
  select(
    one_of("countrycode", "year", "pop", "rgdpe")
  ) %>%
  rename(
    country = countrycode
  ) %>%
  mutate(
    gdp_pc_chppp = rgdpe / pop,
    country = as.character(country),
    year = as.double(year)
  ) %>%
  filter(
    year >= 1960
  ) %>%
  select(-pop, -rgdpe)

# Get SWIID 8.1----------------------------------------------------------------

swiid_data <- fread(
  here("data/swiid8_1_summary.csv"),
  stringsAsFactors = F
) %>%
  select(
    one_of("country", "year", "gini_disp", "gini_mkt")
  ) %>%
  filter( # No iso3c code exists for these countries + not enough data points
    !country %in% c("Czechoslovakia", "Kosovo", "Micronesia", "Yugoslavia")
  ) %>%
  mutate(
    country = countrycode(country, "country.name", "iso3c")
  )

# Merge data-------------------------------------------------------------------
full_data <- full_join(
  pwt_data, swiid_data, by = c("country", "year")
  ) %>%
  filter(
    !is.na(gdp_pc_chppp), !is.na(gini_disp), !is.na(gini_mkt)
    )

# Take mean of duplicated Gini data for RUS between 1988 and 1990--------------
full_data_RUS <- full_data %>%
  filter(country=="RUS", year %in% 1988:1990) %>%
  group_by(country, year) %>%
  summarise_all(mean, na.rm=T) %>%
  ungroup() %>%
  mutate(gdp_pc_chppp=ifelse(is.nan(gdp_pc_chppp), NA, gdp_pc_chppp))

full_data <- full_data %>%
  filter(!(country=="RUS" & year %in% 1988:1990))
full_data <- rbind(full_data, full_data_RUS)

stopifnot(test_uniqueness(full_data, c("country", "year")))
fwrite(full_data, here("data/dataset_raw.csv"))

# Remove countries that have less than 26 subsequent observations--------------
countries_few_obs <- full_data %>%
  group_by(country) %>%
  summarise(n=n()) %>%
  ungroup() %>%
  filter(n<26)

full_data <- full_data %>%
  filter(!country %in% countries_few_obs$country)

nonsubsequent_obs <- full_data %>%
  select(country,  year) %>%
  group_by(country) %>%
  mutate(y_step=year-lag(year)) %>%
  ungroup() %>%
  filter(!is.na(y_step), 
         y_step>1)
stopifnot(nrow(nonsubsequent_obs)==0)

stopifnot(test_uniqueness(full_data, c("country", "year")))
fwrite(full_data, here("data/dataset.csv"))

# Remove countries without unit root in the Gini market series-----------------

# For the following countries we can reject H0 of having a unit root at the 
# 1% level, so they cannot be considered for the cointegration analysis:

countries_wo_unit_root <- c(
  "BRB", # Barbados
  "GHA", # Ghana
  "IDN", # Indonesia
  "KGZ", # Kyrgyzstan
  "LVA", # Latvia
  "PRY", # Paraguay
  "TJK", # Tajikistan
  "UKR", # Ukraine
  "BOL", # Bolivia
  "ECU", # Ecuador
  "ITA", # Italy
  "NGA", # Nigeria
  "RUS", # Russia
  "TTO", # Trinidad & Tobago
  "VEN") # Venezuela

full_data <- full_data %>%
  filter(
    !country %in% countries_wo_unit_root
  )

# Save dataset-----------------------------------------------------------------
stopifnot(test_uniqueness(full_data, c("country", "year")))
fwrite(full_data, here("data/dataset.csv"))

# Get descriptives-------------------------------------------------------------

descriptives <- full_data %>%
  group_by(country) %>%
  summarise(y_min=min(year),
            y_max=max(year),
            n=n(), 
            GDPpc_mean=mean(gdp_pc_chppp),
            GDPpc_sd=sd(gdp_pc_chppp),
            GINIdisp_mean=mean(gini_disp),
            GINIdisp_sd=sd(gini_disp),
            GINImkt_mean=mean(gini_mkt),
            GINImkt_sd=sd(gini_mkt)) %>%
  ungroup() %>%
  unite("period", y_min, y_max, sep = "-")

descriptives_agg <- full_data %>%
  group_by() %>%
  summarise(`First observation`=min(year),
            `Last observation`=max(year),
            `Total number of observations`=n(), 
            `GDP per capita (mean)`=mean(gdp_pc_chppp),
            `GDP per capita (sd)`=sd(gdp_pc_chppp),
            `Post-tax gini (mean)`=mean(gini_disp),
            `Post-tax gini (sd)`=sd(gini_disp),
            `Pre-tax gini (mean)`=mean(gini_mkt),
            `Pre-tax gini (sd)`=sd(gini_mkt)) %>%
  ungroup() %>%
  gather()

knitr::kable(descriptives_agg, format = "latex", align = "lc", 
             caption = "Descriptive information about the data set.",
             label = "tab:desc", digits = 2, booktabs=T) %>%
  cat(., file = here("output/table_1_descriptives-paper.tex"))
