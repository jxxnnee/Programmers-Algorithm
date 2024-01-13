/*
문제 설명
한자리 숫자가 적힌 종이 조각이 흩어져있습니다. 흩어진 종이 조각을 붙여 소수를 몇 개 만들 수 있는지 알아내려 합니다.
각 종이 조각에 적힌 숫자가 적힌 문자열 numbers가 주어졌을 때, 종이 조각으로 만들 수 있는 소수가 몇 개인지 return 하도록 solution 함수를 완성해주세요.

제한사항
numbers는 길이 1 이상 7 이하인 문자열입니다.
numbers는 0~9까지 숫자만으로 이루어져 있습니다.
"013"은 0, 1, 3 숫자가 적힌 종이 조각이 흩어져있다는 의미입니다.
*/


import Foundation

func solution(_ numbers:String) -> Int {
    let componented: [String] = numbers.map { String($0) }
    var permutated: Set<Int> = Set(componented.compactMap({ Int($0) }))
    
    for i in 1...componented.count {
        let temp = permutation(at: componented, pick: i)
        permutated = permutated.union(temp)
    }
    
    return permutated.filter { isPrime($0) }.count
}

func permutation(at array: [String], pick count: Int) -> Set<Int> {
    var results: Set<Int> = []
    
    func dfs(_ arr: [String], _ index: Int = 0) {
        if index == count {
            let result = Int(Array(arr[0..<index]).reduce("", +)) ?? 0
            results.insert(result)
            return
        }
        
        var temp = arr
        for i in index..<temp.count {
            temp.swapAt(i, index)
            dfs(temp, index+1)
            temp.swapAt(i, index)
        }
    }
    
    dfs(array)
    return results
}

func isPrime(_ num: Int) -> Bool {
    if num < 4 {
        return num < 2 ? false : true
    }
    
    for i in 2...Int(sqrt(Double(num))) {
        if(num % i == 0) { return false }
    }
    
    return true
}
