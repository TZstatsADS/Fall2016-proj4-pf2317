library(rhdf5)
library(pbapply)
library(dplyr)

get.features <- function(files.list, dir.h5){
  features <- pblapply(files.list, function(x, dir){
    
    file <- paste0(dir, x)
    h5f <- h5dump(file, load = TRUE)
    
    analysis <- h5f$analysis
    
    bars_confidence_mean <- mean(analysis$bars_confidence)
    bars_confidence_median <- median(analysis$bars_confidence)
    bars_confidence_sd <- sd(analysis$bars_confidence) 
    
    bars_start_mean <- mean(analysis$bars_start)
    bars_start_median <- median(analysis$bars_start) 
    bars_start_sd <- sd(analysis$bars_start) 
    
    beats_confidence_mean <- mean(analysis$beats_confidence)
    beats_confidence_median <- median(analysis$beats_confidence) 
    beats_confidence_sd <- sd(analysis$beats_confidence) 
    
    beats_start_mean <- mean(analysis$beats_start) 
    beats_start_median <- median(analysis$beats_start) 
    beats_start_sd <- sd(analysis$beats_start) 
    
    sections_confidence_mean <- mean(analysis$sections_confidence)
    sections_confidence_median <- median(analysis$sections_confidence)  
    sections_confidence_sd <- sd(analysis$sections_confidence)
    
    sections_start_mean <- mean(analysis$sections_start) 
    sections_start_median <- median(analysis$sections_start) 
    sections_start_sd <- sd(analysis$sections_start) 
    
    segments_confidence_mean <- mean(analysis$segments_confidence) 
    segments_confidence_median <- median(analysis$segments_confidence) 
    segments_confidence_sd <- sd(analysis$segments_confidence)
    
    segments_loudness_max_mean <- mean(analysis$segments_loudness_max) 
    segments_loudness_max_median <- median(analysis$segments_loudness_max) 
    segments_loudness_max_sd <- sd(analysis$segments_loudness_max) 
    
    segments_loudness_max_time_mean <- mean(analysis$segments_loudness_max_time) 
    segments_loudness_max_time_median <- median(analysis$segments_loudness_max_time)
    segments_loudness_max_time_sd <- sd(analysis$segments_loudness_max_time) 
    
    segments_loudness_start_mean <- mean(analysis$segments_loudness_start) 
    segments_loudness_start_median <- median(analysis$segments_loudness_start)
    segments_loudness_start_sd <- sd(analysis$segments_loudness_start) 
    
    segments_pitches_mean <- mean(analysis$segments_pitches)
    segments_pitches_median <- median(analysis$segments_pitches) 
    segments_pitches_sd <- sd(analysis$segments_pitches) 
    
    segments_start_mean <- mean(analysis$segments_start) 
    segments_start_median <- mean(analysis$segments_start) 
    segments_start_sd <- sd(analysis$segments_start) 
    
    segments_timbre_mean <- mean(analysis$segments_timbre) 
    segments_timbre_median <- median(analysis$segments_timbre) 
    segments_timbre_sd <- sd(analysis$segments_timbre)
    
    tatums_confidence_mean <- mean(analysis$tatums_confidence) 
    tatums_confidence_median <- median(analysis$tatums_confidence)
    tatums_confidence_sd <- sd(analysis$tatums_confidence) 
    
    tatums_start_mean <- mean(analysis$tatums_start)
    tatums_start_median <- median(analysis$tatums_start)
    tatums_start_sd <- sd(analysis$tatums_start) 
    
    song <- substr(x, start = 12, stop = nchar(x)-3)
    H5close()
    
    return(c(song, 
             bars_confidence_mean, bars_confidence_median, bars_confidence_sd, 
             bars_start_mean, bars_start_median, bars_start_sd, 
             beats_confidence_mean, beats_confidence_median, beats_confidence_sd, 
             beats_start_mean, beats_start_median, beats_start_sd, 
             sections_confidence_mean, sections_confidence_median, sections_confidence_sd, 
             sections_start_mean, sections_start_median, sections_start_sd,  
             segments_confidence_mean, segments_confidence_median, segments_confidence_sd,
             segments_loudness_max_mean, segments_loudness_max_median, segments_loudness_max_sd, 
             segments_loudness_max_time_mean, segments_loudness_max_time_median, segments_loudness_max_time_sd, 
             segments_loudness_start_mean, segments_loudness_start_median, segments_loudness_start_sd, 
             segments_pitches_mean, segments_pitches_median, segments_pitches_sd, 
             segments_start_mean, segments_start_median, segments_start_sd, 
             segments_timbre_mean, segments_timbre_median, segments_timbre_sd, 
             tatums_confidence_mean, tatums_confidence_median, tatums_confidence_sd, 
             tatums_start_mean, tatums_start_median, tatums_start_sd 
    ))
  },
  dir = dir.h5
  )
  
  # Transform list into a data frame
  features.df <- data.frame(matrix(unlist(features),byrow = TRUE, ncol = 46))
  names(features.df) <- c('song', 
                          'bars_confidence_mean', 'bars_confidence_median', 'bars_confidence_sd',
                          'bars_start_mean', 'bars_start_median', 'bars_start_sd',
                          'beats_confidence_mean', 'beats_confidence_median', 'beats_confidence_sd',
                          'beats_start_mean', 'beats_start_median', 'beats_start_sd',
                          'sections_confidence_mean', 'sections_confidence_median', 'sections_confidence_sd',
                          'sections_start_mean', 'sections_start_median', 'sections_start_sd',
                          'segments_confidence_mean', 'segments_confidence_median', 'segments_confidence_sd',
                          'segments_loudness_max_mean', 'segments_loudness_max_median', 'segments_loudness_max_sd',
                          'segments_loudness_max_time_mean', 'segments_loudness_max_time_median', 'segments_loudness_max_time_sd',
                          'segments_loudness_start_mean', 'segments_loudness_start_median', 'segments_loudness_start_sd', 
                          'segments_pitches_mean', 'segments_pitches_median', 'segments_pitches_sd', 
                          'segments_start_mean', 'segments_start_median', 'segments_start_sd',
                          'segments_timbre_mean', 'segments_timbre_median', 'segments_timbre_sd',
                          'tatums_confidence_mean', 'tatums_confidence_median', 'tatums_confidence_sd',
                          'tatums_start_mean', 'tatums_start_median', 'tatums_start_sd'
  )
  features.df[,1] <- as.character(features.df[,1])
  for (i in 2:46){features.df[,i] <- as.numeric(features.df[,i])}
  
  # replace na with 0
  features.df[is.na(features.df)] <- 0
  return(features.df)
}