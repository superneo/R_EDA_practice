# get_raw_data.R
#
# Purpose: to retrieve KMA/TWC SPF raw data
#
# Author: superneo (superneo77@gmail.com)
# License: TBD
#
# Date: 2020-04
#
# Version: 1.0
# Version history:
#   1.0  initial version
#
# ==============================================================================

if("here" %in% rownames(installed.packages()) == FALSE) {
    install.packages("here")
}

library(here)

get_whole_KMA_data <- function() {
    raw_root <- paste0(here(), '/data/KMA_raw_data')
    df1 <- read.csv(paste0(raw_root,
                           "/SEOUL_2000_2009_OBS_ASOS_DD_20200427153022.csv"))
    str(df1)
    assign("KMA_read", TRUE, envir = .GlobalEnv)
}

get_KMA_data <- function(year_start, year_end) {
    if (year_start > year_end) {
        print(paste0("[ERROR] year_start(", year_start,
                     ") exceeds year_end(", year_end, ")"))
        return (-1)
    }

    #
}

# ====  TESTS  =================================================================

if (TRUE) {
    print(paste('Project root:', here()))
    get_whole_KMA_data()
    get_KMA_data(2019, 2018)
}
