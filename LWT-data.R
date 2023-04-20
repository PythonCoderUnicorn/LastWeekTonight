
library(tidyverse)
library(ggforce)
library(lubridate)
library(showtext)
library(paletteer)
library(ggtext)

# font files on the local machine.
theme_set(theme_bw(base_family = "Raleway"))

df = read_csv("./LastWeekTonight.csv") %>% janitor::clean_names()

glimpse( df )

df = df %>% 
  mutate(
    air_date = ymd(air_date),
    us_viewers_millions = as.numeric(u_s_viewers_millions)
  ) %>% 
  select(
    season, episode, main_segment, air_date, us_viewers_millions
  )


head(df)

# is.na(df$US_viewers_millions)

df %>% 
  ggplot(
    aes(x= air_date, y=us_viewers_millions, col= us_viewers_millions)
  ) +
  geom_line(size= 0.9, show.legend = F) +
  geom_point(size=2, show.legend = F) +
  scale_x_date(date_breaks = "year",date_labels = "%Y")+
  scale_color_paletteer_c(`"ggthemes::Classic Orange-Blue"`)+
  labs(
    title = "Last Week Tonight US Viewers (millions) by Year",
    x="Year",
    y="Viewers (millions)",
    col= "millions",
    caption = "@unicornCoder | April 20, 2023 | Source: Wikipedia"
  )+
  theme(
    plot.title = element_text(face = 'bold', hjust = 0.5, size = 15),
    axis.title.x = element_text(color = 'black'),
    axis.text.x = element_text(color = 'black', size = 11, face = 'bold'),
    axis.text.y = element_text(color = 'black', size = 11, face = 'bold'),
    
    plot.caption = element_text(hjust = 0, size = 11)
  )


df %>% 
  select(us_viewers_millions, main_segment, air_date) %>% 
  arrange( desc( us_viewers_millions))


