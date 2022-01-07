#import Pkg
#Pkg.add("CSV")
#Pkg.add("DataFrames")
#Pkg.add("StatsBase")
#dung khi ko co package CSV,DataFrames,StatsBase

#Thu vien CSV,DataFrame cho viec doc file
#Thu vien StatsBase cho viec random phan tu
using CSV, DataFrames, StatsBase

#struct cho node cua decision tree
struct TreeNode
	isLeaf::Bool
	value_split::Float64
	info_split::Int64	
	childLow::Union{Missing,TreeNode}
	childHigh::Union{Missing,TreeNode}
	leafClass::String
end

#dem moi class co bao nhien phan tu
function readDataset(data)
	#du lieu co 3 class
	res = [0,0,0]
	class = ["Iris-setosa","Iris-versicolor","Iris-virginica"]
	for i in 1:length(data)
		for j in 1:length(class)
			if data[i][5] == class[j]
				res[j] +=1
			end
		end
	end

	return res
end

#doc xem co nhung class nao trong data
function readIntoClass(data)
	res = []
	for i in data
		if !(i[5] in res)
			push!(res,i[5])
		end
	end
	return res
end

#tinh entroypy dua theo cutoff
function entropyWithFiltered(data,nClass,cutoff,info)
	lower = []
	higher = []
	n = length(data)
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
			if data[temp + i][info] < data[cutoff][info]
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
function minEntropy(data)
	minEntropys = 100
	bestCutoff = 100
	bestInfo = 100
	nClass = readDataset(data)

	for i in 1:length(data)
		for j in 1:4
			temp = entropyWithFiltered(data,nClass,i,j)
			if temp < minEntropys
				minEntropys = temp
				bestCutoff = i
				bestInfo = j
			end
		end
	end
	return bestCutoff, bestInfo
end

#chia du lieu thanh hai nua dua vao cutoff
function splitData(data,cutoff,info)
	low = []
	high = []
	for i in 1:length(data)
		if(data[i][info] < data[cutoff][info])
			push!(low,data[i])
		else
			push!(high,data[i])
		end
	end
	return low,high
end

#ham de quy de tao cay
#neu du lieu truyen vao chi co 1 class thi day la leafNode
#neu du lieu nhieu ta se tim ra entropy tot nhat, dung no de chia ra 2 treeNode 
function treeManagement(data)

	Classes = readIntoClass(data)
	if length(Classes) == 1
		return TreeNode(true,0,0,missing,missing,Classes[1])
	else
		cutoff, info = minEntropy(data)
		low, high = splitData(data,cutoff,info)
		return TreeNode(false,data[cutoff][info],info,treeManagement(low),treeManagement(high)," ")
	end
end
#ham tra ve true/false khi kiem tra xem class co đung nhu cây dư đoán không
function testTarget(root::TreeNode, target)
	if root.isLeaf
		return target[5] == root.leafClass
	end
	if root.value_split > target[root.info_split]
		temp = root.childLow::TreeNode
		return testTarget(temp,target)
	else
		temp = root.childHigh::TreeNode
		return testTarget(temp,target)
	end
end
#ham lay lan luot tung phan tu trong du lieu test de tinh accuracy
function testData(data,root)
	accuracy = 0
	for i in data
		if testTarget(root,i)
			accuracy+=1
		end
	end
	return accuracy/length(data)*100
end

#hàm random du lieu ra 2/3 cho training và 1/3 cho test (100 và 50)
function divide(df)
	matrix = Matrix(df)
	training =[]
	test = []
	a = sample(1:150, 100, replace = false)
	for i in 1:150
		if i in a
			push!(training,matrix[i,:])
		else
			push!(test,matrix[i,:])
		end
	end
	return training,test
end
#------------chuong trinh------------
#dau tien ta doc file csv
df = CSV.read("iris.csv",DataFrame)
#tach du lieu ra 2 tap
training,test = divide(df)
#tao Decision tree
root = treeManagement(training)
#in ra accuracy
print("accuracy: ")
print(testData(test,root))