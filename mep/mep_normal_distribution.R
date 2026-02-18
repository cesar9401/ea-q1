library(ggplot2)

# function with ggplot2
ggplot_sampling_dist <- function(mean = 0, sd = 1, n = 1, lower = -Inf, upper = Inf, main = "Distribución de X̄") {
  # standard error
  se <- sd / sqrt(n)

  # create data
  x <- seq(mean - 4 * se, mean + 4 * se, length = 1000)
  df <- data.frame(x = x, y = dnorm(x, mean, se))

  # shaded area
  df_shade <- df[df$x >= lower & df$x <= upper,]

  # calculate probability
  prob <- pnorm(upper, mean, se) - pnorm(lower, mean, se)

  # create plot
  ggplot(df, aes(x, y)) +
    geom_line(linewidth = 1) +
    geom_area(data = df_shade, fill = "steelblue", alpha = 0.5) +
    geom_vline(
      xintercept = c(lower, upper)[is.finite(c(lower, upper))],
      linetype = "dashed", color = "red"
    ) +
    annotate(
      "text",
      x = mean,
      y = max(df$y) * 0.9,
      label = paste0("P = ", round(prob, 5), "\nn = ", n, "\nσ_X̄ = ", round(se, 5)),
      size = 4
    ) +
    labs(
      title = main,
      x = "X̄",
      y = "Densidad",
      subtitle = paste0("μ = ", mean, ", σ = ", sd, ", n = ", n)
    ) +
    theme_minimal()
}

# examples
# ggplot_sampling_dist(mean = 50, sd = 8, n = 36, lower = -Inf, upper = 48, main = "P(z <= 48)")
# ggplot_sampling_dist(mean = 50, sd = 8, n = 36, lower = 52, upper = Inf, main = "P(z <= 48)")
ggplot_sampling_dist(mean = 50, sd = 8, n = 36, lower = 49, upper = 53, main = "P(z <= 48)")
