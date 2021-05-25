//Question 1 - Reverse the array

//Iterative Approach
func reverseArrayIteratively(arr: [Int]) {
    var a = arr
    var i = 0
    var j = arr.count - 1
    while (i < j) {
        let temp = a[i]
        a[i] = a[j]
        a[j] = temp
        i += 1
        j -= 1
    }
    print(a)
}

//Recursive Approach
func reverseArrayRecursively(arr: [Int], start: Int, end: Int) {
    if start > end {
        print(arr)
        return
    }
    var a = arr
    let temp = a[start]
    a[start] = a[end]
    a[end] = temp
    reverseArrayRecursively(arr: a, start: start+1, end: end-1)
}

//-------------------------------------------------------------------------------------------------------------------//

//Question 2 - Get min and max of an array

//Iterative approach
func getMinMaxIteratively(arr: [Int]) {
    var i = 0
    var min = arr[0]
    var max = arr[0]
    
    while(i < arr.count) {
        
        if (min > arr[i]) {
            min = arr[i]
        }
        if (max < arr[i]) {
            max = arr[i]
        }
        i += 1
    }
    print("Min - \(min)")
    print("Max - \(max)")
}

//Recursive Approach - Break the array in two parts recursively, and then compare low, high of both parts.
func getMinMaxRecursively(arr: [Int], low: Int, high: Int) -> (Int, Int) {
    if low == high {
        return (arr[0], arr[0])
    }
    if low == high-1 {
        return arr[low] < arr[high] ? (arr[low], arr[high]) : (arr[high], arr[low])
    }
    
    
    let mid = (low + high) / 2
    let leftTuple = getMinMaxRecursively(arr: arr, low: low, high: mid)
    let rightTuple = getMinMaxRecursively(arr: arr, low: mid+1, high: high)
    
    let min = leftTuple.0 < rightTuple.0 ? leftTuple.0 : rightTuple.0
    let max = leftTuple.1 > rightTuple.1 ? leftTuple.1 : rightTuple.1
    return (min,max)
    
    
}

//------------------------------------------------- SORTINGS ------------------------------------------------------------------//

//Bubble Sort
//Logic - 01,12,23,34 | 01,12,23 | 01,12 | 01
func bubbleSort(arr: [Int]) -> [Int] {
    var a = arr
    var i = arr.count - 1
    while(i > 0) {
        var e = 0
        while (e < i) {
            let f = e + 1
            if (a[e] > a[f]) {
                let temp = a[e]
                a[e] = a[f]
                a[f] = temp
            }
            e += 1
        }
        i -= 1
    }
    return a
}

//-------------------------------------------------------------------------------------------------------------------//

//Selection Sort
//Logic - 01,02,03,04 | 12,13,14 | 23,24 | 34
func selectionSort(arr: [Int]) -> [Int] {
    var a = arr
    var i = 0
    while ( i < a.count) {
        let e = i
        var f = e + 1
        while (f < a.count) {
            if (a[e] > a[f]) {
                let temp = a[e]
                a[e] = a[f]
                a[f] = temp
            }
            f += 1
        }
        i += 1
    }
    return a
}

//-------------------------------------------------------------------------------------------------------------------//

//Quick Sort
func partition(arr: inout [Int], low: Int, high: Int) -> Int {
    let pivot = arr[low]
    var i = low
    var j = high
    
    while (i < j) {
        while(arr[i] <= pivot) {
            i += 1
            if i == arr.count {
                break
            }
        }
        
        while (arr[j] > pivot) {
            j -= 1
            if j == 0 {
                break
            }
        }
        if ( i < j) {
            let temp = arr[i]
            arr[i] = arr[j]
            arr[j] = temp
        }
    }
    
    let temp = arr[j]
    arr[j] = arr[low]
    arr[low] = temp
    return j
}

func quickSort(arr: inout [Int], low: Int, high: Int)  {
    if (low < high ) {
        
        let p = partition(arr: &arr, low: low, high: high)
        quickSort(arr: &arr, low: low, high: p - 1)
        quickSort(arr: &arr, low: p + 1, high: high)
    }
}

func quickSortWithSwiftFilter<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    return quickSortWithSwiftFilter(less) + equal + quickSortWithSwiftFilter(greater)
}

//-------------------------------------------------------------------------------------------------------------------//

//Merge Sort

func merge(left: [Int], right: [Int]) -> [Int] {
    var mainArray = [Int]()
    let countLeft = left.count
    let countRight = right.count
    var i = 0, j = 0
    
    while(i < countLeft && j < countRight) {
        if (left[i] < right[j]) {
            mainArray.append(left[i])
            i += 1
        } else {
            mainArray.append(right[j])
            j += 1
        }
    }
    
    while (i < countLeft) {
        mainArray.append(left[i])
        i += 1
    }
    
    while (j < countRight) {
        mainArray.append(right[j])
        j += 1
    }
    return mainArray
}

func mergeSort(arr: [Int]) -> [Int] {
    if arr.count < 2 {
        return arr
    }
    let mid = arr.count/2
    var left = [Int]()
    var right = [Int]()
    for i in 0 ..< mid {
        left.append(arr[i])
    }
    for i in mid ..< arr.count {
        right.append(arr[i])
    }
    let sortedLeft = mergeSort(arr: left)
    let sortedRight = mergeSort(arr: right)
    return merge(left: sortedLeft, right: sortedRight)
}
//-------------------------------------------------------------------------------------------------------------------//
// Question 3 - Find the "Kth" max and min element of an array

// This will be done using min heap (once we reach to heaps).

//-------------------------------------------------------------------------------------------------------------------//
// Question 4 - Given an array which consists of only 0, 1 and 2. Sort the array without using any sorting algo.
// or Dutch National Flag Problem

/*
 Conditions that are to be satisfied
 - All elements towards left of low will be 0
 - All elements towards right of high will be 2
 - All elements between low and mid-1 will be 1
 
 While iterating, check if a[mid] is
 0 -> swap(a[low], a[mid]) and low++, mid++
 1 -> mid++
 2 -> swap(a[mid], a[high] and high--
 
 Iteration will run till high > mid
 */

func dutchNationalFlagProblem(arr: [Int]) -> [Int] {
    var a = arr
    var low = 0, mid = 0, high = a.count - 1
    while mid <= high {
        switch a[mid] {
        case 0:
            a.swapAt(low, mid)
            low += 1
            mid += 1
            break
        case 1:
            mid += 1
            break
        case 2:
            a.swapAt(mid, high)
            high -= 1
            break
        default:
            break
        }
    }
    return a
}
//-------------------------------------------------------------------------------------------------------------------//
//Question 5: Move all the negative elements to one side of the array

//Approach 1 -> Sort i.e. nLogn

//Approch 2 -> Two Pointer
/*
 Iterate while h > l
 if both a[l] and a[h] are -ve, l++
 else if a[l] is +ve and a[h] is -ve, swap, l++, h--
 else if a[l] is -ve and a[h] is +ve, l++, h--
 else if both a[l] and a[h] are +ve, r--
 */

func moveNegativeToLeft(arr: [Int]) -> [Int] {
    var a = arr
    var l = 0
    var h = a.count - 1
    while (h > l) {
        print("in the loop")
        if (a[l] < 0 && a[h] < 0) {
            l += 1
        }
        else if (a[l] > 0 && a[h] < 0) {
            a.swapAt(l, h)
            l += 1
            h -= 1
        }
        else if (a[l] < 0 && a[h] >= 0) {
            l += 1
            h -= 1
        }
        else if (a[l] > 0 && a[h] >= 0) {
            h -= 1
        }
    }
    return a
}

//-------------------------------------------------------------------------------------------------------------------//
//Question 6: Find the Union and Intersection of the two sorted arrays.

//Approach 1 -
/*
 Apply the logic of merge (from merge sort). Just add one more condition for handling equality.
 If the elements are equal, add them in both union and intersection.
 */

func getUnionAndIntersection(a1: [Int], a2: [Int]) -> ([Int], [Int]) {
    var union = [Int]()
    var intersection = [Int]()
    var e = 0, f = 0
    
    while (e < a1.count && f < a2.count) {
        if (a1[e] < a2[f]) {
            union.append(a1[e])
            e += 1
        }
        else if (a1[e] > a2[f]) {
            union.append(a2[f])
            f += 1
        }
        else {
            union.append(a1[e])
            intersection.append(a1[e])
            e += 1
            f += 1
        }
    }
    
    while (e < a1.count) {
        union.append(a1[e])
        e += 1
    }
    while (f < a2.count) {
        union.append(a2[f])
        f += 1
    }
    
    return (union,intersection)
}

//-------------------------------------------------------------------------------------------------------------------//
/*
 Rotation of an Array.
 
 Approach 1 - Make temp array and then append
 Approach 2 - Reverse the sub arrays, and then reverse complete array (implemented below)
 Appraoch 3 - Juggligh Alogrithm
 
 Say n = 12, d = 3, a = 1,2,3,4,5,6,7,8,9,10,11,12]
 Take GCD of n,d (3 in this case)
 Because GCD is 3, make 3 sets
 [1,4,7,10]
 [2,5,8,11]
 [3,6,9,12]
 
 Now rotate elements of set 1 -> 4,2,3,7,5,6,10,8,9,1,11,12
 Rotate elements of set 2 -> 4,5,3,7,8,6,10,11,9,1,2,12
 Rotate elements of set 3 -> 4,5,6,7,8,9,10,11,12,1,2,3      => Answer
 */

//Question 7: Write a program to cyclically rotate an array by one.

func reverseArray(low: Int, high: Int, a: inout [Int]) {
    var l = low, h = high
    while(l < h) {
        a.swapAt(l, h)
        l += 1
        h -= 1
    }
}

func rotateArray(d: Int, arr: [Int]) -> [Int] {
    //Considering left rotation is to be done. [0, d-1], [d,n-1]
    //If right rotation is to be done, then [0, n-d-1], [n-d, n-1]
    var a = arr, n = arr.count
    reverseArray(low: 0, high: d-1, a: &a)
    reverseArray(low: d, high: n-1, a: &a)
    reverseArray(low: 0, high: n-1, a: &a)
    return a
}

//-------------------------------------------------------------------------------------------------------------------//
//Question 8: find Largest sum contiguous Subarray [V. IMP]
/*
 Approach: Kadane's Algo
 */

func largestSumContiguousSubArray(arr: [Int]) -> [Int] {
    var a = [Int]()     // Temp array for returning (optional)
    
    var start = 0           // to track the starting index of sub array
    var end = 0             // to track the end index of sub array
    var s = 0               // for updating start
    var maxSum = 0          // for storing max sum
    var currentSum = 0      // for storing sum till here
    var i = 0               // counter
    
    while i < arr.count {
        currentSum += arr[i]            // keep updating the sum till here
        
        if (currentSum < 0) {           // if sum till here got -ve, then array till here is to be discarded. So update s ahead of this point
            currentSum = 0
            s = i + 1
        }
        if (currentSum > maxSum) {      // if summ till here is > max sum so far, update max sum, start with s and end with i (this point)
            maxSum = currentSum
            end = i
            start = s
        }
        i += 1
    }
    
    for j in start ... end {
        a.append(arr[j])
    }
    return a
}

//----------------------------------------------- TEST FUNCTION --------------------------------------------------------------------//

func testFunc() {
    //    reverseArrayIteratively(arr: [1,2,3,4,5,6])
    //    reverseArrayRecursively(arr: [1,2,3,4,5,6], start: 0, end: 5)
    //    getMinMaxIteratively(arr: [4,3,5,7,1,2,10,0])
    //    print(getMinMaxRecursively(arr: [4,3,5,7,1,2,10,0], low: 0, high: 7))
    //    print(bubbleSort(arr: [2,3,1,6,8,4,5,7,4]))
    //    print(selectionSort(arr: [2,3,1,6,8,4,5,7,4]))
    //    print(quickSortWithSwiftFilter([2,3,1,6,8,4,5,7,4]))
    
    //    var numbers = [13, 77, 20, 45, 2, 15, 0, 59, 5, 68, 51, 1, -1, 8]
    //    quickSort(arr: &numbers, low: 0, high: 13)
    //    print(numbers)
    //    print(mergeSort(arr: [2,2,3,1,4,6,5,7,8]))
    //    print(dutchNationalFlagProblem(arr: [0,2,1,2,0,0,2]))
    //    print(moveNegativeToLeft(arr: [-12,-11,10,-4,2,0,-7,2,6,8]))
    
    //    let unionAndIntersection = getUnionAndIntersection(a1: [1,3,4,5,7], a2: [2,3,5,6])
    //    print("Union = \(unionAndIntersection.0) \nIntersection = \(unionAndIntersection.1)")
    //    print(rotateArray(d: 3, arr: [1,2,3,4,5,6,7]))
    //    print(largestSumContiguousSubArray(arr: [-2,-3,4,-1,-2,1,5,-3]))
}

testFunc()
