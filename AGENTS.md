# AGENTS.md

This file provides context and guidelines for AI agents and developers working in this R repository.

## 1. Project Overview

This repository contains R scripts for statistical analysis and data manipulation, organized into subdirectories (`mep`, `mrl`, `se`). The code is primarily script-based rather than a formal R package.

-   **mep/**: Statistical distribution scripts (Normal, T, Sampling distributions).
-   **mrl/**: Class-based folders.
-   **se/**: Data manipulation and file I/O examples.

## 2. Environment & Dependencies

-   **Language**: R
-   **Key Libraries**: `ggplot2`, `readr`, `readxl`, `writexl`.
-   **Package Installation**:
    -   Packages are typically installed via `install.packages("package_name")` inside scripts (often commented out) or in an interactive session.
    -   *Agent Note*: Do not uncomment `install.packages()` calls in scripts unless explicitly instructed. Assume standard packages are available or ask the user to install them.

## 3. Build, Run, & Test Commands

Since this is a collection of scripts, there is no central build system.

### Running Scripts
To run a specific R script from the command line:
```bash
Rscript path/to/script.R
```

### Linting
Use the `lintr` package to check for style and syntax issues.
```bash
# Lint a specific file
Rscript -e 'lintr::lint("path/to/script.R")'
```

### Formatting
Use the `styler` package to format code.
```bash
# Style a specific file
Rscript -e 'styler::style_file("path/to/script.R")'
```

### Testing
While there are no explicit tests currently, future tests should use the `testthat` package.

**Running a single test file (if created):**
```bash
Rscript -e 'testthat::test_file("tests/test_script.R")'
```

**Running all tests:**
```bash
Rscript -e 'testthat::test_dir("tests")'
```

## 4. Code Style & Conventions

Adhere to the [Tidyverse style guide](https://style.tidyverse.org/) where possible.

### Naming Conventions
-   **Variables & Functions**: Use `snake_case`.
    -   Good: `matrix_example`, `ggplot_sampling_dist`
    -   Bad: `matrixExample`, `MatrixExample`
-   **Files**: Use `snake_case` or `kebab-case`.
    -   Good: `mep_normal_distribution.R`
    -   Bad: `mepNormalDistribution.R`

### Syntax & Formatting
-   **Assignment**: Use `<-` for assignment, not `=`.
    ```r
    # Good
    x <- 5
    
    # Bad
    x = 5
    ```
-   **Spacing**: Use 2 spaces for indentation. No tabs.
-   **Line Length**: Aim for ~80 characters per line.
-   **Commas**: Always put a space after a comma, never before.

### Imports
-   Load libraries at the very top of the script using `library()`.
-   Avoid `require()` unless strictly necessary.
-   Do not use absolute paths for file I/O; use paths relative to the project root.

### Error Handling
-   Use `tryCatch()` for robust error handling in functions that might fail (e.g., file I/O, network requests).
-   Validate function inputs where appropriate (e.g., checking for negative variance).

### Documentation & Comments
-   **Functions**: If creating reusable functions, document arguments and return values using `roxygen2` style comments (`#'`) if possible, or clear standard comments (`#`) otherwise.
-   **Inline Comments**: Focus on the *why* (statistical reasoning), not the *what* (syntax).
    ```r
    # Good: Calculate standard error of the mean
    se <- sd / sqrt(n)

    # Bad: Divide sd by square root of n
    se <- sd / sqrt(n)
    ```

## 5. Agent Instructions

-   **File Paths**: Always use paths relative to the project root (e.g., `se/demo.xlsx`).
-   **Data Generation**: When creating examples, use `set.seed()` to ensure reproducibility.
-   **Visualizations**: When using `ggplot2`, prefer `theme_minimal()` or `theme_light()` for a clean look, as seen in `mep/mep_normal_distribution.R`.
-   **Modifications**: When modifying existing scripts, preserve the existing style and variable naming conventions. Do not reformat the entire file unless asked.
