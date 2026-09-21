# Based on: https://github.com/keras-team/keras-io/blob/master/examples/vision/mnist_convnet.py
#ml GCC/13.2.0 R/4.4.1
#ml Python/3.11.5
#ml CUDA/12.6.0
#ml OpenSSL/3

# Install and load keras and tensorflow libraries
#install.packages("reticulate")
#install.packages("Matrix")
#install.packages("keras3")
library(keras3)

# MNIST handwritten-digit classification with a CNN
# Load the MNIST data
mnist <- dataset_mnist()

x_train <- mnist$train$x
y_train <- mnist$train$y

x_test <- mnist$test$x
y_test <- mnist$test$y

# MNIST contains 28 x 28 grayscale images.
# Add a channel dimension so that each image has shape 28 x 28 x 1.
x_train <- array_reshape( x_train, c(dim(x_train)[1], 28, 28, 1))

x_test <- array_reshape( x_test, c(dim(x_test)[1], 28, 28, 1))

# Pixel intensities originally range from 0 to 255.
# Rescale them to values between 0 and 1.
x_train <- x_train / 255
x_test <- x_test / 255

cat("Training data dimensions:", dim(x_train), "\n")
cat("Number of training images:", dim(x_train)[1], "\n")
cat("Number of test images:", dim(x_test)[1], "\n")

# Define the convolutional neural network
model <- keras_model_sequential( input_shape = c(28, 28, 1)) |>
  layer_conv_2d( filters = 32, kernel_size = c(3, 3), activation = "relu") |>
  layer_max_pooling_2d( pool_size = c(2, 2)) |>
  layer_conv_2d( filters = 64, kernel_size = c(3, 3), activation = "relu") |>
  layer_max_pooling_2d( pool_size = c(2, 2)) |>
  layer_flatten() |>
  layer_dropout(rate = 0.5) |>
  layer_dense( units = 10, activation = "softmax")

summary(model)

# Configure the training procedure
model |> compile( optimizer = "adam", loss = "sparse_categorical_crossentropy", metrics = "accuracy")

# Train the network
history <- model |> fit( x = x_train, y = y_train, epochs = 150, batch_size = 128, validation_split = 0.1, verbose = 2)

# Evaluate the model on previously unseen test images
test_results <- model |> evaluate( x_test, y_test, verbose = 0)

cat("Test loss:", test_results$loss, "\n")
cat("Test accuracy:", test_results$accuracy, "\n")
