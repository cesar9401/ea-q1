library(ggplot2)

# complete function for t-Student with all parameters
t_student_completo <- function(
  mu = 100,           # Population mean
  n = 25,             # Sample size
  s = 15,             # Sample standard deviation
  lower = -Inf,       # Lower limit
  upper = Inf,        # Upper limit
  main = "t-Student Distribution"
) {

  # Calculate degrees of freedom and standard error
  gl <- n - 1
  se <- s / sqrt(n)

  # Convert limits from original scale to t scale
  # If limits are in original scale (X̄), convert to t
  # If already in t scale, use directly
  # We assume if limits are small (-5 to 5), they're in t scale
  # If large, they're in original scale

  if (abs(lower) > 10 | abs(upper) > 10) {
    # Limits are in original scale, convert to t
    t_lower <- ifelse(is.infinite(lower), -Inf, (lower - mu) / se)
    t_upper <- ifelse(is.infinite(upper), Inf, (upper - mu) / se)
    limites_originales <- c(lower, upper)
  } else {
    # Limits are already in t scale
    t_lower <- lower
    t_upper <- upper
    # Convert to original scale for display
    limites_originales <- c(
      ifelse(is.infinite(lower), -Inf, mu + lower * se),
      ifelse(is.infinite(upper), Inf, mu + upper * se)
    )
  }

  # Create data for the plot
  t_values <- seq(-4, 4, length = 1000)
  df_data <- data.frame(t = t_values, densidad = dt(t_values, gl))

  # Shaded area
  df_shade <- df_data[df_data$t >= t_lower & df_data$t <= t_upper,]

  # Calculate probability
  prob <- pt(t_upper, gl) - pt(t_lower, gl)

  # Create labels for the limits
  label_lower <- ifelse(is.infinite(t_lower), "-∞", paste0("t = ", round(t_lower, 3)))
  label_upper <- ifelse(is.infinite(t_upper), "∞", paste0("t = ", round(t_upper, 3)))

  label_lower_orig <- ifelse(is.infinite(limites_originales[1]), "-∞", paste0("X̄ = ", round(limites_originales[1], 2)))
  label_upper_orig <- ifelse(is.infinite(limites_originales[2]), "∞", paste0("X̄ = ", round(limites_originales[2], 2)))

  # Create plot
  p <- ggplot(df_data, aes(t, densidad)) +
    geom_line(linewidth = 1.2, color = "darkblue") +
    geom_area(data = df_shade, fill = "coral", alpha = 0.6) +
    geom_vline(xintercept = c(t_lower, t_upper)[is.finite(c(t_lower, t_upper))], linetype = "dashed", color = "red", linewidth = 1) +

    # Main annotation with all parameters
    annotate(
      "text",
      x = 0,
      y = max(df_data$densidad) * 0.75,
      label = paste0(
        "P = ", round(prob, 5), "\n",
        "μ = ", mu, "\n",
        "n = ", n, "\n",
        "s = ", s, "\n",
        "df = ", gl, " (n-1)\n",
        "SE = ", round(se, 5)
      ),
      size = 4.5,
      fontface = "bold",
      color = "darkblue"
    ) +

    # Labels at the limits (t scale)
    { if (is.finite(t_lower))
      annotate("text", x = t_lower, y = max(df_data$densidad) * 0.05, label = label_lower, size = 3.5, color = "red", hjust = 1.1)
    } +
    { if (is.finite(t_upper))
      annotate("text", x = t_upper, y = max(df_data$densidad) * 0.05, label = label_upper, size = 3.5, color = "red", hjust = -0.1)
    } +

    labs(
      title = main,
      subtitle = paste0("Limits: ", label_lower_orig, " to ", label_upper_orig, " | df = ", gl),
      x = "t values",
      y = "Density"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 15, face = "bold"),
      plot.subtitle = element_text(hjust = 0.5, size = 11),
      panel.grid.minor = element_blank()
    )

  print(p)

  # Return useful information
  cat("\n========================================\n")
  cat("SUMMARY OF RESULTS\n")
  cat("========================================\n")
  cat("Population mean (μ):", mu, "\n")
  cat("Sample size (n):", n, "\n")
  cat("Sample standard deviation (s):", s, "\n")
  cat("Degrees of freedom (df):", gl, "\n")
  cat("Standard error (SE):", round(se, 4), "\n")
  cat("────────────────────────────────────────\n")
  cat(
    "Limits in t scale:",
    ifelse(is.infinite(t_lower), "-∞", round(t_lower, 4)), "to",
    ifelse(is.infinite(t_upper), "∞", round(t_upper, 4)), "\n"
  )
  cat(
    "Limits in X̄ scale:",
    ifelse(is.infinite(limites_originales[1]), "-∞", round(limites_originales[1], 4)), "to",
    ifelse(is.infinite(limites_originales[2]), "∞", round(limites_originales[2], 4)), "\n")
  cat("────────────────────────────────────────\n")
  cat("Probability:", round(prob, 4), "\n")
  cat("========================================\n\n")

  return(invisible(list(
    probability = prob,
    degrees_of_freedom = gl,
    standard_error = se,
    t_limits = c(t_lower, t_upper),
    original_limits = limites_originales,
    parameters = list(mu = mu, n = n, s = s)
  )))
}

# ============================================
# USAGE EXAMPLES
# ============================================

# Example 1: P(t > 1.5)
# Limits in t scale
# t_student_completo(mu = 100, n = 25, s = 15, lower = 1.5, upper = Inf, main = "P(t > 1.5)")

# Example 2: P(-2 < t < 2)
# Limits in t scale
# t_student_completo(mu = 100, n = 30, s = 12, lower = -2, upper = 2, main = "P(-2 < t < 2)")

# Example 3: P(X̄ > 105)
# Limits in original scale
# t_student_completo(mu = 100, n = 16, s = 8, lower = 105, upper = Inf, main = "P(X̄ > 105)")

# Example 4: P(95 < X̄ < 105)
# Limits in original scale
# t_student_completo(mu = 100, n = 20, s = 10, lower = 95, upper = 105, main = "P(95 < X̄ < 105)")

# Example 5: P(t < -1.8)
# t_student_completo(mu = 50, n = 12, s = 5, lower = -Inf, upper = -1.8, main = "P(t < -1.8)")

# Example 6: Complete problem
# A company claims the average delivery time is 100 minutes.
# We take a sample of 25 deliveries with s = 15 minutes.
# What is the probability that the sample mean is between 95 and 105?
resultado <- t_student_completo(
  mu = 100,      # Population mean (minutes)
  n = 25,        # Sample size
  s = 15,        # Sample standard deviation
  lower = 95,    # Lower limit
  upper = 105,   # Upper limit
  main = "Delivery time: P(95 < X̄ < 105)"
)
