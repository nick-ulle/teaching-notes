# Discussion8.R

main = function() {
    ndata = load_data()
    ndata2 = ndata
    
    # Check the normality of the data.
    show_qq(ndata)
    
    # The Q-Q plots show that TB through Aspartate
    # (1:5) deviate from normality. This can
    # be corrected (to some extent) with power
    # transformations.
    
    # Check whether the data might contain zeros.
    sapply(ndata, range)
    
    # Try some power transformations.
    test_tr = c(1, 0, -0.25, -0.5, -0.75, -1)
    for (j in 1:5) {
        pwr_tr_qq(ndata[, j, drop = F], test_tr)
    }
    
    tr = c(-0.25, -0.25, -0.75, -0.5, -0.5)
    ndata[, 1:5] = mapply(pwr_tr, ndata[, 1:5], 
                          tr)
    
    # Now the data looks better.
    show_qq(ndata)
    show_qq(ndata2)
    
    #######
    # PCA #
    
    # Compute the sample covariance.
    S = cov(ndata)
    S
    
    # Get the eigenvalues and vectors of S.
    eig = eigen(S)
    eig
    
    # Get the principal components.
    y = t(eig$vectors) %*% t(ndata)
    y = t(y)
    colnames(y) = paste0("PC", 1:9)
    dim(y)
    
    # The principal components have variances
    # equal to the eigenvalues of S, and
    # covariances 0.
    eig$values
    apply(y, 2, var)
    
    # How much does each component matter?
    eig$values / sum(eig$values)
    
    var_explained = 
        cumsum(eig$values) / sum(eig$values)
    
    # A scree plot presents this information
    # graphically.
    x11()
    plot(var_explained, type = "b",
         xlab = "# Of Principal Components",
         ylab = "% Variability Explained",
         main = "Scree Plot", ylim = c(0.99, 1))
    abline(h = 0.999, lty = "dashed")
    
    # For normally distributed data, the principal
    # components should also be normally
    # distributed.
    x11()
    pairs(y[, 1:3])
    
    x11()
    pairs(y)
    
    # Eigenvectors show how each principal
    # component is constructed from the
    # covariates.
    eig$vectors
    
    # Correlation between a covariate and a
    # principal component shows how important
    # that covariate is to that principal 
    # component.
    cor(ndata, y)
    
    #######
    # LDA #
    
    # Separate data into training and test.
    n = nrow(ndata)
    
    set.seed(5050)
    n_tr = floor(n / 2)
    n_te = n - n_tr
    train = sample(n, n_tr)
    
    ndata_tr = ndata[train, ]
    ndata_te = ndata[-train, ]
    
    true_tr = ifelse(ndata_tr$Age < 50, 2, 1)
    true_te = ifelse(ndata_te$Age < 50, 2, 1)
    
    ndata_tr = ndata_tr[, -9]
    ndata_te = ndata_te[, -9]
    
    # Build a linear classifier.
    S_tr = cov(ndata_tr)
    
    sp = split(ndata_tr, ndata[train, ]$Age < 50)
    cmeans = sapply(sp, colMeans)
    
    mu_1 = cmeans[, 1] # Age >= 50
    mu_2 = cmeans[, 2] # Age < 50
    
    S_tr_inv = solve(S_tr)
    classify = 
        function(x) {
            score1 = t(x - mu_1) %*% S_tr_inv %*% (x - mu_1)
            score2 = t(x - mu_2) %*% S_tr_inv %*% (x - mu_2)
            c(score1, score2)
        }
    
    scores_tr = apply(ndata_tr, 1, classify)
    classified_tr = max.col(- t(scores_tr))
    
    # Compute the accuracy.
    sum(classified_tr == true_tr) / n_tr
    
    # Now try this for the test set.
    scores_te = apply(ndata_te, 1, classify)
    classified_te = max.col(- t(scores_te))
    
    sum(classified_te == true_te) / n_te
}

load_data = function() {
    ilpd = read.csv("ILPD.csv", header = F)
    
    names(ilpd) = c("Age", "Gender", "TB", "DB",
                    "AAP", "Alamine", "Aspartate",
                    "TP", "ALB", "A/G", "Selector")
    
    data = ilpd[c(11, 2:10, 1)]
    
    ndata = data[-c(1:2)]
    ndata = na.omit(ndata)
    
    return(ndata)
}

best_grid = function(m) 
    # This function finds the best grid for
    # displaying multiple plots in one window.
{
    m = sqrt(m)
    grid = c(floor(m), ceiling(m))
    if (prod(grid) < m^2)
        grid = grid[c(2, 2)]
    
    return(grid)
}

pwr_tr = function(x, tr) 
    # This function power transforms the vector x.
{
    if (tr == 0) {
        log(x)
    } else {
        x^tr
    }
}

pwr_tr_qq = function(data, tr)
    # This function shows normal Q-Q plots for
    # the specified power transformations of the
    # data vector.
{
    name = names(data)
    data = data[[1]]
    m = length(tr)
    
    x11()
    par(mfrow = best_grid(m), oma = c(0, 0, 2, 0))
    for (i in seq_len(m)) {
        data_ = pwr_tr(data, tr[[i]])
        qqnorm(data_, main = tr[[i]])
        qqline(data_)
    }
    title = paste0('Normal Q-Q Plot (', name, ')')
    mtext(title, outer = TRUE)
    par(mfrow = c(1, 1), oma = rep(0, 4))
}

show_qq = function(data) 
    # This function shows normal Q-Q plots for
    # multivariate data.
{
    p = ncol(data)
    
    x11()
    par(mfrow = best_grid(p), oma = c(0, 0, 2, 0))
    for (j in seq_len(p)) {
        qqnorm(data[, j], 
               main = colnames(data)[[j]])
        qqline(data[, j])
    }
    mtext('Normal Q-Q Plots', outer = TRUE)
    par(mfrow = c(1, 1), oma = rep(0, 4))
}

