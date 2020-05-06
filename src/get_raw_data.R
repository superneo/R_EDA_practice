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

if ("here" %in% rownames(installed.packages()) == FALSE) {
    install.packages("here")
}

library(here)

KMA_read <- FALSE
df_KMA <- NULL

get_whole_KMA <- function() {
    if (KMA_read && !is.null(df_KMA)) {
        print("KMA dataframe is ready already!")
        return(df_KMA)
    }

    raw_root <- paste0(here(), '/data/KMA_raw_data')
    df1 <- read.csv(paste0(raw_root,
                           "/SEOUL_2000_2009_OBS_ASOS_DD_20200427153022.csv"))
    df2 <- read.csv(paste0(raw_root,
                           "/SEOUL_2010_2019_OBS_ASOS_DD_20200427151516.csv"))
    df3 <- read.csv(paste0(raw_root,
                           "/SEOUL_2020_2020_OBS_ASOS_DD_20200427152808.csv"))
    df <- rbind(rbind(df1, df2), df3)
    str(df)
    assign("df_KMA", df, envir = .GlobalEnv)
    assign("KMA_read", TRUE, envir = .GlobalEnv)

    return(df_KMA)
}

get_partial_KMA <- function(year_start, year_end) {
    if (!KMA_read || is.null(df_KMA)) {
        print("KMA dataframe must be ready in advance!")
        return(NULL)
    }

    if (year_start > year_end) {
        print(paste0("[ERROR] year_start(", year_start,
                     ") exceeds year_end(", year_end, ")"))
        return(NULL)
    }

    if (year_start < 2000 || year_end > 2020) {
        print("[ERROR] 2000 <= yeart_start and year_end <= 2020")
        return(NULL)
    }

    years <- unlist(lapply(year_start:year_end, as.character))
    idcs <- lapply(df_KMA[,3],
                   function(x) { sum(startsWith(x, years)) > 0 })
    subframe <- df_KMA[unlist(idcs),]
    rownames(subframe) <- NULL

    return(subframe)
}

# ====  TESTS  =================================================================

if (TRUE) {
    print(paste('Project root:', here()))
    get_whole_KMA()
    get_partial_KMA(2019, 2018)
}
