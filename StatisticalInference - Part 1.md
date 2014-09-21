
Statistical Inference Course Assignment - Part 1 
========================================================

The exponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. The mean of exponential distribution is 1/lambda and the standard deviation is also also 1/lambda. Set lambda = 0.2 for all of the simulations. In this simulation, you will investigate the distribution of averages of 40 exponential(0.2)s. Note that you will need to do a thousand or so simulated averages of 40 exponentials.

Create a matrix with 40 simulations


```r
set.seed(5)
lambda <- 0.2
num_sim <- 1000
sample_size <- 40
sim <- matrix(rexp(num_sim*sample_size, rate=lambda), num_sim, sample_size)
row_means <- rowMeans(sim)
```

Distribution of sample means::


```r
# plot the histogram of averages
hist(row_means, breaks=50, prob=TRUE,
     main="Distribution of averages of samples,
     drawn from exponential distribution with lambda=0.2",
     xlab="")
# density of the averages of samples
lines(density(row_means))
# theoretical center of distribution
abline(v=1/lambda, col="red")
# t  yfit <- dnorm(xfit, mean=1/lambda, sd=(1/lambda/sqrt(sample_size)))
lines(xfit, yfit, pch=22, col="red", lty=2)
```

```
## Error: object 'xfit' not found
```

```r
# add legend
legend('topright', c("simulation", "theoretical"), lty=c(1,2), col=c("black", "red"))
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

Both distribution of sample means and theoretical center of the distribution is 5

Plot q-qplot 

```r
qqnorm(row_means); qqline(row_means)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

Evaluate the confidence interval for lambda


```r
lambda_vals <- seq(4, 6, by=0.01)
coverage <- sapply(lambda_vals, function(lamb) {
    mu_hats <- rowMeans(matrix(rexp(sample_size*num_sim, rate=0.2),
                               num_sim, sample_size))
    ll <- mu_hats - qnorm(0.975) * sqrt(1/lambda**2/sample_size)
    ul <- mu_hats + qnorm(0.975) * sqrt(1/lambda**2/sample_size)
    mean(ll < lamb & ul > lamb)
})

library(ggplot2)
qplot(lambda_vals, coverage) + geom_hline(yintercept=0.95)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

The average of the sample mean falls within the confidence interval at least 95% of the time. Note that the true rate, of lambda is 5.
