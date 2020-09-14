# Bykov's R - Public Diplomacy with Twitter around post-Soviet States
# Some info about 'rtweet' https://docs.ropensci.org/rtweet/

# Check your working directory
getwd()
# If necessary, set your working directory
# setwd("/home/...")

# If necessary, install packages
install.packages("rtweet") 
install.packages("ggplot2")
install.packages("dplyr")

# Load package packages in operating memory
library("rtweet")
library("ggplot2")
library("dplyr")

# Check if the package has been loaded
search()

# Read the twits file
rus <- get_timeline("MFA_Russia", n = 3200)

# View data
View(rus)

# If necessary, save data to csv-file
rus = as.matrix(rus)
write.csv(rus, file = "rus.csv")

# plot time series of tweets
rus %>%
  ts_plot("3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of tweets made by MFA_Russia",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# Get timelines of 
tmls <- get_timelines(c("MFA_Russia", "MFA_Ukraine", "LithuaniaMFA", "mfa_kz"), n = 3200)

# plot frequency of tweets for each user over time
	tmls %>%
	  dplyr::filter(created_at > "2020-06-15") %>%
	  dplyr::group_by(screen_name) %>%
	  ts_plot("days", trim = 1L) +
	  ggplot2::geom_point() +
	  ggplot2::theme_minimal() +
	  ggplot2::theme(
	    legend.title = ggplot2::element_blank(),
	    legend.position = "bottom",
	    plot.title = ggplot2::element_text(face = "bold")) +
	  ggplot2::labs(
	    x = NULL, y = NULL,
	    title = "Россия, Литва, Украина и Казахстан",
	    subtitle = "Количество постов в день",
	    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
	  )

# If necessary, save data to csv-file
tmls = as.matrix(tmls)
write.csv(tmls, file = "tmls.csv")