# k nearest neighbors classification
require("class")

n = 300
sigma = 1.5
mu1 = c(2, 7)
mu2 = c(7, 2)
mu3 = c(7, 7)
x1 = t(matrix(mu1, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x2 = t(matrix(mu2, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x3 = t(matrix(mu3, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
Xtrain = rbind(x1, x2, x3)
x1 = t(matrix(mu1, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x2 = t(matrix(mu2, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x3 = t(matrix(mu3, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
Xtest = rbind(x1, x2, x3)
Y = c(rep(1, n / 3), rep(2, n / 3), rep(3, n / 3))
y = factor(Y)
plot(Xtrain[, 1], Xtrain[, 2], col = as.numeric(y))

k = 5
# training error
predTr = knn(test = Xtrain, train = Xtrain, cl = y, k = k)
plot(Xtrain[, 1], Xtrain[, 2], col = as.numeric(y))
points(Xtrain[, 1], Xtrain[, 2], col = as.numeric(predTr))
trainError = sum(predTr != y) / n
trainError
# test error
predTest = knn(test = Xtest, train = Xtrain, cl = y, k = k)
plot(Xtest[, 1], Xtest[, 2], col = as.numeric(y))
points(Xtest[, 1], Xtest[, 2], col = as.numeric(predTest))
testError = sum(predTest != y) / n
testError

#model complexity
set.seed(1111)
n = 300
sigma = 1.5
mu1 = c(2, 7)
mu2 = c(7, 2)
mu3 = c(7, 7)
x1 = t(matrix(mu1, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x2 = t(matrix(mu2, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x3 = t(matrix(mu3, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
Xtrain = rbind(x1, x2, x3)
x1 = t(matrix(mu1, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x2 = t(matrix(mu2, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x3 = t(matrix(mu3, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
Xtest = rbind(x1, x2, x3)
Y = c(rep(1, n / 3), rep(2, n / 3), rep(3, n / 3))
y = factor(Y)

ks = c(1: 50)
trainError = 0
errTs = 0
for(i in 1: length(ks))
{
	predTest = knn(test = Xtest, train = Xtrain, cl = y, k = ks[i])
	errTs[i] = sum(y != predTest) / length(predTest)
	predTr = knn(test = Xtrain, train = Xtrain, cl = y, k = ks[i])
	trainError[i] = sum(y != predTr) / length(predTr)
}

plot(ks, errTs, col = 2, xlim = rev(range(ks)), xlab = "model Complexity", ylab = "error")
points(ks[50: 1], trainError[50: 1], col = 1)
lines(lowess(x = ks[50: 1], y = errTs[50: 1], f = .25), col = 2)
lines(lowess(x = ks[50: 1], y = trainError[50: 1], f = .25), col = 1)
legend(50, .15, legend = c("training error", "test error"), col = c(1, 2), lty = c(1, 1))

# curse of dimensionality
n = 300
p0 = 500
sigma = 1.5
mu1 = c(2, 7)
mu2 = c(7, 2)
mu3 = c(7, 7)
x1 = t(matrix(mu1, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x2 = t(matrix(mu2, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x3 = t(matrix(mu3, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
Xtrain = cbind(rbind(x1, x2, x3), matrix(rnorm(n * p0), n, p0))
x1 = t(matrix(mu1, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x2 = t(matrix(mu2, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
x3 = t(matrix(mu3, 2, n / 3)) + matrix(rnorm(n) * sigma, n / 3, 2)
Xtest = cbind(rbind(x1, x2, x3), matrix(rnorm(n * p0), n, p0))
Y = c(rep(1, n / 3), rep(2, n / 3), rep(3, n / 3))
y = factor(Y)
plot(Xtrain[, 1], Xtrain[, 2], col = as.numeric(y))

k = 15
predTest = knn(test = Xtest, train = Xtrain, cl = y, k = k)
plot(Xtest[, 1], Xtest[, 2], col = as.numeric(y))
points(Xtest[, 1], Xtest[, 2], col = as.numeric(predTest))
testError = sum(predTest != y) / n
testError
