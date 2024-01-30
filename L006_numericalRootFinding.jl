# Numerical Root Finding
## Bounded needing derivatives (not being discussed)

## Unbounded with derivative
### Newton's method
# - iterative method
# - initialization, initial guess (x0) for the potential root is made
# - f(x) & f'(x) are solved for x0 (intercept with x-axis)
# - f(x) = f'(x) * x + c
# - f'(xn) = [f(xn) - 0] / [xn - xn+1]
# - xn+1 = xn - [f(xn) / f'(xn)]
using DataSci4Chem
x = collect(0 : 0.1 : 10)
f(x) = x.^2 .- 9
newton = plot(x, f(x), label = "Example function", 
    xlabel = "x values", ylabel = "f(x)", dpi = 300)
plot!([0,10], [0,0], label = "f(xn) = 0")

xFirstGuess = 0.5
yFirstLevel = f(xFirstGuess)
scatter!([xFirstGuess], [yFirstLevel], label = "f(0.5)")

df(x) = 2 .* x
xPlusOne = xFirstGuess - f(xFirstGuess) / df(xFirstGuess)
scatter!([xPlusOne], [0], label = "f'(xn+1)")
plot!([0.5, xPlusOne], [yFirstLevel, 0], label = "slope")

# - iteration
xNextGuess = deepcopy(xPlusOne)
yNextLevel = f(xNextGuess)
xPlusOne = xNextGuess - f(xNextGuess) / df(xNextGuess)
scatter!([xPlusOne], [0], label = "f'(xn+1), iter = 2")
plot!([0.5, xPlusOne], [yFirstLevel, 0], label = "slope, iter = 2")
plot!([xNextGuess, xPlusOne], [yNextLevel, 0], label = "slope, iter = 2")

# - iteration
xNextGuess = deepcopy(xPlusOne)
yNextLevel = f(xNextGuess)
xPlusOne = xNextGuess - f(xNextGuess) / df(xNextGuess)
scatter!([xPlusOne], [0], label = "f'(xn+1), iter = 3")
plot!([0.5, xPlusOne], [yFirstLevel, 0], label = "slope, iter = 3")
plot!([xNextGuess, xPlusOne], [yNextLevel, 0], label = "slope, iter = 3")
savefig(newton, "newton.png")

# - stopping criterion
## number of iterations
## a set tolerance (minimum acceptable accuracy) for the desired value)

# - simple
# - robuts
# - fast
# - assumes continuity (df is needed, performs root-finding for 1 variable at a time)

### Secant method
# - a solution to the df problem arised from Newton's method
# - the derivative is numerically approximated in Secant method
# - f'(x) ~= [f(xn) - f(xn-1)] / [xn - xn-1]
# - same as Newton's: xn+1 = xn - [f(xn) / f'(xn)]
# -> xn+1 = xn - [f(xn) / {[f(xn) - f(xn-1)] / [xn - xn-1]}]
# --simplification--> xn+1 = xn - {[f(xn)]*[xn - xn-1] / [f(xn) - f(xn-1)]}
# -->> xn+1 = {xn*[f(xn) - f(xn-1)] / [f(xn) - f(xn-1)]} - {[f(xn)]*[xn - xn-1] / [f(xn) - f(xn-1)]}
# -->>      = {xn*[f(xn)] - xn*[f(xn-1)] - [f(xn)]*[xn - xn-1]} / [f(xn) - f(xn-1)]
# -->>      = {xn*[f(xn)] - xn*[f(xn-1)] - [f(xn)]*[xn] + [f(xn)]*[xn-1]} / [f(xn) - f(xn-1)]
# -->>      = {[f(xn)]*[xn-1] - xn*[f(xn-1)]} / [f(xn) - f(xn-1)]
# - needs more iterations in general
# - initialization, different from Newton's, Secant method needs 2 points to start
x = collect(-10 : 0.1 : 10)
xFirstGuess = 0.5
xSecondFirstGuess = -5
f(x) = x.^2 .- 9
secant = plot(x, f(x), label = "Example function", 
    xlabel = "x values", ylabel = "f(x)", dpi = 300)
plot!([-10,10], [0,0], label = "f(x) = 0")
scatter!([xFirstGuess], [f(xFirstGuess)], label = "f(0.5)")
scatter!([xSecondFirstGuess], [f(xSecondFirstGuess)], label = "f(-5)")

# - iteration
xNextGuess = (f(xFirstGuess)*xFirstGuess - xSecondFirstGuess*f(xSecondFirstGuess)) / 
    (f(xFirstGuess) - f(xSecondFirstGuess))
# xn+1 = {[f(xn)]*[xn-1] - xn*[f(xn-1)]} / [f(xn) - f(xn-1)]
# why?? xn+1 = {[f(xn)]*[xn] - [xn-1]*[f(xn-1)]} / [f(xn) - f(xn-1)]
scatter!([xNextGuess], [f(xNextGuess)], label = "f(x_n2)")

# - iteration
# xn+1 = {[f(xn)]*[xn-1] - xn*[f(xn-1)]} / [f(xn) - f(xn-1)]
xNextGuess = (f(xNextGuess)*xSecondFirstGuess - xNextGuess*f(xSecondFirstGuess)) / 
    (f(xNextGuess) - f(xSecondFirstGuess))
scatter!([xNextGuess], [f(xNextGuess)], label = "f(x_n3)")
savefig(secant, "secant.png")

## Bounded without derivative
# - function without the use of derivative due to pre-defined window for finding the root of function
### Bisection method
# - is usable for a single variable function as long as the signes of the provided bounds are different
# - algo sums the bounds' values -> dividing 2 -> new point
# - new point replaces one of the initial bounds depending on the signs of the f()\
x = collect(-30 : 0.1 : 30)
f(x) = x.^2 .- 25
bisection = plot(x, f(x), label = "test function", 
    xlabel = "x values", ylabel = "f(x)", dpi = 300)
plot!([-10,10], [0,0], label = "f(x) = 0")
# - to initially guess the bounds, choose points have different signs for y-values
# f(0) = -25; f(25) = +600
scatter!([0,25], [f(0), f(25)], label = "bounds")
# - average of the bounds: [0 + 25] / 2 -> 12.5
# - select 1 of 2 windows ([12.5, 25]? or [0, 12.5]?)
scatter!([12.5], [f(12.5)], label = "middle bound")
# - lower bound appears to meet the needed criteria, while upper bound doesn'
# - average again: [0 + 12.5] / 2 -> 6.25
scatter!([6.25], [f(6.25)], label = "middle bound 2nd itr")
savefig(bisection, "bisection.png")

## Unbounded without derivative