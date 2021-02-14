# Discussion9.R
#
# Description:
#   Example code for Discussion 9. To see the examples,
#   step through the body of the main() function.
#

main = function() {
    # Anderson's iris data is a popular data set
    # introduced by R. Fisher.
    head(iris)
    data = as.matrix(iris[3:4])
    groups = as.numeric(iris[[5]])

    # Plot of true groups in data.
    x11()
    plot_groups(data, groups, pch = 18, cex = 0.75,
                xlab = 'Petal Length',
                ylab = 'Petal Width',
                main = '')

    ####################
    # Cross-validation #
    ####################
    grid_pts = 50
    a = seq(0, 1, len = grid_pts)
    n = nrow(data)
    error = matrix(0, n, grid_pts)
    for (i in seq_len(n)) {
        # Get prediction error for each value a,
        # when observation i is left out.
        error[i, ] = sapply(a, lda_classify,
                            data[-i, ], groups[-i],
                            data[i, ], groups[i])
    }

    x11()
    plot(a, colMeans(error), type = 'l', ylim = c(0.5, 1),
         main = 'Cross-validated Prediction Error',
         ylab = 'Prediction Error')

    ######################
    # k-means Clustering #
    ######################

    # 2-means clustering.
    x11()
    k_means(data, 2)

    # 3-means clustering.
    x11()
    k_means(data, 3)
}

lda_classify = function(a, train, tr_tags, test, te_tag)
    # This function performs LDA classification on a
    # single test point, and returns the error.
{
    s = cov(train)
    s = a * s + (1 - a) * diag(diag(s))
    xbar = cbind(tapply(train[, 1], tr_tags, mean),
                 tapply(train[, 2], tr_tags, mean))

    mdist = function(mu, y, V) {
        t(y - mu) %*% solve(V) %*% (y - mu)
    }
    est = which.min(apply(xbar, 1, mdist, test, s))

    # Return 0 or 1 indicating whether classification
    # was correct.
    as.numeric(est == te_tag)
}

k_means = function(data, k, max_iter = 10,
                   interactive = TRUE, tol = 0.0001)
    # This function performs an interactive version of
    # the k-means algorithm.
{
    # Convert data to a matrix.
    data = as.matrix(data)
    n = nrow(data)

    # 0. Choose k observations randomly as the initial
    # cluster means.
    start = sample(n, k)
    means = data[start, ]

    for (iter in seq_len(max_iter)) {
        ##########
        # Step 1 #
        ##########

        # Cluster each observation according to closest
        # mean.

        dist2means = function(x)
            # This function computes the distance from
            # between a vector x and each of the means.
        {
            apply(means, 1, function(m) norm(x - m, '2'))
        }
        scores = apply(data, 1, dist2means)
        scores = -t(scores)
        clusters = max.col(scores)

        ##########
        # Step 2 #
        ##########

        # Recompute the mean for each cluster.

        old_means = means

        for (i in seq_len(k)) {
            means[i, ] = colMeans(data[clusters == i, ])
        }

        ##########
        # Step 3 #
        ##########

        # Check for convergence.
        dist = norm(means - old_means, '2')
        if (dist < tol) {
            cat(paste0(dist, ' is within tolerance.\n'))
            return(clusters)
        }

        #################
        # Interactivity #
        #################
        if (interactive) {
            # Draw the plot.
            init = (iter == 1)
            main = paste0(k, '-means Clustering')
            plot_groups(data, clusters, main = main,
                        xlab = 'Petal Length',
                        ylab = 'Petal Width',
                        pch = 18, cex = 0.75, add = !init)
            suppressWarnings(
              plot_k_means(old_means, means, k, init = init)
            )

            # Display change in means.
            cat(norm(means - old_means, '2'))
            cat('\n')

            # Wait for a click.
            locator(1)
        }
    } # end for
    return(clusters)
}

plot_groups = function(data, groups, xlab, ylab,
                       main = '', add = FALSE, ...)
    # This function plots grouped data.
{
    if (!add) plot(data[, 1], data[, 2], col = 'white',
                   xlab = xlab, ylab = ylab, main = main)

    k = max(groups)
    for (i in seq_len(k)) {
        data_ = data[groups == i, ]
        points(data_[, 1], data_[, 2], col = i + 1, ...)
    }
}

plot_k_means = function(origin, dest, k, init = FALSE)
    # This function plots the k-means data when the
    # algorithm is running in interactive mode.
{
    for (i in seq_len(k)) {
        if (init) {
            points(origin[i, 1], origin[i, 2], pch = 0,
                   cex = 1.25)
        }
        points(dest[i, 1], dest[i, 2], cex = 1.25)
        arrows(origin[i, 1], origin[i, 2],
               dest[i, 1], dest[i, 2],
               length = 0.1, col = 'gray50')
    }
}

