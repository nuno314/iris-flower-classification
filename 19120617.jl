# import Pkg
# Pkg.add("CSV")
# Pkg.add("DataFrames")

MINIMUM_SAMPLE_SIZE = 1
MAX_TREE_DEPTH = 10


function index_attribute(attribute)
    if attribute == "sepal_length"
        return 1
    elseif attribute == "sepal_width"
        return 2
    elseif attribute == "petal_length"
        return 3
    else
        return 4
    end
end
mutable struct ID3_tree
    dataset
    isLeaf
    split_attribute
    split
    attribute_list
    attribute_values
    left_child
    right_child
    depth
    prediction
end
function build_Tree(tree, training, attr_label)
    if tree.depth < MAX_TREE_DEPTH && length(training) >= MINIMUM_SAMPLE_SIZE
        max_gain, attribute, split = max_info_gain(attr_label, training)
        if max_gain > 0
            #chia cay
            tree.split = split
            tree.split_attribute = attribute
            #tao nhanh
            index_attr = index_attribute(attribute)
            training_left = [elem for elem in training if elem[index_attr] < split]
            training_right = [elem for elem in training if elem[index_attr] >= split]
            tree.left_child = ID3_tree(training_left, false, nothing, nothing, nothing, nothing, nothing, nothing, tree.depth +1, nothing)
            tree.right_child = ID3_tree(training_right, false, nothing, nothing, nothing, nothing, nothing, nothing, tree.depth +1, nothing)
            build_Tree(tree.left_child, training_left, attr_label)
            build_Tree(tree.right_child, training_right, attr_label)
        else
            tree.isLeaf = true
        end
    else
        tree.isLeaf = true
    end

    if tree.isLeaf == true
        setosa_count = versicolor_count = virginica_count = 0
        for elem in training
            if elem[end] == "Iris-setosa"
                setosa_count += 1
            elseif elem[end] == "Iris-versicolor"
                versicolor_count += 1
            else
                virginica_count += 1
            end
        end
        dominant_class = "Iris-setosa"
        dom_class_count = setosa_count
        if versicolor_count >= dom_class_count
            dom_class_count = versicolor_count
            dominant_class = "Iris-versicolor"
        end
        if virginica_count >= dom_class_count
            dom_class_count = virginica_count
            dominant_class = "Iris-virginica"
        end
        tree.prediction = dominant_class
    end
end

function entropy(training)
    if length(training) == 0
        return 0
    end
    
    target_attribute_name = "species"
    target_attribute_values = ["Iris-setosa", "Iris-versicolor", "Iris-virginica"]
    data_entropy = 0
    for val in target_attribute_values
        p = length([elem for elem in training if elem[end] == val]) / length(training)
        if p > 0
            data_entropy += -p * log2(p)
        end
    end
    return data_entropy
end

function info_gain(attr_label_index, split, training)
    #set_smaller = nothing
    p_smaller = nothing
    #set_greater_equals = nothing
    p_greater_equals = nothing
    
    set_smaller = [elem for elem in training if elem[attr_label_index] < split]
    p_smaller = length(set_smaller) / length(training)
    set_greater_equals = [elem for elem in training if elem[attr_label_index] >= split]
    p_greater_equals = length(set_greater_equals) / length(training)

    info_gain = entropy(training)
    info_gain -= p_smaller * entropy(set_smaller)
    info_gain -= p_greater_equals * entropy(set_greater_equals)
end

function max_info_gain(attr_label, training)
    max_info_gain = 0
    max_info_gain_attribute = nothing
    max_info_gain_split= nothing
    split = nothing
    split_info_gain = nothing
    count = 0
    for count in 1:4
        #label = attr_label[count]
        for split in training
            split_info_gain = info_gain(count, split[count], training)
            if split_info_gain >= max_info_gain
                max_info_gain = split_info_gain
                max_info_gain_attribute = attr_label[count]
                max_info_gain_split = split[count]
            end
        end
    end
    return max_info_gain, max_info_gain_attribute, max_info_gain_split
end

function predict(tree, sample)
    tree.isLeaf = 
    if tree.isLeaf
        return
    end
end


function divide_dataset(dt)
	matrix = Matrix(dt)
	training =[]
	test = []
	for i in 1:150
        if i<= 50
			push!(test,matrix[i,:])
        else
            push!(training,matrix[i,:])
        end
	end
	return training,test
end

function merge_leaves(tree)
    if tree.isLeaf == false
        merge_leaves(tree.left_child)
        merge_leaves(tree.right_child)
        if tree.left_child.isLeaf && tree.right_child.isLeaf && tree.left_child.prediction == tree.right_child.prediction
            tree.isLeaf = true
            tree.prediction = tree.right_child.prediction
        end
    end
end

function predict(tree, sample)
    if tree.isLeaf == true
        return tree.prediction
    else
        if sample[index_attribute(tree.split_attribute)] < tree.split
            return predict(tree.left_child, sample)
        else
            return predict(tree.right_child, sample)
        end
    end
end

function print_treeDecision(tree, prefix)
    if tree.isLeaf == true
        println("\t" ^ tree.depth * prefix * tree.prediction)
    else
        println("\t" ^ tree.depth * prefix * tree.split_attribute * "<" * string(tree.split) * "?")
        print_treeDecision(tree.left_child, "[Yes]")
        print_treeDecision(tree.right_child, "[No]")
    end
end


#dataset = read_dataset()
using CSV, DataFrames, Random
dt = CSV.read("IRIS.csv", DataFrame)
if dt === nothing
    print("dataset is empty!")
    exit(1)
end

dt = dt[shuffle(1:size(dt, 1)),:]
training_data, test_data = divide_dataset(dt)
attr_label = names(dt) #luu nhan cua cac cot thuoc tinh

#print("dataset size:", length(dataset))
println("LENGTH OF TYPE OF DATA (TRAINING AND TEST)")
println("training set size:", length(training_data))
println("test set size:", length(test_data))

treeDecision = ID3_tree(training_data, false, nothing, nothing, nothing, nothing, nothing, nothing, 0, nothing)
build_Tree(treeDecision, training_data, attr_label)
merge_leaves(treeDecision)

accuracy = 0
for sample in test_data
    if sample[end] == predict(treeDecision, sample)
        accuracy +=1
    end
end
accuracy /= length(test_data)
accuracy *=100
println("\n\nDECISION TREE")
print_treeDecision(treeDecision, " ")

print("accuracy on test dataset: ", accuracy, " %")
