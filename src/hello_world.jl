#=
hello_world:
- Julia version: 1.3.1
- Author: Kacper
- Date: 2020-03-12
=#
using DataFrames, LinearAlgebra, CSV, Plots, Statistics


function time_dot(loops_num, lower_size, upper_size, step)
    different_sizes_num = (upper_size - lower_size + step) ÷ step

    types = [String]
    types = vcat(types, [Float64 for i in 1:loops_num])
    col_names = [Symbol("Type and size")]
    col_names = vcat(col_names, [Symbol("$i sample") for i in 1:loops_num])
    measurements = DataFrame(types, col_names, 0)

    for i in lower_size:step:upper_size
        row = []
        push!(row, "Dot product of vectors with lengths: $i")
        for j in 1:loops_num
            v1 = rand(Int, i)
            v2 = rand(Int, i)
            push!(row, @elapsed LinearAlgebra.dot(v1, v2))
        end
        push!(measurements, row)
    end
    return measurements
end


function time_mlp(loops_num, lower_size, upper_size, step)
    different_sizes_num = (upper_size - lower_size + step) ÷ step

    types = [String]
    types = vcat(types, [Float64 for i in 1:loops_num])
    col_names = [Symbol("Type and size")]
    col_names = vcat(col_names, [Symbol("$i sample") for i in 1:loops_num])
    measurements = DataFrame(types, col_names, 0)

    for i in lower_size:step:upper_size
        row = []
        push!(row, "Matrix and vector multiplication with length: $i")
        for j in 1:loops_num
            m = rand(Int, (i, i))
            v = rand(Int, (i, 1))
            push!(row, @elapsed m * v)
        end
        push!(measurements, row)
    end
    return measurements
end

write_result(dot_time, mlp_time) = CSV.write("lab2.csv", join(dot_time, mlp_time, on = :Measurement_num))


LOOPS_NUM = 10

#
DOT_LOWER = 10000
DOT_UPPER = 1000000
DOT_STEP = 50000
# DOT_NUM = (DOT_UPPER - DOT_LOWER + DOT_STEP) ÷ DOT_STEP
#
MLP_LOWER = 200
MLP_UPPER = 800
MLP_STEP = 100
# MLP_NUM = (MLP_UPPER - MLP_LOWER + MLP_STEP) ÷ MLP_STEP
#
dot = time_dot(LOOPS_NUM, DOT_LOWER, DOT_UPPER, DOT_STEP)
show(dot)
println("")
mlp = time_mlp(LOOPS_NUM, MLP_LOWER, MLP_UPPER, MLP_STEP)
show(mlp)
append!(dot, mlp)
show(dot)

# write_result(dot, mlp)
#
#
# data = CSV.read("lab2.csv")
# stds = []
# means = []
#
# for col in names(data[!, 2:end])
#     append!(means, mean(data[!, col]))
#     append!(stds, std(data[!, col], mean=means[end]))
# end
#
# p1 = scatter(DOT_LOWER:DOT_STEP:DOT_UPPER, means[1:DOT_NUM], yerr=stds[1:DOT_NUM],
#     title="Dot Time", xlabel="Vector size", ylabel="Time[s]")
# p2 = scatter(MLP_LOWER:MLP_STEP:MLP_UPPER, means[(DOT_NUM + 1):end], yerr=stds[(DOT_NUM + 1):end],
#     title="Multiply Time", xlabel="Square matrix size ^1/2", ylabel="Time[s]")
# scatter(p1, p2, layout=2)

readline()

