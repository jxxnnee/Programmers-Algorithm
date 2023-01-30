/*
문제 설명

셀수있는 수량의 순서있는 열거 또는 어떤 순서를 따르는 요소들의 모음을 튜플(tuple)이라고 합니다. n개의 요소를 가진 튜플을 n-튜플(n-tuple)이라고 하며, 다음과 같이 표현할 수 있습니다.
(a1, a2, a3, ..., an)
튜플은 다음과 같은 성질을 가지고 있습니다.
중복된 원소가 있을 수 있습니다. ex : (2, 3, 1, 2)
원소에 정해진 순서가 있으며, 원소의 순서가 다르면 서로 다른 튜플입니다. ex : (1, 2, 3) ≠ (1, 3, 2)
튜플의 원소 개수는 유한합니다.
원소의 개수가 n개이고, 중복되는 원소가 없는 튜플 (a1, a2, a3, ..., an)이 주어질 때(단, a1, a2, ..., an은 자연수), 이는 다음과 같이 집합 기호 '{', '}'를 이용해 표현할 수 있습니다.
{{a1}, {a1, a2}, {a1, a2, a3}, {a1, a2, a3, a4}, ... {a1, a2, a3, a4, ..., an}}
예를 들어 튜플이 (2, 1, 3, 4)인 경우 이는
{{2}, {2, 1}, {2, 1, 3}, {2, 1, 3, 4}}
와 같이 표현할 수 있습니다. 이때, 집합은 원소의 순서가 바뀌어도 상관없으므로
`{{2}, {2, 1}, {2, 1, 3}, {2, 1, 3, 4}}`
`{{2, 1, 3, 4}, {2}, {2, 1, 3}, {2, 1}}`
`{{1, 2, 3}, {2, 1}, {1, 2, 4, 3}, {2}}`
는 모두 같은 튜플 (2, 1, 3, 4)를 나타냅니다.
특정 튜플을 표현하는 집합이 담긴 문자열 s가 매개변수로 주어질 때, s가 표현하는 튜플을 배열에 담아 return 하도록 solution 함수를 완성해주세요.

제한사항

s의 길이는 5 이상 1,000,000 이하입니다.
s는 숫자와 '{', '}', ',' 로만 이루어져 있습니다.
숫자가 0으로 시작하는 경우는 없습니다.
s는 항상 중복되는 원소가 없는 튜플을 올바르게 표현하고 있습니다.
s가 표현하는 튜플의 원소는 1 이상 100,000 이하인 자연수입니다.
return 하는 배열의 길이가 1 이상 500 이하인 경우만 입력으로 주어집니다.
*/

import Foundation

func solution(_ s:String) -> [Int] {
    let strArr = s.map { String($0) }
    let removed = removeBracket(strArr)
    let intArr = convert(from: removed)
    
    return duplicated(intArr)
}

/// 문자열 양 끝의 브라켓을 지워준다.
func removeBracket(_ strArr: [String]) -> [String] {
    var temp = strArr
    temp.removeFirst()
    temp.removeLast()
    
    return temp
}
/// 문자열 배열로 바뀐 숫자들을 Int 배열로 변환한다.
func convert(from strArr: [String]) -> [Int] {
    var flag: Bool = false
    var tempStr: String = ""
    var tempArr: [Int] = []
    var result: [[Int]] = []
    
    /// strArr = ["{", "2", "}", ",", "{", "2", ",", "1", "}"]
    for str in strArr {
        guard flag else {
            /// flag가 닫혀있고 괄호가 열리는 상황이면 flag를 다시 열어준다.
            if str == "{" {
                flag = true
            }
            
            continue
        }
        
        if str == "}" {
            /// 괄호가 닫히므로 flag도 닫아준다.
            flag = false
            
            /// tempStr에 남은 숫자가 있다면 tempArr에 더해주고
            /// tempStr 초기화
            if let intValue = Int(tempStr) {
                tempArr.append(intValue)
            }
            tempStr = ""
            
            /// 결과값에 tempArr을 추가하고
            /// tempArr 초기화
            result.append(tempArr)
            tempArr.removeAll()
        } else
        if str == "," {
            /// flag가 열려있는데 쉼표가 온다면 다음 숫자가 나오므로
            /// tempStr을 tempArr에 더해주고 tempStr 초기화.
            if let intValue = Int(tempStr) {
                tempArr.append(intValue)
            }
            tempStr = ""
        } else {
            /// 숫자 문자열을 tempStr에 더한다.
            tempStr += str
        }
    }
    
    /// 2차원 배열을 각 배열의 갯수로 정렬하고
    /// flatMap을 통해 1차원 배열로 치환한다.
    return result.sorted(by: {
        $0.count < $1.count
    }).flatMap { $0 }
}
/// 중복되는 값들은 제외하고 배열에 순서대로 넣어준다.
func duplicated(_ intArr: [Int]) -> [Int] {
    var result: [Int] = []
    
    for int in intArr {
        if result.firstIndex(of: int) == nil {
            result.append(int)
        }
    }
    
    return result
}
