# For vs Map
library(tictoc)
library(tidyverse)

# https://r4ds.had.co.nz/iteration.html

df <- tibble(
  a = rnorm(100000),
  b = rnorm(100000),
  c = rnorm(100000),
  d = rnorm(100000)
)

mean(df$a)
mean(df$b)
mean(df$c)
mean(df$d)


tic();
for(i in seq_along(df)) {
  print(
    paste(
      mean(df[[i]])
      )
    )
}; toc()

tic();map(df, mean);toc()