pacman::p_load(tidyverse, rvest, xml2)

link <- "https://rvest.tidyverse.org/articles/starwars.html"

starwars <- read_html(link)

films <- starwars |> 
  html_elements("section")

title <- films |> 
  html_element("h2") |> 
  html_text2()

episode <- films |> 
  html_element("h2") |> 
  html_attr("data-id") |> 
  as.integer()

starwars |> 
  html_elements("div.crawl") |> 
  html_text2()
