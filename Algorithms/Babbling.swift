/*
머쓱이는 태어난 지 6개월 된 조카를 돌보고 있습니다. 조카는 아직 "aya", "ye", "woo", "ma" 네 가지 발음을 최대 한 번씩 사용해 조합한(이어 붙인) 발음밖에 하지 못합니다. 
문자열 배열 babbling이 매개변수로 주어질 때, 머쓱이의 조카가 발음할 수 있는 단어의 개수를 return하도록 solution 함수를 완성해주세요.

네 가지를 붙여 만들 수 있는 발음 이외에는 어떤 발음도 할 수 없는 것으로 규정합니다. 예를 들어 "woowo"는 "woo"는 발음할 수 있지만 "wo"를 발음할 수 없기 때문에 할 수 없는 발음입니다.
*/

import Foundation

func solution(_ babbling:[String]) -> Int {
    var result: Int = 0
    for b in babbling {
        if check(b) {
            result = result + 1
        }
    }
    
    return result
}

func check(_ str: String) -> Bool {
    let pronounces: [String] = ["aya", "ye", "woo", "ma"]
    var babbling = str
    
    for p in pronounces {
        // 해당 옹알이에 가능한 옹알이가 있는지 체크
        if let range = babbling.range(of: p) {
            // 있다면 * 문자로 변경 해준다.
            // 빈 문자열로 먼저 변경하는 경우
            // "wyeoo"는 "ye"가 먼저 없어지면 "woo"가 남아서
            // 가능한 옹알이가 되버린다.
            babbling.replaceSubrange(range, with: "*")
        }
    }

    // 이후 * 문자를 모두 제거해준뒤 빈 문자열만 남았다면 사용 가능한 옹알이다.
    babbling = babbling.components(separatedBy: "*").joined(separator: "")
    return babbling.isEmpty
}
