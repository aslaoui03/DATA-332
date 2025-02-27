sudo xcodebuild - license accept
demo()
q()
help()
library(tidyverse)
library(tidyverse)
installed.packages(tidyverse)
installed.packages("tidyverse")
library(tidyverse)
installed.packages("tidyverse")
install.packages("tidyverse")
library(tidyverse)
library(palmerpenguins)
library(ggthemes)
penguins
ggplot(data = penguins)
ggplot ()
ggplot (data =penguins, mapping = aes(x=flipper_length_mm, y= body_mass_g))
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()
glimpse(penguins)
?penguins
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point()
ggplot(
  +     data = penguins,
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point()
  ggplot(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
    geom_point() + geom_smooth(method = "lm")
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point() + geom_smooth(method = "lm")
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point() + geom_boxplot()
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point() + geom_violin()
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point() + geom_jitter()
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point() + geom_boxplot()
  ggplot(data = penguins) +
    geom_point()
  ?geom_point()
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point(na.rm = TRUE) + geom_boxplot(na.rm = TRUE)
  ?labs()
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point(na.rm = TRUE) + geom_boxplot(na.rm = TRUE) + labs(caption = "Data come from the palmerpenguins package.")
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point(na.rm = TRUE) + geom_boxplot(na.rm = TRUE) + fig.cap ="Data come from the palmerpenguins package."
  ggplot(
    data = penguins,
    mapping = aes(x = species, y = bill_depth_mm)
  ) +
    geom_point(na.rm = TRUE) + geom_boxplot(na.rm = TRUE) + labs(caption = "Data come from the palmerpenguins package.") + theme(plot.caption = element_text(hjust = 0.5))
  penguins
  ggplot(data = penguins)
  geom_point(na.rm = TRUE) + geom_boxplot(na.rm = TRUE) + fig.cap ="Data come from the palmerpenguins package."
  View(penguins)
  View(penguins)
  View(penguins)
  ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
    geom_point(aes(color = bill_depth_mm)) +
    geom_smooth(color = "blue", method = "loess") +
    scale_color_gradient(low = "blue", high = "black") +
    theme_minimal()
  ggplot
  library(ggplot2)
  library(tidyverse)
  library(palmerpenguins)
  library(ggthemes)
  penguins
  ggplot(data=penguins)
  ggplot()
  ggplot (data =penguins, mapping = aes(x=flipper_length_mm, y= body_mass_g))
  ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
    geom_point(aes(color = bill_depth_mm)) +
    geom_smooth(color = "blue", method = "loess") +
    scale_color_gradient(low = "blue", high = "black") +
    theme_minimal()
  ggplot(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
  ) +
    geom_point() +
    geom_smooth(se = FALSE)
  ggplot(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
    geom_point() +
    geom_smooth()
  ggplot() +
    geom_point(
      data = penguins,
      mapping = aes(x = flipper_length_mm, y = body_mass_g)
    ) +
    geom_smooth(
      data = penguins,
      mapping = aes(x = flipper_length_mm, y = body_mass_g)
    )
  ggplot(penguins, aes(x = species)) +
    geom_bar()
  ggplot(penguins, aes(x = fct_infreq(species))) +
    geom_bar()
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_histogram(binwidth = 200)
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_histogram(binwidth = 20)
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_histogram(binwidth = 2000)
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_histogram(binwidth = 2000)
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_histogram(binwidth = 20)
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_histogram(binwidth = 20)
  ggplot(penguins, aes(x = body_mass_g)) +
    geom_density()
  ggplot(penguins, aes(y= species))+ geom_bar()
  ggplot(penguins, aes(x = species)) +
    geom_bar(color = "red")
  ggplot(penguins, aes(x = species)) +
    geom_bar(fill = "red")
  ?geom_histogram()
  ?geom_histogram()
  ?geom_histogram()
  ?mpg
  library (ggplot2)
  ggplot(mpg, aes (x = displ, y = hwy)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, color = cty)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, size = cty)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, size = cty, color =cty)) + geom_point()
  ggplot(mpg, aes(x = displ, y = hwy, shape = class)) +
    geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, linewidth = 0.5)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, linewidth = 5)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, linewidth = 0.3)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, linewidth = 1000)) + geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, linewidth = cty)) + geom_point()
  ggplot(mpg, aes(x = displ, y = hwy, linewidth = class)) +
    geom_point()
  ggplot(mpg, aes (x = displ, y = hwy, linewidth = cty)) + geom_point()
  ggplot(mpg, aes(x = displ, y = hwy, color = class, size = cty)) +
    geom_point()
  ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point()
  ggplot(
    data = penguins,
    mapping = aes(
      x = bill_length_mm, y = bill_depth_mm,
      color = species, shape = species
    )
  ) +
    geom_point() +
    labs(color = "Species")
  ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_point(aes(color = species)) +
    facet_wrap(~ species)
  ggplot(
    data = penguins,
    mapping = aes(
      x = bill_length_mm, y = bill_depth_mm,
      color = species, shape = species
    )
  ) +
    geom_point() +
    labs(color = "Species")
  ggplot(penguins, aes(x = island, fill = species)) +
    geom_bar(position = "fill")
  ggplot(penguins, aes(x = species, fill = island)) +
    geom_bar(position = "fill")
  ggplot(penguins, aes(x = island, fill = species)) +
    geom_bar(position = "fill")
  ggplot(penguins, aes(x = species, fill = island)) +
    geom_bar(position = "fill")
  ggplot(mpg, aes(x = class)) +
    geom_bar()
  ggplot(mpg, aes(x = class)) +
    geom_bar()
  ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_point()
  ggsave("mpg-plot.png")
  ggplot(mpg, aes(x = class)) +
    geom_bar()
  ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_point()
  ggsave("mpg-plot.pdf")
  libary(todyverse)
  libary(tidyverse)
  savehistory("~/executables1and2.Rhistory")