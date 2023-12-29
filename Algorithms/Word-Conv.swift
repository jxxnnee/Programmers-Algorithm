/**
문제 설명
두 개의 단어 begin, target과 단어의 집합 words가 있습니다. 아래와 같은 규칙을 이용하여 begin에서 target으로 변환하는 가장 짧은 변환 과정을 찾으려고 합니다.

1. 한 번에 한 개의 알파벳만 바꿀 수 있습니다.
2. words에 있는 단어로만 변환할 수 있습니다.
예를 들어 begin이 "hit", target가 "cog", words가 ["hot","dot","dog","lot","log","cog"]라면 "hit" -> "hot" -> "dot" -> "dog" -> "cog"와 같이 4단계를 거쳐 변환할 수 있습니다.

두 개의 단어 begin, target과 단어의 집합 words가 매개변수로 주어질 때, 최소 몇 단계의 과정을 거쳐 begin을 target으로 변환할 수 있는지 return 하도록 solution 함수를 작성해주세요.

제한사항
- 각 단어는 알파벳 소문자로만 이루어져 있습니다.
- 각 단어의 길이는 3 이상 10 이하이며 모든 단어의 길이는 같습니다.
- words에는 3개 이상 50개 이하의 단어가 있으며 중복되는 단어는 없습니다.
- begin과 target은 같지 않습니다.
- 변환할 수 없는 경우에는 0를 return 합니다.
**/



import Foundation

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    /// words 안에 타겟 단어가 없으면 그대로 0 리턴
    guard words.contains(target) else { return 0 }

    /// 이미 탐색한 단어를 체크할 explored
    var explored: [Bool] = Array(repeating: false, count: words.count)
    /// 탐색한 경로를 저장할 path
    var path: [String] = []

    /// 깊이 우선 탐색을 사용한다.
    func dfs(_ start: String) {
        /// 해당 단어에서 알파벳 하나만 바꾸고 가져올 수 있는 단어들
        let founds: [String] = search(start, at: words)

        /// 만약 단어들 안에 타겟 단어가 있다면 경로에 추가하고 리턴한다.
        if founds.contains(target) {
            path.append(target)
            return
        }

        /// 단어들을 for문으로 돌면서 체크한다.
        for word in founds {
            /// 만약 해당 단어가 words 안에 들어 있고, 아직 탐색하지 않은 단어라면
            guard let index = words.firstIndex(of: word), explored[index] == false  else { continue }

            /// 탐색 한 단어로 변경해주고
            /// 경로에 추가한다.
            explored[index] = true
            path.append(word)

            /// 그리고 다시 다음 단어로 탐색을 시작한다.
            dfs(word)

            /// 계속 반복하여 타겟을 찾은 경우에 리턴한다.
            if path.contains(target) {
                return
            }

            /// 타겟 단어를 찾지 못하였으므로
            /// 경로에서 마지막 단어를 지우고
            /// 탐색하지 않은것으로 변경해준다.
            /// 그리고 다음 단어를 체크한다.
            path.removeLast()
            explored[index] = false
        }
    }
    
    dfs(begin)
    
    return path.count
}


func search(_ start: String, at words: [String]) -> [String] {
    /// 단어들 사이에서 알파벳 하나만 바꿀 수 있는 단어를 찾는다.
    return words.filter { word -> Bool in
        /// 해당 단어의 각 인덱스 별로 비교한다.
        /// 알파벳들이 일치하는 갯수를 가져온다.
        let count: Int = word.enumerated().filter { (i, v) -> Bool in
            return v == start[i]
        }.count

        /// 알파벳 한 개 차이 여부 체크.
        return count + 1 == start.count 
    }
}

extension String {
    subscript(index: Int) -> Character {
        return self[String.Index(encodedOffset: index)]
    }
}
