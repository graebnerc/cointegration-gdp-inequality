# Analysis of the co-integration estimates
rm(list = ls())
library(countrycode)
library(here)
library(tidyverse)
library(data.table)

#' Create barplot
#' 
#' Creates a barplot illustrating the distribution of estimates
#' 
#' @param data_used The dataset to be used; must contain columns 'country', 
#'  'coefficient' and 'effect'
#' @param plot_title The title for the plot
#' @param index_used The index printed below the plot
#' @return ggplot2 object
make_barplot <- function(data_used, plot_title, index_used = "a") {
  barplot_obj <- ggplot(data_used) +
    geom_hline(yintercept = 0) + 
    geom_bar(aes(
      x = reorder(country, UQ(as.name("coefficient"))),
      y = UQ(as.name("coefficient")),
      fill = UQ(as.name("effect"))
    ),
    stat = "identity"
    ) +
    coord_flip() +
    scale_fill_manual(values = c("blue", "red", "green")) +
    xlab("Country") + ylab(paste0("Estimate\n(", index_used, ")")) +
    ggtitle(plot_title) +
    theme_bw() +
    theme(
      axis.line = element_blank(),
      axis.text.y = element_text(size = 6),
      axis.title.y = element_blank(),
      axis.ticks = element_blank(),
      legend.spacing.x = unit(2.0, "mm"),
      legend.title = element_blank(),
      legend.position = "bottom",
      panel.border = element_blank()
    )
  return(barplot_obj)
}

# Get estimation results-------------------------------------------------------
estimation_results <- fread(here("output/cointegration_results.csv"),
                            dec = ",", sep = ";") %>%
  select(
    one_of("country", "gini_mkt_coeff", "gini_disp_coeff", 
           "gini_disp_sign5", "gini_mkt_sign5")
    ) %>%
  filter(country!="sample") %>%
  gather(variable, coefficient, -country) %>%
  mutate(
    gini_type = ifelse(
      substr(variable, 1, 8)=="gini_mkt", "pre_tax", "post_tax"),
    var_type = ifelse(
      substr(variable, nchar(variable)-5, nchar(variable)) == "_coeff", 
      "coefficient", "effect")
    ) %>%
  select(-variable) %>%
  spread(var_type, coefficient) %>%
  mutate(
    effect=ifelse(effect=="0", "ambiguous", 
                       ifelse(coefficient>0, "positive", "negative")),
    country=countrycode(country, "iso3c", "country.name")
    )

# Market gini------------------------------------------------------------------
effect_considered <- "Long-run relationship between pre-tax Gini and GDPpc"

gini.mkt.on.gdp_plot <- make_barplot(
  filter(estimation_results, gini_type=="pre_tax"),
  effect_considered,
  "a"
)

# Disposable Gini--------------------------------------------------------------
effect_considered <- "Long-run relationship between post-tax Gini and GDPpc"

gini.disp.on.gdp_plot <- make_barplot(
  filter(estimation_results, gini_type=="post_tax"),
  effect_considered,
  "b"
)

# Full plot--------------------------------------------------------------------

full_plot <- ggpubr::ggarrange(
  gini.mkt.on.gdp_plot, gini.disp.on.gdp_plot,
  ncol = 2, nrow = 1,
  common.legend = T, legend = "bottom"
)
ggsave("output/fig_1_country-heterogeneity.pdf",
  plot = full_plot,
  width = 12, height = 8
)

# Check country groups---------------------------------------------------------
estimation_results_condensed <- estimation_results %>%
  select(-coefficient) %>%
  spread(gini_type, effect) %>%
  rename(
    post_tax_relationship_with_GDPpc=post_tax,
    pre_tax_relationship_with_GDPpc=pre_tax
    ) 

country_kinds <- capture.output(
  cat(
    "Consistently positive:\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "positive",
           pre_tax_relationship_with_GDPpc=="positive")$country,
    "\n========================================================================",
    "\nConsistently negative:\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "negative",
           pre_tax_relationship_with_GDPpc=="negative")$country,
    "\n========================================================================",
    "\n\nSignificant relationship only for pre-tax (positive):\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "ambiguous",
           pre_tax_relationship_with_GDPpc=="positive")$country,
    "\n========================================================================",
    "\n\nSignificant relationship only for pre-tax (negative):\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "ambiguous",
           pre_tax_relationship_with_GDPpc=="negative")$country,
    "\n========================================================================",
    "\n\nSignificant relationship only for post-tax (positive):\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "positive",
           pre_tax_relationship_with_GDPpc=="ambiguous")$country,
    "\n========================================================================",
    "\n\nSignificant relationship only for post-tax (negative):\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "negative",
           pre_tax_relationship_with_GDPpc=="ambiguous")$country,
    "\n========================================================================",
    "\n\nPositive relationship for post-tax, negative for pre-tax:\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "positive",
           pre_tax_relationship_with_GDPpc=="negative")$country,
    "\n========================================================================",
    "\n\nNegative relationship for post-tax, positive for pre-tax:\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "negative",
           pre_tax_relationship_with_GDPpc=="positive")$country,
    "\n========================================================================",
    "\n\nAmbiguous relationship for post-tax and pre-tax:\n",
    "------------------------------------------------------------------------\n",
    filter(estimation_results_condensed, 
           post_tax_relationship_with_GDPpc == "ambiguous",
           pre_tax_relationship_with_GDPpc=="ambiguous")$country,
    "\n========================================================================",
    collapse = NULL
  )
)
write(
  x = country_kinds,
  file = "output/table_5_country-heterogeneity.txt"
)
