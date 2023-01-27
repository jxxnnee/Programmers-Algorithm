/*
문제 설명

다음 규칙을 지키는 문자열을 올바른 괄호 문자열이라고 정의합니다.
(), [], {} 는 모두 올바른 괄호 문자열입니다.
만약 A가 올바른 괄호 문자열이라면, (A), [A], {A} 도 올바른 괄호 문자열입니다. 예를 들어, [] 가 올바른 괄호 문자열이므로, ([]) 도 올바른 괄호 문자열입니다.
만약 A, B가 올바른 괄호 문자열이라면, AB 도 올바른 괄호 문자열입니다. 예를 들어, {} 와 ([]) 가 올바른 괄호 문자열이므로, {}([]) 도 올바른 괄호 문자열입니다.
대괄호, 중괄호, 그리고 소괄호로 이루어진 문자열 s가 매개변수로 주어집니다. 이 s를 왼쪽으로 x (0 ≤ x < (s의 길이)) 칸만큼 회전시켰을 때 s가 올바른 괄호 문자열이 되게 하는 x의 개수를 return 하도록 solution 함수를 완성해주세요.

제한사항

s의 길이는 1 이상 1,000 이하입니다.
*/

import Foundation

func solution(_ s:String) -> Int {
    /// 문자열을 문자 배열로 변경한다.
    var strArr = s.map { String($0) }
    var result: Int = 0
    
    /// 0 ≤ x < (s의 길이) 
    for index in 0..<strArr.count {
        /// 올바른 괄호인지 체크한다.
        if check(strArr) {
            /// 올바른 경우 결과값에 1을 추가한다.
            result = result + 1
        }
        
        /// 괄호를 회전한다.
        strArr = rotate(strArr)
    }
    
    return result
}

func check(_ brackets: [String]) -> Bool {
    var stack: [String] = []
    var count: Int = 0 
    brackets.forEach {
        switch $0 {
            /// 여는 괄호라면 stack에 추가한다.
            /// 한번이라도 추가가 됐는지 count로 체크한다.
            case "(", "[", "{":
                stack.append($0)
                count = count + 1
            /// 닫는 괄호라면 stack의 마지막이 짝이랑 맞는지 확인하고
            /// 맞다면 stack의 마지막을 제거한다.
            case "}":
                if stack.last == "{" {
                    stack.removeLast()
                }
            case "]":
                if stack.last == "[" {
                    stack.removeLast()
                }
            case ")":
                if stack.last == "(" {
                    stack.removeLast()
                }
            default:
                break
        }
    }
    
    /// 한번 이상 여는 괄호가 있었고, stack이 비워져 있다면 올바른 괄호 문자열이다. 
    return count > 0 && stack.isEmpty
}

func rotate(_ brackets: [String]) -> [String] {
    var temp = brackets
    let first = brackets[0]
    
    temp.removeFirst()
    temp.append(first)
    
    return temp
}
