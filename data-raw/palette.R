## code to prepare `palette` dataset goes here
## Source https://github.com/williambelle/github-contribution-color-graph

# Themes from GitHub
github      = c('#ffffff', '#c6e48b', '#7bc96f', '#239a3b', '#196127')
halloween   = c('#ffffff', '#fdf156', '#ffc722', '#ff9711', '#04001b')

# Themes from Material design
amber       = c('#ffffff', '#ffecb3', '#ffd54f', '#ffb300', '#ff6f00')
blue        = c('#ffffff', '#bbdefb', '#64b5f6', '#1e88e5', '#0d47a1')
bluegrey    = c('#ffffff', '#cfd8dc', '#90a4ae', '#546e7a', '#263238')
brown       = c('#ffffff', '#d7ccc8', '#a1887f', '#6d4c41', '#3e2723')
cyan        = c('#ffffff', '#b2ebf2', '#4dd0e1', '#00acc1', '#006064')
deeporange  = c('#ffffff', '#ffccbc', '#ff8a65', '#f4511e', '#bf360c')
deeppurple  = c('#ffffff', '#d1c4e9', '#9575cd', '#5e35b1', '#311b92')
green       = c('#ffffff', '#c8e6c9', '#81c784', '#43a047', '#1b5e20')
grey        = c('#ffffff', '#e0e0e0', '#9e9e9e', '#616161', '#212121')
indigo      = c('#ffffff', '#c5cae9', '#7986cb', '#3949ab', '#1a237e')
lightblue   = c('#ffffff', '#b3e5fc', '#4fc3f7', '#039be5', '#01579b')
lightgreen  = c('#ffffff', '#dcedc8', '#aed581', '#7cb342', '#33691e')
lime        = c('#ffffff', '#f0f4c3', '#dce775', '#c0ca33', '#827717')
orange      = c('#ffffff', '#ffe0b2', '#ffb74d', '#fb8c00', '#e65100')
pink        = c('#ffffff', '#f8bbd0', '#f06292', '#e91e63', '#880e4f')
purple      = c('#ffffff', '#e1bee7', '#ba68c8', '#8e24aa', '#4a148c')
red         = c('#ffffff', '#ffcdd2', '#e57373', '#e53935', '#b71c1c')
teal        = c('#ffffff', '#b2dfdb', '#4db6ac', '#00897b', '#004d40')
yellowMd    = c('#ffffff', '#fff9c4', '#fff176', '#ffd835', '#f57f17')

# Theme from Me
unicorn     = c('#ffffff', '#6dc5fb', '#f6f68c', '#8affa4', '#f283d1')
summer      = c('#ffffff', '#eae374', '#f9d62e', '#fc913a', '#ff4e50')
sunset      = c('#ffffff', '#fed800', '#ff6f01', '#fd2f24', '#811d5e')

# Theme from MoonAntonio
moon        = c('#ffffff', '#6bcdff', '#00a1f3', '#48009a', '#4f2266')
psychedelic = c('#ffffff', '#faafe1', '#fb6dcc', '#fa3fbc', '#ff00ab')
yellow      = c('#ffffff', '#d7d7a2', '#d4d462', '#e0e03f', '#ffff00')


palette = dplyr::tibble(
  github = github,
  halloween = halloween,
  amber = amber,
  blue = blue,
  bluegrey = bluegrey,
  brown = brown,
  cyan = cyan,
  deeporange = deeporange,
  deeppurple = deeppurple,
  green = green,
  grey = grey,
  indigo = indigo,
  lightblue = lightblue,
  lightgreen = lightgreen,
  lime = lime,
  orange = orange,
  pink = pink,
  purple = purple,
  red = red,
  teal = teal,
  yellowMd = yellowMd,
  unicorn = unicorn,
  summer = summer,
  sunset = sunset,
  moon = moon,
  psychedelic = psychedelic,
  yellow = yellow
)

usethis::use_data(palette, overwrite = TRUE)
