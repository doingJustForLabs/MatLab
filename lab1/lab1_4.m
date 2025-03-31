%4
firstArray = [1,2,3; 1,2,3]
secondArray = [1,2; 2,3; 3,4]

multuiplyArrays = secondArray * firstArray
firstArray = transpose(firstArray)
firstArray + secondArray
times(firstArray, secondArray) % multiplies arrays A and B by multiplying corresponding elements
