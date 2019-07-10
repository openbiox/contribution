## code to prepare `demo` dataset goes here
demo <- dplyr::tribble(
  ~Class, ~WWP, ~NAS, ~TM,
  "Designed research", NA, "Many", "Many",
  "Performed research", NA, "Many", NA,
  "Developed tool", "Many", "Some", NA,
  "Analyzed data", "Many", "Some", "Some",
  "Wrote the paper", "Many", "Some", "Many"
)

usethis::use_data(demo)
