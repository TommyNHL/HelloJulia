# DataSci4Chem
using DataSci4Chem
mean([2, 4, 2])  # ACS package, wrong precision

## for loop
for i = 1:11  # inclusive, 11 is included
  println(i)
end

for i = 1:2:11
  println(i)
end

arr = collect(1:6)
println(arr)

arr = [2, 3, 6]
println(arr)

extract = arr
println(extract)

arr = collect(1:6)
println(arr)

lenArr = length(extract)
println(lenArr)

arr2 = zeros(lenArr)  # set double 0.0
println(arr2)

println(arr, arr2, extract, lenArr)
for i = 1:lenArr
  arr2[i] = arr[extract[i]] * 2
end
println(arr, arr2, extract, lenArr)

## while loop
i = 1
while i <= 8
  println(i)
  i += 1
  #i++
  println(i)
end

## if, else, else-if
for i = 1:12
  if rem(i, 2) .!= 0  # if the remainder is 0, !=, ==, .==, .!=
    println(i)
  end
end

for i in collect(1:10)
  if rem(i, 2) .== 0  # if the remainder is 0, !=, ==, .==, .!=
    println("the number $i is even")
  elseif rem(i, 3) .== 0
    println("friends of 3, it is ", i)
  else
    println("the no. $i is odd")
  end
end

## functions
function evenOrOdd(numArr)
  for num in numArr
    if rem(num, 2) .== 0
      println("$num is even")
    else
      println("$num is odd")
    end
  end
end
evenOrOdd(collect(1:10))

arr2d = [collect(1:10), collect(2:5), collect(3), collect(5:10)]
function findSingle(arr2d)
  for arr in arr2d
    if length(arr) != 1 || rem(arr[1], 2) .== 0
      println(evenOrOdd(arr))
    elseif length(arr) == 1 && rem(arr[1], 2) .!= 0
      return false
    end
  end
end
findSingle(arr2d)

# local and global variable
count = 0
function countAddAdd(int)
  count = int + 1
  return count
end
count = countAddAdd(count) + count
println(count)

# loading / saving Data
df = DataFrame(ind= 1:4, char= ['Y', 'y', 'n', 'N'])
path = "C:/github/HelloJulia/df.csv"
CSV.write(path, df)
df2 = CSV.File("df.csv")
print(df2)
println(df2)
size(df2)
size(df)
size(df, 1)
size(df, 2)
df2
df2 = DataFrame(df2)
df
size(df2)
df2 = DataFrame(CSV.File("df.csv"))
size(df2)  == size(df)