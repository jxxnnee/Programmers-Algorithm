/*
괄호가 바르게 짝지어졌다는 것은 '(' 문자로 열렸으면 반드시 짝지어서 ')' 문자로 닫혀야 한다는 뜻입니다. 예를 들어

"()()" 또는 "(())()" 는 올바른 괄호입니다.
")()(" 또는 "(()(" 는 올바르지 않은 괄호입니다.
'(' 또는 ')' 로만 이루어진 문자열 s가 주어졌을 때, 문자열 s가 올바른 괄호이면 true를 return 하고, 올바르지 않은 괄호이면 false를 return 하는 solution 함수를 완성해 주세요.

제한사항
- 문자열 s의 길이 : 100,000 이하의 자연수
- 문자열 s는 '(' 또는 ')' 로만 이루어져 있습니다.
*/



import Foundation

func solution(_ s:String) -> Bool
{
    /// 중간에 break 해서 나왔는지 체크하는 변수
    var exit: Bool = false
    var brackets: [String] = []
    
    for str in s {
        if str == "(" {
            /// 여는 괄호라면 배열에 추가한다.
            brackets.append(String(str))
        } else 
        if str == ")" {
            /// 닫는 괄호라면 배열의 마지막 여는 괄호를 빼준다.
            if nil == brackets.popLast() {
                /// 만약 배열 안에 괄호가 없다면
                /// exit에 true를 할당하고 즉시 for문을 중단한다.
                exit = true
                break
            }
        }
    }

    /// 중간에 break 해서 나왔다면 무조건 false를 리턴한다.
    if exit  { 
        return false 
    }

    /// 배열안에 아직 남은 괄호가 있다면 false를 리턴하고
    /// 배열안에 남은 괄호가 없다면 true를 리턴한다.
    return brackets.count > 0 ? false : true
}
