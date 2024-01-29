# Data exploration
using DataSci4Chem
data = dataset("datasets", "iris")

## data summary
data[1:5, :]
dataCol = Matrix(data[:, 1:4])
dataColAvg = mean(dataCol, dims = 1)
dataColMed = median(dataCol, dims = 1)
dataColMin = minimum(dataCol, dims = 1)
dataColMax = maximum(dataCol, dims = 1)

missX = [1, missing, 3]
miss1, miss2, miss3 = ismissing.(missX)  # return boolean 1-by-1 in 1 and 0
println(miss1, miss2, miss3)  # return boolean
# 1 is missing, 0 is not missing

x1 = deepcopy(missX)
x1[ismissing.(missX)] .= -99  # filling missing values
println(x1)  # [1, -99, 3]

nullX = [1, NaN, 3]
sum(nullX)
x2 = deepcopy(nullX)
x2[isnan.(nullX)] .= -199
println(x2)

## DataFrame
df = DataFrame(x = [1, missing, 3])
replace!(df.x, missing => -99)
df

df2 = DataFrame(x = [1, NaN, 3])
replace!(df2.x, NaN => -199)
df2

describe(data)

## Imputation
### Hot-deck
df = DataFrame(
  :a => [1.0, 2.0, missing, missing, 5.0],  # missing = 2
  :b => [1.1, 2.2, 3.3, missing, 5.5]  # missing 3.3
)

df = DataFrame(
  :a => [1.0, 2.0, 2, 2, 5.0],  # missing = 2
  :b => [1.1, 2.2, 3.3, 3.3, 5.5]  # missing 3.3
)

### mean/ median
### regression

## data dimensionality
### redundant variables, highly correlating variables
### don't need to have all those variables be included in model (one of thembring enough info. for the potential model)
#### correlation analysis (to detect potential redundancies)
##### pairwise correlation coefficient analysis
###### linear relationship, Pearson correlation
dataCol
corPearson = cor(dataCol)
heatmapToSave = heatmap(corPearson, xlabel = "variable number", ylabel = "variable number", 
    colorbar_title = "Pearson correlation", dpi = 300)
savefig(heatmapToSave, "corPearson.png")

linearCorr = corPearson[4, 1]
# 0.81794 is close to 1
scatterToSave = scatter(dataCol[:, 1], dataCol[:, 4], 
    xlabel = "Sepal Length", ylabel = "Petal Width", label = "$linearCorr", dpi = 300)
savefig(scatterToSave, "scatterLinearCorr.png")

linearNCorr = corPearson[2, 1]
# -0.11757 is close to 0
scatterToSave2 = scatter(dataCol[:, 1], dataCol[:, 2], 
    xlabel = "Sepal Length", ylabel = "Sepal Width", label = "$linearNCorr", dpi = 300)
savefig(scatterToSave2, "scatterNLinearCorr.png")

###### non-linear, Spearman correlation (non-parametric -> ranks)
corSpearman = cor(dataCol)
heatmapToSave2 = heatmap(corSpearman, xlabel = "variable number", ylabel = "variable number", 
    colorbar_title = "Spearman correlation", dpi = 300)
savefig(heatmapToSave2, "corSpearman.png")