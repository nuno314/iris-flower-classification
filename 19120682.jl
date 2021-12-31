# Imports
# begin
#     import Pkg;
#     packages = ["CSV","ScikitLearn","DecisionTree]   
#     Pkg.add(packages)
# end
# import Pkg;
# Pkg.add("DataFrames")
begin
    using CSV, DataFrames
    iris = CSV.read("IRIS.csv", DataFrame)
    X = Array(iris[:, 1:4]);
    Y = Array(iris[:, 5]);
    x_training = X[1:100]
    y_training = Y[1:100]
    x_test = X[101:150]
    y_test = X[101:150]
    print(typeof(x_training))
end

function split_data(x::Array{Symbol}, n::Array)
    result = Vector{Vector{eltype(x)}}
    start = firstindex(x)
    for len in n
        push!(result, x[start:(start + len - 1)])
        start += len
    end
    result
end




# abstract type Node end

# struct DecisionTree
#     root::Node
#     data::Vector{AbstractString}
# end

# function print(io::IO, tree::DecisionTree)
#     nodes = Node[tree.root]
# end

# function decision_tree(x::Matrix{Symbol}, y::Matrix{Symbol})
#     using DecisionTree
#     tree = DecisionTree() 

# end

