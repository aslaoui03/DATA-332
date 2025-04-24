#Chapter 22 
#Exercices 22.5.3


library(curl)
library(arrow)
library(dplyr)

# Create data/ folder if it doesn't exist
if (!dir.exists("data")) dir.create("data")

# Download the CSV file (~9GB — be patient!)
curl::curl_download(
  url = "https://r4ds.s3.us-west-2.amazonaws.com/seattle-library-checkouts.csv",
  destfile = "data/seattle-library-checkouts.csv"
)

# Open the CSV dataset using Arrow
seattle_csv <- open_dataset(
  sources = "data/seattle-library-checkouts.csv",
  format = "csv"
)

# Convert and partition to Parquet (partitioned by CheckoutYear)
write_dataset(
  seattle_csv |> group_by(CheckoutYear),
  path = "data/seattle-library-checkouts",
  format = "parquet"
)

# Load the Parquet dataset
seattle_pq <- open_dataset("data/seattle-library-checkouts")

# Exercise 1: Most popular book each year
seattle_pq |> 
  filter(MaterialType == "BOOK") |> 
  group_by(CheckoutYear, Title) |> 
  summarise(TotalCheckouts = sum(Checkouts), .groups = "drop") |> 
  arrange(CheckoutYear, desc(TotalCheckouts)) |> 
  distinct(CheckoutYear, .keep_all = TRUE)

# Exercise 2: Author with the most books
seattle_pq |> 
  filter(!is.na(Creator), MaterialType == "BOOK") |> 
  group_by(Creator) |> 
  summarise(NumBooks = n_distinct(Title), .groups = "drop") |> 
  arrange(desc(NumBooks)) |> 
  slice_head(n = 1)

# Exercise 3: Book vs Ebook checkout trends (2013–2022)
seattle_pq |> 
  filter(CheckoutYear >= 2013, MaterialType %in% c("BOOK", "EBOOK")) |> 
  group_by(CheckoutYear, MaterialType) |> 
  summarise(TotalCheckouts = sum(Checkouts), .groups = "drop") |> 
  arrange(CheckoutYear, MaterialType)

