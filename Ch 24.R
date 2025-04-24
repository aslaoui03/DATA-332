# Load required packages
library(rvest)
library(tibble)
library(dplyr)
library(stringr)
library(readr)
library(tidyr)

# 24.4 - Minimal HTML example
html <- minimal_html("
  <p>This is a paragraph</p>
  <ul>
    <li>This is a bulleted list</li>
  </ul>
")

# 24.4.1 - Finding elements with CSS selectors
html |> html_elements("p")
html <- minimal_html("
  <h1>This is a heading</h1>
  <p id='first'>This is a paragraph</p>
  <p class='important'>This is an important paragraph</p>
")
html |> html_elements("p")
html |> html_elements(".important")
html |> html_elements("#first")
html |> html_element("p")
html |> html_elements("b")
html |> html_element("b")

# 24.4.2 - Nesting selections
html <- minimal_html("
  <ul>
    <li><b>C-3PO</b> is a <i>droid</i> that weighs <span class='weight'>167 kg</span></li>
    <li><b>R4-P17</b> is a <i>droid</i></li>
    <li><b>R2-D2</b> is a <i>droid</i> that weighs <span class='weight'>96 kg</span></li>
    <li><b>Yoda</b> weighs <span class='weight'>66 kg</span></li>
  </ul>
")
characters <- html |> html_elements("li")
characters |> html_element("b") |> html_text2()
characters |> html_element(".weight") |> html_text2()
characters |> html_elements(".weight")

# 24.4.3 - Extracting attributes
html <- minimal_html("
  <p><a href='https://en.wikipedia.org/wiki/Cat'>cats</a></p>
  <p><a href='https://en.wikipedia.org/wiki/Dog'>dogs</a></p>
")
html |> html_elements("p") |> html_element("a") |> html_attr("href")

# 24.4.4 - HTML tables
html <- minimal_html("
  <table class='mytable'>
    <tr><th>x</th><th>y</th></tr>
    <tr><td>1.5</td><td>2.7</td></tr>
    <tr><td>4.9</td><td>1.3</td></tr>
    <tr><td>7.2</td><td>8.1</td></tr>
  </table>
")
html |> html_element(".mytable") |> html_table()

# 24.6.1 - Star Wars scraping
url <- "https://rvest.tidyverse.org/articles/starwars.html"
html <- read_html(url)
section <- html |> html_elements("section")

tibble(
  title = section |> html_element("h2") |> html_text2(),
  released = section |> html_element("p") |> html_text2() |>
    str_remove("Released: ") |> parse_date(),
  director = section |> html_element(".director") |> html_text2(),
  intro = section |> html_element(".crawl") |> html_text2()
)

# 24.6.2 - IMDb Top 250 scraping
url <- "https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/"
html <- read_html(url)
table <- html |> html_element("table") |> html_table()

ratings <- table |>
  select(rank_title_year = `Rank & Title`, rating = `IMDb Rating`) |>
  mutate(rank_title_year = str_replace_all(rank_title_year, "\n +", " ")) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  )

# Add extra data from html_attr("title")
ratings <- ratings |>
  mutate(
    rating_n = html |> html_elements("td strong") |> html_attr("title")
  ) |>
  separate_wider_regex(
    rating_n,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(number = parse_number(number))

# Display the final IMDb dataset
print(ratings)
