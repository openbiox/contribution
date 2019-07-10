## code to prepare `demo` dataset goes here
demo <- dplyr::tribble(
  ~Class, ~WWP, ~NAS, ~TM,
  "Designed research", NA, "Major", "Major",
  "Performed research", NA, "Major", NA,
  "Developed tool", "Major", "Minor", NA,
  "Analyzed data", "Major", "Minor", "Minor",
  "Wrote the paper", "Major", "Minor", "Major"
)

usethis::use_data(demo, overwrite = TRUE)
