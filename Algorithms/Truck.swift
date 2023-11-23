/*
트럭 여러 대가 강을 가로지르는 일차선 다리를 정해진 순으로 건너려 합니다. 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 알아내야 합니다. 
다리에는 트럭이 최대 bridge_length대 올라갈 수 있으며, 다리는 weight 이하까지의 무게를 견딜 수 있습니다. 단, 다리에 완전히 오르지 않은 트럭의 무게는 무시합니다.

solution 함수의 매개변수로 다리에 올라갈 수 있는 트럭 수 bridge_length, 다리가 견딜 수 있는 무게 weight, 트럭 별 무게 truck_weights가 주어집니다. 
이때 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 return 하도록 solution 함수를 완성하세요.
*/

import Foundation

func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var ing: [Int] = []
    var progress: [Int] = []
    var wait: [Int] = truck_weights
    var result: Int = 0
    
    /// 둘 중에 하나라도 비어있지 않으면 진행한다.
    while !ing.isEmpty || !wait.isEmpty {
        /// 현재 다리를 건너는 트럭이 있다면
        if progress.isEmpty == false {
            /// 한 번 시간이 경과 되었기 때문에
            /// 모든 진행 상황에서 -1을 해준다.
            progress = progress.map { $0 - 1 }
            
            /// 그리고 맨 처음 트럭이 다리를 지났다면
            /// 진행 상황, 현재 다리를 건너는 트럭 배열에서 제외 시켜준다.
            if progress[0] < 1 {
                ing.removeFirst()
                progress.removeFirst()
            }
        }
        
        /// 대기중인 트럭이 있다면
        if wait.isEmpty == false {
            let first = wait[0]
            let sum = ing.reduce(0) { $0 + $1 }
            
            /// 맨 앞의 트럭과 다리를 건너는 트럭의 무게를 모두 합해서
            /// 견딜 수 있는 무게인지 체크한다.
            if first + sum <= weight {
                /// 다리를 건널 수 있는 무게라면
                /// 진행 상황, 다리를 건너는 트럭 배열에 추가하고
                /// 대기 트럭 배열에서 제거한다.
                ing.append(first)
                progress.append(bridge_length)
                wait.removeFirst()
            }
        }
        
        /// 사이클이 한번 돌았으므로 +1
        result = result + 1
    }
    
    return result
}
