    # Imports
    # begin
    #     import Pkg;
    #     packages = ["CSV","DataFrames", "StatsBase"]   
    #     Pkg.add(packages)
        using CSV, DataFrames, StatsBase
    # end

    # split_dataset IRIS into training and test, rate 2:1
    function split_dataset(df)
        matrix = Matrix(df)
        training =[]
        test = []
        training_size = 100
        matrix_range = 1:150
        training_rows = sample(matrix_range, training_size, replace = false)
        for i in matrix_range
            if i in training_rows
                push!(training, matrix[i,:])
            else
                push!(test, matrix[i,:])
            end
        end
        return training,test
    end 

    #struct cho node cua decision tree
    struct node
        is_leaf::Bool
        value_split::Float64
        feature_split::Int64	
        childLow::Union{Missing,node}
        childHigh::Union{Missing,node}
        leafClass::String
    end

    struct ID3_decision_tree
        root::node
        dataset::Vector{}

        function ID3_decision_tree(dataset)
            dataset = dataset
            classes = []
            for i in dataset
                if !(i[5] in classes)
                    push!(classes,i[5])
                end
            end

            if length(classes) == 1
                root = node(true,0,0,missing,missing,classes[1])
                # return node(true,0,0,missing,missing,classes[1])
            else
                cutoff, feature = minEntropy(dataset)
                low, high = splitdataset(dataset,cutoff,feature)
                root = node(false,dataset[cutoff][feature],feature,ID3_decision_tree(low),ID3_decision_tree(high)," ")
                # return node(false,dataset[cutoff][feature],feature,ID3_decision_tree(low),ID3_decision_tree(high)," ")
            end
        end

        function minEntropy(dataset)
            minEntropys = 100
            bestCutoff = 100
            bestfeature = 100
            nClass = read_dataset(dataset)
        
            for i in 1:length(dataset)
                for j in 1:4
                    temp = entropyWithFiltered(dataset,nClass,i,j)
                    if temp < minEntropys
                        minEntropys = temp
                        bestCutoff = i
                        bestfeature = j
                    end
                end
            end
            return bestCutoff, bestfeature
        end
        
    end


    #dem moi class co bao nhien phan tu
    function read_dataset(dataset)
        res = [0,0,0]
        class = ["Iris-setosa","Iris-versicolor","Iris-virginica"]
        for i in 1:length(dataset)
            for j in 1:length(class)
                if dataset[i][5] == class[j]
                    res[j] +=1
                end
            end
        end

        return res
    end

    #tinh entroypy dua theo cutoff
    function entropyWithFiltered(dataset,nClass,cutoff,feature)
        lower = []
        higher = []
        n = length(dataset)
        nHigh = 0
        nLow = 0
        temp = 0
        for j in nClass
            if j == 0
                push!(lower,0)
                push!(higher,0)
                continue
            end
            tempLow = 0
            tempHigh = 0
            for i in 1:j
                if dataset[temp + i][feature] < dataset[cutoff][feature]
                    tempLow += 1
                    nLow += 1
                else 
                    tempHigh += 1
                    nHigh += 1
                end
            end
            push!(lower,tempLow)
            push!(higher,tempHigh)
            temp += j
        end

        res_low = 0
        res_high = 0
        for i in 1:length(nClass)
            if lower[i] != 0
                res_low += -(lower[i]/nLow)*log2(lower[i]/nLow)
            end
            if higher[i] != 0
                res_high += -(higher[i]/nHigh)*log2(higher[i]/nHigh)
            end
        end
        return res_low*nLow/n + res_high*nHigh/n
    end

    #ham lan luot lay tung dong trong du lieu lam cutoff va tinh entropy
    #tra ve cutoff tot nhat
    # function minEntropy(dataset)
    #     minEntropys = 100
    #     bestCutoff = 100
    #     bestfeature = 100
    #     nClass = read_dataset(dataset)

    #     for i in 1:length(dataset)
    #         for j in 1:4
    #             temp = entropyWithFiltered(dataset,nClass,i,j)
    #             if temp < minEntropys
    #                 minEntropys = temp
    #                 bestCutoff = i
    #                 bestfeature = j
    #             end
    #         end
    #     end
    #     return bestCutoff, bestfeature
    # end

    #chia du lieu thanh hai nua dua vao cutoff
    function splitdataset(dataset,cutoff,feature)
        low = []
        high = []
        for i in 1:length(dataset)
            if(dataset[i][feature] < dataset[cutoff][feature])
                push!(low,dataset[i])
            else
                push!(high,dataset[i])
            end
        end
        return low,high
    end

    #ham tra ve true/false khi kiem tra xem class co đung nhu cây dư đoán không
    function testTarget(root::node, target)
        if root.is_leaf
            return target[5] == root.leafClass
        end
        if root.value_split > target[root.feature_split]
            temp = root.childLow::node
            return testTarget(temp,target)
        else
            temp = root.childHigh::node
            return testTarget(temp,target)
        end
    end
    #ham lay lan luot tung phan tu trong du lieu test de tinh accuracy
    function testdataset(dataset,root)
        accuracy = 0
        for i in dataset
            if testTarget(root,i)
                accuracy+=1
            end
        end
        return accuracy/length(dataset)*100
    end


    #------------chuong trinh------------
    #dau tien ta doc file csv
    df = CSV.read("iris.csv",DataFrame)
    #tach du lieu ra 2 tap
    training,test = split_dataset(df)
    #tao Decision tree
    tree = ID3_decision_tree(training)
    print(typeof(training))

    #in ra accuracy
    print("accuracy: ")
    print(testdataset(test,tree))