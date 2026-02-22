library(ggplot2)

# Function to plot sampling distribution of proportions
# Inputs:
#   p: Population proportion (success rate)
#   q: Failure rate (optional, defaults to 1-p)
#   n: Sample size
#   lower: Lower bound for the sample proportion (p-hat)
#   upper: Upper bound for the sample proportion (p-hat)
#   main: Plot title
ggplot_proportion_dist <- function(p = 0.5, q = NULL, n = 30, lower = -Inf, upper = Inf, main = "Distribución de Proporciones Muestrales") {

  # Calculate q if not provided
  if (is.null(q)) {
    q <- 1 - p
  }

  # Standard error (estimation error for the proportion)
  # Formula: sqrt(p * q / n)
  se <- sqrt(p * q / n)

  # Create data for plotting
  # We use the normal approximation: N(p, se)
  # Range: mean +/- 4 standard deviations to cover the distribution
  x <- seq(p - 4 * se, p + 4 * se, length = 1000)
  df <- data.frame(x = x, y = dnorm(x, mean = p, sd = se))

  # Shaded area
  df_shade <- df[df$x >= lower & df$x <= upper, ]

  # Calculate probability
  # P(lower <= p-hat <= upper)
  prob <- pnorm(upper, mean = p, sd = se) - pnorm(lower, mean = p, sd = se)

  # Calculate Z-values for the bounds
  # Formula: z = (p-hat - p) / sqrt(p * q / n)
  z_lower <- if (is.finite(lower)) (lower - p) / se else -Inf
  z_upper <- if (is.finite(upper)) (upper - p) / se else Inf

  # Create plot
  plot <- ggplot(df, aes(x, y)) +
    geom_line(linewidth = 1) +
    geom_area(data = df_shade, fill = "steelblue", alpha = 0.5) +
    geom_vline(
      xintercept = c(lower, upper)[is.finite(c(lower, upper))],
      linetype = "dashed", color = "red"
    ) +
    annotate(
      "text",
      x = p,
      y = max(df$y) * 0.9,
      label = paste0(
        "Prob = ", round(prob, 5), "\n",
        "n = ", n, "\n",
        "p = ", p, "\n",
        "SE (σ_p) = ", round(se, 5)
      ),
      size = 4
    ) +
    labs(
      title = main,
      x = "Proporción Muestral (p̂)",
      y = "Densidad",
      subtitle = paste0(
        "μ_p = ", p, ", σ_p = ", round(se, 4),
        if (is.finite(lower)) paste0(", Z_low = ", round(z_lower, 2)) else "",
        if (is.finite(upper)) paste0(", Z_up = ", round(z_upper, 2)) else ""
      )
    ) +
    theme_minimal()

  # Print Summary
  cat("\n========================================\n")
  cat("SUMMARY OF RESULTS\n")
  cat("========================================\n")
  cat("Population proportion (p):", p, "\n")
  cat("Failure probability (q):", q, "\n")
  cat("Sample size (n):", n, "\n")
  cat("Standard error (SE):", round(se, 5), "\n")
  cat("────────────────────────────────────────\n")
  cat(
    "Limits (p̂ scale):",
    ifelse(is.infinite(lower), "-∞", round(lower, 4)), "to",
    ifelse(is.infinite(upper), "∞", round(upper, 4)), "\n"
  )
  cat(
    "Z-values:",
    ifelse(is.infinite(z_lower), "-∞", round(z_lower, 4)), "to",
    ifelse(is.infinite(z_upper), "∞", round(z_upper, 4)), "\n"
  )
  cat("────────────────────────────────────────\n")
  cat("Probability:", round(prob, 5), "\n")
  cat("========================================\n\n")

  return(plot)
}

# Example usage:
# Population proportion p = 0.5
# Sample size n = 100
# Calculate probability that sample proportion is between 0.45 and 0.55
# ggplot_proportion_dist(p = 0.5, n = 100, lower = 0.45, upper = 0.55, main = "P(0.45 <= p̂ <= 0.55)")

ggplot_proportion_dist(p = 0.02, n = 1000, lower = 0.027, upper = +Inf, main = "P(p̂ > 0.027)")