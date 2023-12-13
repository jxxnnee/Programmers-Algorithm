/*
이중 우선순위 큐는 다음 연산을 할 수 있는 자료구조를 말합니다.

명령어 / 수신 탑(높이)
I 숫자 / 큐에 주어진 숫자를 삽입합니다.
D 1 / 큐에서 최댓값을 삭제합니다.
D -1 / 큐에서 최솟값을 삭제합니다.

이중 우선순위 큐가 할 연산 operations가 매개변수로 주어질 때, 모든 연산을 처리한 후 큐가 비어있으면 [0,0] 비어있지 않으면 [최댓값, 최솟값]을 return 하도록 solution 함수를 구현해주세요.


제한사항
- operations는 길이가 1 이상 1,000,000 이하인 문자열 배열입니다.
- operations의 원소는 큐가 수행할 연산을 나타냅니다.
  - 원소는 “명령어 데이터” 형식으로 주어집니다.- 최댓값/최솟값을 삭제하는 연산에서 최댓값/최솟값이 둘 이상인 경우, 하나만 삭제합니다.
- 빈 큐에 데이터를 삭제하라는 연산이 주어질 경우, 해당 연산은 무시합니다.
*/


import Foundation

/// 명령어를 enum 형식으로 만들어 둔다.
enum Operation {
    case insert
    case max
    case min
}

func solution(_ operations:[String]) -> [Int] {
    var result: [Int] = []
    var temp: [Int] = []
    
    for operation in operations {
        let action = check(operation)
        let value = extract(operation)
        
        switch action {
            case .insert:
            /// 해당 값을 추가한다.
            temp.append(value)
            case .max:
            /// 최댓값이 있으면 해당 최댓값을 삭제한다.
            if let max = temp.max(), let index = temp.firstIndex(of: max) {
                temp.remove(at: index)
            }
            case .min:
            /// 최솟값이 있으면 해당 최솟값을 삭제한다.
            if let min = temp.min(), let index = temp.firstIndex(of: min) {
                temp.remove(at: index)
            }
        }
    }

    /// 결과 값 앞에 최댓 값을 넣어주고
    if let max = temp.max() {
        result.append(max)
    }
    /// 결과 값 위에 최솟 값을 넣어준다.
    if let min = temp.min() {
        result.append(min)
    }

    /// 결과 값의 갯수가 1개 이하이면 [0, 0] 을 리턴하고, 아니면 결과 값을 리턴한다.
    return result.count < 1 ? [0, 0] : result
}

/// 어떤 명령인지 치환 해주는 함수
/// "I 124" -> .insert
/// "D 1" -> .max
/// "D -1" -> .min
func check(_ operation: String) -> Operation {
    /// "I 124" -> ["I", "124"]
    let arr: [String] = operation.split(separator: " ").map { String($0) }
    
    switch arr[0] {
        case "I":
        return .insert
        default:
        return arr[1] == "1" ? .max : .min
    }
}

/// 명령에 들어 온 값으로 치환해주는 함수
/// "I 124" -> 124
func extract(_ operation: String) -> Int {
    let arr: [String] = operation.split(separator: " ").map { String($0) }
    
    return Int(arr[1]) ?? 0
}
