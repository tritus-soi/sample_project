## Install library tidyverse
install.packages("tidyverse")
library(tidyverse)

## Basic plot (Base R)

## Histogram  - One numeric or quantitative variable.
hist(mtcars$mpg)
hist(mtcars$hp)

mean(mtcars$hp)
median(mtcars$hp)

str(mtcars)


mtcars$am <- factor(mtcars$am,
                    level = c(0, 1),
                    labels = c("Auto"), "Manual")

table(mtcars$am)

barplot(table(mtcars$am))
boxplot(mtcars$hp)

fivenum(mtcars$hp)

min(mtcars$hp)
quantile(mtcars$hp, probs =c(.25, .5, .75))
max(mtcars$hp)

## Whisker Calculation
q3 <- quantile(mtcars$hp, prob = .75)
q1 <- quantile(mtcars$hp, prob = .25)
iqr_hp <- q3 - q1
iqr_hp

q3 + 1.5*iqr_hp
## Upper Whisker arm
q1 - 1.5*iqr_hp
## Lower Whisker arm

boxplot.stats(mtcars$hp, coef = 1.5)

## Remove the extream data before plot
mtcars_no_out <- mtcars %>%
  filter(hp < 335)

boxplot(mtcars_no_out$hp)

## Box plot with 2 variable
## Qualiative x Quantiative

data(mtcars) 

mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("Auto", "Manual"))

boxplot(mpg ~ am, data = mtcars,
        col = c("gold", "salmon"))

## zoom > right click > save as 

## Scatter Plot
## 2 x Quantiative

plot(mtcars$hp, mtcars$mpg, pch = 18,
     col = "blue",
     main = "Relationship between HP and MPG",
     xlab = "HP",
     ylab = "MPG")

cor(mtcars$hp, mtcars$mpg)
lm(mpg ~ hp, data = mtcars)

## ggplot 2 (Grammar of Graph)
## Need data, mapping , Geometry

##First plot
ggplot(data = mtcars, mapping = aes(x = hp, y = mpg)) +
  geom_point(size = 3, col ="blue", alpha = 0.5) + 
  geom_smooth() + ## smomth line
  geom_rug() ## rug bar

ggplot(mtcars ,aes(hp, mpg)) + geom_point()


ggplot(mtcars ,aes(hp)) + 
  geom_histogram(bins = 10, fill = "red", alpha =0.6)


ggplot(mtcars ,aes(hp)) +
  geom_boxplot()

p <- ggplot(mtcars ,aes(hp)) 

p + geom_histogram(bins = 10)
p + geom_density()
p + geom_boxplot()

## Box plt by groups

diamonds

diamonds %>%
  count(cut)

ggplot(diamonds, aes(cut)) + geom_bar()

ggplot(diamonds, aes(cut)) + geom_bar(fill = "#ff4dff")

## hex color code ?????????

ggplot(diamonds, mapping =aes(cut, fill=cut)) + geom_bar()

ggplot(diamonds, mapping =aes(cut, fill=color)) + geom_bar()

ggplot(diamonds, mapping =aes(cut, fill=color)) + geom_bar(position =  "stack")
ggplot(diamonds, mapping =aes(cut, fill=color)) + geom_bar(position =  "dodge")

## set the position

ggplot(diamonds, mapping =aes(cut, fill=color)) + geom_bar(position =  "fill")

## Scattper Plot

ggplot(diamonds, aes(carat, price)) +
  geom_point()

## set.seed for static random

set.seed(50)
small_diamonds <- sample_n(diamonds, 5000)
ggplot(small_diamonds, aes(carat, price)) +
  geom_point()

## FACET : Small Multiples 

ggplot(small_diamonds, aes(carat, price)) +
  geom_point() +
  facet_wrap(~color)

## facet colums color

ggplot(small_diamonds, aes(carat, price)) +
  geom_point() +
  facet_wrap(~color, ncol = 4)


ggplot(small_diamonds, aes(carat, price)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~color, ncol = 2)

## Add layer smooth line

ggplot(small_diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~color, ncol = 2)

## Change smooth line to linear Regression

ggplot(small_diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  facet_wrap(~color, ncol = 2)

## Change color of line

ggplot(small_diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  facet_wrap(~color, ncol = 2) +
  theme_classic() +
  labs(title = "Relationship between carat and price by color", 
       x = "Carat",
       y = "Price (USD)",
       caption = "Source : Daimonds from ggplot 2 package")

## Final Example

ggplot(small_diamonds, aes(carat, price, col=cut)) +
  geom_point(size = 2, alpha = 0.7) +
  facet_wrap(~color, ncol=2)+
  theme_minimal()