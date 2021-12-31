# Imports
# begin
#     import Pkg;
#     packages = ["ScikitLearn","RDatasets"]   
#     Pkg.add(packages)
# end

# Loading, cleaning, and manipulating the data
import Pkg;
Pkg.add("DataFrames")
# Pkg.add("MLDataUtils")
# Pkg.add("DecisionTree")
# begin
    # using MLDataUtils
    # X, Y, fnames = load_iris(150);
    # using RDatasets: dataset
    # using DataFrames
    # iris = dataset("datasets", "iris")
    # names!(iris, [:A, :B, :C, :D, :E])
    # X = convert(Array, iris[[:A, :B, :C, :D]])
    
    # print(X)
    # print(Y)
    # print(fnames)
# end

begin
    using DecisionTree
    X, Y = load_data("iris")
    X = float.(X)
    Y = string.(Y)
    model = DecisionTreeClassifier(max_depth=2)
    fit!(model, X, Y)
    print_tree(model, 5)
    # model = build_tree(Y, X)
    # model = prune_tree(model, 0.9)
    # print_tree(model,5)
end

