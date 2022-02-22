
<!-- # Forest plots of relative risk {#RR-forest} -->

<!-- --- -->
<!-- output: -->
<!--   pdf_document: -->
<!--     keep_tex: yes -->
<!-- fontfamily: mathpazo -->
<!-- fontsize: 9pt -->
<!-- --- -->

<!-- \raggedright -->

<!-- ## Overview -->

<!-- __Purpose: __ These plots show all results estimated in this study. Cohort-specific results were estimated for each combination of risk factor, outcome, and age category, and then pooled with random- and fixed-effects meta-analysis models. -->
<!-- __Interpretation: __ Each plot shows all cohort-specific estimates for each isk factor, outcome,  age category, and exposure level in the same style as Extended Data Figure 1. Cohort-specific estimates are plotted on each row, comparing the risk of an exposure level to the reference level.  Below the solid horizontal line are region-specific pooled measures of association, pooled using random-effects models. Below the dashed line are overall pooled measures of association, comparing pooling using random or fixed effects models.  -->
<!-- __Implications: __ The plots show all cohort-specific estimates underlying the primary plots in the manuscript as well as the pooled random- and fixed-effects estimates. -->




<!-- (Interactive seaching and selecting of forest plots in development. Example plot shown here for the moment.) -->


<!-- ```{r setup, include=FALSE} -->
<!-- library(knitr) -->
<!-- #library(tidyverse) -->
<!-- knitr::opts_chunk$set(echo = FALSE, message=FALSE) -->
<!-- source(paste0(here::here(), "/0-config.R")) -->

<!-- d <- readRDS(file=paste0(fig_dir, "/risk-factor/figure-data/all_forest_plot_RR.RDS")) -->

<!-- #Note- need to sort plots by order of outcome variables and age categories I want here -->


<!-- ``` -->


<!-- <!-- ** [Coming soon] Will fill in with all primary forest plots - right now this page is empty due to the file size/difficuty publishing all the plots ** --> -->


<!-- <!-- Group plots by exposure --> -->

<!-- <!-- ```{r  echo=FALSE, results='asis'} --> -->

<!-- <!--   #  df <- d #%>% filter() --> -->
<!-- <!--   # #Dynamic title --> -->
<!-- <!--   # cat(paste0("#### Outcome: ",df$outcome_variable[1]," Exposure: ", df$intervention_variable[1], " Age: ",  df$agecat[1])) --> -->

<!-- <!-- ``` --> -->


<!-- ```{r, echo = FALSE, results='asis'} -->
<!-- i<-1 -->
<!-- for(i in 1:1){ -->
<!-- #for(i in 1:length(d[[4]])){ -->

<!--     cat(paste0("\n### Outcome: ",d$outcome_variable[1]," Exposure: ", d$intervention_variable[1], " Age: ",  d$agecat[1]),"\n,") -->

<!--   print(d$plot[i][[1]]) -->
<!-- } -->
<!-- ``` -->




---
title: "09-test"
output: html_document
runtime: shiny
---

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}
