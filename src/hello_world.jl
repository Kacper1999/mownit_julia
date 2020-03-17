#=
hello_world:
- Julia version: 1.3.1
- Author: Kacper
- Date: 2020-03-12
=#
using DataFrames
using LinearAlgebra
using CSV

v1 = DataFrame(c1 = 1:10, c2 = 2:11)
v2 = DataFrame(c1 = 2:11, c2 = 1:10)

function dot_product(df1, df2)
    return LinearAlgebra.dot(df1[!, 1], df2[!, 1])
end

df = DataFrame(col1 = 1:10, col2 = 1:10, col3 = 1:10)
a = [[1, 2], [3, 4]]
u = [1 4; 2 3]
println(a)
println(u)
println(a * u)


@time dot_product(v1, v2)

for i in 1:10
    println(i)
end

readline()

