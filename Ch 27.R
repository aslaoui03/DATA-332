#Chapter 27: 
#Exercise 27.2.4

# Sample vector for testing
x <- c(10, 5, NA, 8, 7, NA, 2, 1)

# 1a) Elements at even-numbered positions
even_positions <- function(vec) {
  vec[seq(2, length(vec), by = 2)]
}
even_positions(x)
#> [1]  5  8 NA  1

#1b) Every element except the last value
except_last <- function(vec) {
  vec[-length(vec)]
}
except_last(x)
#> [1] 10  5 NA  8  7 NA  2

# 1c) Only even values (excluding missing values)
even_values_no_na <- function(vec) {
  vec[!is.na(vec) & vec %% 2 == 0]
}
even_values_no_na(x)
#> [1] 10  8  2

# 2) Why is x[-which(x > 0)] not the same as x[x <= 0]?

# Let's check both in action:
x
#> [1] 10  5 NA  8  7 NA  2  1

# Removes positions where x > 0 is TRUE (ignores NAs)
x[-which(x > 0)]
#> [1] NA NA

# Logical filter removes values that are > 0 or NA
x[x <= 0]
#> [1] NA NA

#Explanation:
# which(x > 0) returns indices where x > 0 is TRUE, ignoring NAs
# x[-which(...)] removes those indices but keeps NAs untouched
# x[x <= 0] uses logical filtering; NA <= 0 is NA (not TRUE), so NA is excluded unless explicitly handled

#so that means:

#   - `which()` ignores NAs
#   - Logical filtering with `x[...]` treats NA as NA in condition


#Exercise 27.3.4

# 1) [[ with index too large or missing name
l <- list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1, -5)
)

# a) What happens with an index > length of list?
l[[5]]
#> Error in l[[5]] : subscript out of bounds
# The list `l` only has 4 elements, so accessing the 5th causes an error.

# b) What happens with a non-existent name?
l[["nonexistent"]]
#> NULL
# Unlike [[1]], [[name]] returns NULL if the name is not found — *no error*.

# 2) What would pepper[[1]][1] and pepper[[1]][[1]] be?
# Create pepper shaker list analogy
pepper <- list(
  packet1 = c("pepper", "salt"),
  packet2 = c("cumin", "paprika")
)

# a) pepper[[1]][1]
pepper[[1]][1]
#> [1] "pepper"
# pepper[[1]] extracts the first packet: c("pepper", "salt")
# Then [1] gives the first element — still a vector (same type).

# b) pepper[[1]][[1]]
pepper[[1]][[1]]
#> [1] "pepper"
# Same result in this case, but note:
# [ ] always returns a vector; [[ ]] always extracts the *element* (same type, scalar if atomic)

# Visual clarity:
str(pepper[[1]][1])   # => character vector of length 1
str(pepper[[1]][[1]]) # => same, but uses [[ to extract it directly
