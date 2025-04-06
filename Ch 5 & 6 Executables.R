# Create the tibble with non-syntactic column names
weird <- tibble(
  `alpha-beta` = 1:10,
  `gamma delta` = (`alpha-beta` * 3) + rnorm(length(`alpha-beta`))
)

# a. Extract the variable called `alpha-beta`
weird$`alpha-beta`

# b. Plot a scatterplot of `alpha-beta` vs. `gamma delta`
ggplot(weird, aes(x = `alpha-beta`, y = `gamma delta`)) + 
  geom_point()

# c. Create a new column called `theta`, which is `gamma delta` divided by `alpha-beta`
weird <- weird |> mutate(`theta` = `gamma delta` / `alpha-beta`)

# d. Rename the columns to `alpha_beta`, `gamma_delta`, and `theta`
weird <- weird |> rename(alpha_beta = `alpha-beta`, gamma_delta = `gamma delta`)
