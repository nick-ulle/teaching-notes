# rejection_sampler_demo.R
#
# A graphical, interative demonstration of a rejection sampler. To run, call
# either the example1() or example2() function.

f1 = function(x) 4*x - x^2
f2 = function(x) ifelse(x < 4, exp(x), 0)

example1 = function() {
    rejection.sampler(f1, box.w = 4, box.h = 4, scaling = 32 / 3)
}

example2 = function() {
    scaling = integrate(f2, 0, 4)$value
    rejection.sampler(f2, 5, 60, scaling = scaling)
}

rejection.sampler = function(f, box.w, box.h = box.w, scaling = 1, n = 100,
                             interactive = FALSE, redraw = 50)
    # Plot a rejection sampler as it runs.
    #
    # Args:
    #   f           target density function
    #   box.w       width of proposal box
    #   box.h       height of proposal box
    #   scaling     scaling of the target density, if known
    #   n           number of points to sample
    #   interactive draw line segments and pause twice every iteration
    #   redraw      number of iterations before redraw
    #
    # Returns:
    #   A vector of sampled points.
{
    # Make a new blank plot.
    plot(x = c(0, box.w), y = c(0, box.h), type = 'n',
         xlab = 'x', ylab = 'f(x)', main = 'Rejection Sampler Plot')

    # Draw the target density and proposal box.
    pts = curve.pts(f, 0, box.w, n = 1000)
    redraw(pts, box.w, box.h)

    # Repeatedly sample a point, add it to the plot, and save it if accepted.
    samp = numeric(n)
    accepted = 0
    iterations = 0
    while (accepted < n) {
        # Sample x from the proposal density.
        x = runif(1, 0, box.w)

        if (interactive) {
            vsegment(x, 0, box.h, col = 'azure3')
            interactive = pause()
        }

        # Sample along the line from 0 to the height of the proposal density.
        y = runif(1) * box.h
        if (y < f(x)) {
            # The point is accepted.
            points(x, y, pch = 4, col = 'green', cex = 0.75)

            accepted = accepted + 1
            samp[accepted] = x
        } else {
            # The point is rejected.
            points(x, y, pch = 4, col = 'red', cex = 0.75)
        }

        if (interactive) interactive = pause()

        iterations = iterations + 1
        if (iterations %% redraw == 0) redraw(pts, box.w, box.h)
    }
    redraw(pts, box.w, box.h)

    # Plot the kernel density estimate for the sampled points.
    dens = density(samp, kernel = 'epanechnikov', from = 0, to = box.w)
    lines(dens$x, dens$y * scaling, lwd = 2)

    # Report the acceptance rate.
    message = sprintf('Acceptance rate: %.2f\n', accepted / iterations)
    cat(message)

    samp
}

pause = function()
    # Wait for user input.
{
    readline("Paused (stop interactive mode with 'n')... ") != 'n'
}

redraw = function(pts, box.w, box.h)
    # Redraw the target density and proposal box.
{
    lines(pts$x, pts$y, lty = 'dashed', lwd = 2)
    rect(0, 0, box.w, box.h)
}

curve.pts = function(f, a, b, n)
    # Evaluate a function at equally spaced points in an interval.
    #
    # Args:
    #   f   function to evaluate
    #   a   left endpoint
    #   b   right endpoint
    #   n   number of points
    #
    # Returns:
    #   A data frame of the evaluation points (x) and the corresponding
    #   function values (y).
{
    if (a >= b)
        stop('Left endpoint (a) must be less than right endpoint (b).')
    if (n < 1)
        stop('Number of points (n) must be at least 2.')

    x = seq(a, b, length.out = n)
    y = f(x)
    data.frame(x = x, y = y)
}

vsegment = function(x, ybottom, ytop, ...)
    # Plot a vertical line segment.
    #
    # Args:
    #   x       x-coordinate of the line segment
{
    lines(c(x, x), c(ybottom, ytop), ...)
}
