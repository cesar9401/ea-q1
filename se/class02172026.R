# coercion
matrix_example <- matrix(1:12, nrow = 4, ncol = 3)
# matrix_example

df_example <- data.frame(a = 1:3, b = 4:6, c = 7:9)
# df_example

list_example <- list(1:3, letras = c("a", "b", "c"), valor = 15)

# matrix to vector
vector_as_matrix <- as.vector(matrix_example)
vector_as_matrix

# data frame to vector
vector_as_df <- as.vector(df_example)
vector_as_df

# list to vector
vector_as_list <- as.vector(list_example)
vector_as_list

# data frame to matrix
df <- data.frame(x = c(10, 20, 30), y = c(40, 50, 60), z = c(70, 80, 90))
df

matrix_as_df <- as.matrix(df)
matrix_as_df

# list to data frame
list_to_df <- list(name = c("Alice", "Bob", "Charlie"), age = c(25, 30, 35), city = c("New York", "Los Angeles", "Chicago"))
list_to_df

df_from_list <- as.data.frame(list_to_df)
df_from_list

# installing packages
# install.packages("readr")
# install.packages("readxl")
install.packages("writexl")
library(readr)
library(readxl)
library(writexl)

# read excel file
data <- read_excel("se/demo.xlsx", sheet = "Sheet1")
data$Country

# exportar txt files
write.table(df_from_list, 'se/export.txt', row.names = FALSE, col.names = TRUE, sep = ",")

# export to excel file
write_xlsx(df_from_list, "se/export_excel.xlsx")

# apply functions

# apply -> operations by rows or columns of a matrix/data frame
matrixA <- matrix(1:12, nrow = 4)
matrixA

apply(matrixA, MARGIN = 1, FUN = sum) # sum by rows
apply(matrixA, MARGIN = 2, FUN = sum) # sum by columns
