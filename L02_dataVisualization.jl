# Data visualization and plotting
## Simple line plot
using DataSci4Chem

# x is index of each y value
y = collect(1 : 0.1 : 10)
plot(y)

y5 = 5 .* y  # . vectorizing # Amp. is increased
println(y5)
plot(y5)
# 1:length(y5) -> x index: 1, 2, 3, ...
# y5 -> 5.0, 5.5, 6.0, ...
plot(1 : length(y5), y5)

x = sin.(y)
plot(x, y)
xlabel!("sin(y)")
ylabel!("y values")

plot(x, y, xlabel = "sin(y)", ylabel = "y values")
xlims!(-2, 2)
ylims!(3,6)
plot(x, y, xlabel = "sin(y)", ylabel = "y values", 
    label = "Example data")
plot(x, y, xlabel = "sin(y)", ylabel = "y values", 
    label = false, linestyle = :dash)
plot(x, y, xlabel = "sin(y)", ylabel = "y values", 
    label = false, ls = :dash, lw = 2, lc = :red)

## Multiple frames
x2 = hcat(x, x)
y2 = hcat(y, y .+ 5)
plot(x2, y2, xlabel = "sin(y)", ylabel = "y values")
plot(x2, y2, xlabel = "sin(y)", ylabel = "y values",
    label = ["column1" "column2"])  # no comma between
plot(x2, y2, xlabel = "sin(y)", ylabel = "y values",
    label = ["column1" "column2"], 
    lc = [:red :green], lw = [2 1], ls = [:dot :dash])

## Overlaying frames
plot(x2[:, 1], y2[:, 1], xlabel = "sin(y)", ylabel = "y values", label = "column 1", 
    lw = 2, ls = :dot, lc = :red)
plot!(x2[:, 2], y2[:, 2], xlabel = "sin(y)", ylabel = "y values", label = "column 2", 
    lw = 1, ls = :dash)

p = plot(x2[:, 1], y2[:, 1], xlabel = "sin(y)", ylabel = "y values", label = "column 1", 
    lw = 2, ls = :dot, lc = :red)
plot(p, x2[:, 2], y2[:, 2], xlabel = "sin(y)", ylabel = "y values", label = "column 2", 
    lw = 1, ls = :dash)

## plot types
### scatter plot
scatter(p, x2[:, 2], y2[:, 2], xlabel = "sin(y)", ylabel = "y values", label = "column 2", 
    lw = 1, ls = :dash)

scatter(x2, y2, xlabel = "sin(y)", ylabel = "y values", label = ["column 1" "column 2"])

scatter(x2[:, 1], y2[:, 1], xlabel = "sin(y)", ylabel = "y values", label = "column 1", 
    lw = 2, ls = :dot, lc = :red)
scatter!(x2[:, 2], y2[:, 2], xlabel = "sin(y)", ylabel = "y values", label = "column 2", 
    lw = 1, ls = :dash)

s = scatter(x2[:, 1], y2[:, 1], xlabel = "sin(y)", ylabel = "y values", label = "column 1", 
    lw = 2, ls = :dot, lc = :red, ms = 5)
scatter(s, x2[:, 2], y2[:, 2], xlabel = "sin(y)", ylabel = "y values", label = "column 2", 
    lw = 1, ls = :dash, ms = 2)

ms1 = range(1, stop = 10, length = size(y2, 1))
s = scatter(x2[:, 1], y2[:, 1], xlabel = "sin(y)", ylabel = "y values", label = "column 1", 
    lw = 2, ls = :dot, lc = :red, ms = ms1, ma = 0.5)
scatter(s, x2[:, 2], y2[:, 2], xlabel = "sin(y)", ylabel = "y values", label = "column 2", 
    lw = 1, ls = :dash, ms = 2, shape = :+, mc = :black)

size(y2, 1)
size(y2)
range(1, stop = 10, length = 10)

### bar plot
bar(x2[:, 1][1:10], y2[:, 1][1:10], label = "column 1 - first 10")
measles = [38556, 24472, 14556, 18060, 19549, 8122, 28541, 7880, 3283, 4135, 7953, 1884]
mumps = [20178, 23536, 34561, 37395, 36072, 32237, 18597, 9408, 6005, 6268, 8963, 13882]
chickenPox = [37140, 32169, 37533, 39103, 33244, 23269, 16737, 5411, 3435, 6052, 12825, 23332]
bar(measles, label = "measles")
bar!(mumps, label = "mumps")
bar!(chickenPox, label = "chickenPox")

# Plots.jl -> PlotlyJS, StatsPlots.jl as sp in DataSci4Chem
sp.bar(measles, label = "measles")
sp.bar!(mumps, label = "mumps")
sp.bar!(chickenPox, label = "chickenPox")

sp.groupedbar([measles mumps chickenPox], bar_position = :dodge)

data = dataset("datasets", "iris")
describe(data)  # 7 columns
# variable, mena, min, median, max, nmissing, eltype

### histogram
histogram(data[!, "SepalLength"], label = false)
xlabel!("SepalWidth")
ylabel!("Frequency")

histogram(data[!, "SepalLength"], label = false, bins = 20)
xlabel!("SepalWidth")
ylabel!("Frequency")

b_range = range(4, stop=8, length=21)
histogram(data[!, "SepalLength"], label = false, bins = b_range)
xlabel!("SepalWidth")
ylabel!("Frequency")

h = histogram!(data[!, "SepalLength"], label = "Sepal Length", bins = 10)
histogram(h, data[!, "SepalWidth"], label = "Sepal Width", bins = 10, fillalpha = 0.6)

nh = histogram!(data[!, "SepalLength"], label = "Sepal Length norm", bins = 10, norm = :pdf)
histogram(nh, data[!, "SepalWidth"], label = "Sepal Width norm", bins = 10, fillalpha = 0.6, norm = :pdf)

ph = histogram!(data[!, "SepalLength"], label = "Sepal Length prob", bins = 10, norm = :probability)
histogram(ph, data[!, "SepalWidth"], label = "Sepal Width prob", bins = 10, fillalpha = 0.6, norm = :probability)

## heatmap
D = randn(10, 20)  # random 10 rows (Y) 20 columns (X)
heatmap(D)
xlabel!("Random values")
ylabel!("Random values")

mapY = range(5, stop = 25, length = 10)
mapX = range(-5, stop = 3, length = 20)
heatmap(mapX, mapY, D)
xlabel!("Random values")
ylabel!("Random values")

heatmap(mapX, mapY, D, cmap = :jet)
xlabel!("Random values")
ylabel!("Random values")

heatmap(mapX, mapY, D, cmap = :jet, clim = (-1, 1))
xlabel!("Random values")
ylabel!("Random values")

heatmap(mapX, mapY, D, cmap = :turbo, clim = (-1, 1), 
    colorbar_title = "My title", cbar = :none)
xlabel!("Random values")
ylabel!("Random values")

## frame size
heatmap(mapX, mapY, D, st= :heatmap, cmap = :turbo, clim = (-1, 1), 
    colorbar_title = "My title", 
    size = (300,300))
xlabel!("Random values")
ylabel!("Random values")

## figure resolution
heatmap(mapX, mapY, D, st= :heatmap, cmap = :turbo, clim = (-1, 1), 
    colorbar_title = "My title", 
    size = (300,300), 
    dpi = 300)
xlabel!("Random values")
ylabel!("Random values")

## subplots
plot1 = plot(mapX, mapY, D, st = :heatmap, 
    cmap = :hot, clim = (-1, 1), 
    colorbar_title = "My Heatmap")
    xlabel!("Random X")
    ylabel!("Random Y")
plot2 = plot(data[!, "SepalLength"], label = "Sepal Length", 
    st = :histogram, bins = 10, norm = :probability)
    xlabel!("Bins")
    ylabel!("Frequency")
plot(plot1, plot2, layout = (1, 2), 
    size = (800,400), 
    dpi = 300)

plot3 = plot(mapY, mapX, D, st = :heatmap, 
    cmap = :jet, clim = (-1, 1), 
    colorbar_title = "Another Heatmap")
    xlabel!("Random X")
    ylabel!("Random Y")
toSave = plot( plot(plot1, plot2), plot3, 
    layout = (2, 1), 
    margin = (5, :mm), 
    size = (1000,800), 
    dpi = 300)

# Saving
savefig(toSave, "threePlots.png")
savefig(toSave, "threePlots.svg")
savefig(toSave, "threePlots.pdf")