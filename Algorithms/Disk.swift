/*
하드디스크는 한 번에 하나의 작업만 수행할 수 있습니다. 디스크 컨트롤러를 구현하는 방법은 여러 가지가 있습니다. 가장 일반적인 방법은 요청이 들어온 순서대로 처리하는 것입니다.

예를들어
- 0ms 시점에 3ms가 소요되는 A작업 요청
- 1ms 시점에 9ms가 소요되는 B작업 요청
- 2ms 시점에 6ms가 소요되는 C작업 요청

와 같은 요청이 들어왔습니다. 
한 번에 하나의 요청만을 수행할 수 있기 때문에 각각의 작업을 요청받은 순서대로 처리하면 다음과 같이 처리 됩니다.

- A: 3ms 시점에 작업 완료 (요청에서 종료까지 : 3ms)
- B: 1ms부터 대기하다가, 3ms 시점에 작업을 시작해서 12ms 시점에 작업 완료(요청에서 종료까지 : 11ms)
- C: 2ms부터 대기하다가, 12ms 시점에 작업을 시작해서 18ms 시점에 작업 완료(요청에서 종료까지 : 16ms)

이 때 각 작업의 요청부터 종료까지 걸린 시간의 평균은 10ms(= (3 + 11 + 16) / 3)가 됩니다.
하지만 A → C → B 순서대로 처리하면

- A: 3ms 시점에 작업 완료(요청에서 종료까지 : 3ms)
- C: 2ms부터 대기하다가, 3ms 시점에 작업을 시작해서 9ms 시점에 작업 완료(요청에서 종료까지 : 7ms)
- B: 1ms부터 대기하다가, 9ms 시점에 작업을 시작해서 18ms 시점에 작업 완료(요청에서 종료까지 : 17ms)

이렇게 A → C → B의 순서로 처리하면 각 작업의 요청부터 종료까지 걸린 시간의 평균은 9ms(= (3 + 7 + 17) / 3)가 됩니다.

각 작업에 대해 [작업이 요청되는 시점, 작업의 소요시간]을 담은 2차원 배열 jobs가 매개변수로 주어질 때, 
작업의 요청부터 종료까지 걸린 시간의 평균을 가장 줄이는 방법으로 처리하면 평균이 얼마가 되는지 return 하도록 solution 함수를 작성해주세요. (단, 소수점 이하의 수는 버립니다)

*/

import Foundation

func solution(_ jobs:[[Int]]) -> Int {
    /// 작업을 요청 시점 및 소요 시간을 기준으로 정렬한다.
    var wait: [[Int]] = jobs.sorted(by: { ($0[0], $0[1]) < ($1[0], $1[1]) })
    var result: Int = 0
    var current: Int = 0
    
    /// 대기중인 작업이 없을때까지 진행한다.
    while wait.isEmpty == false {
        /// 현재 시점 이전에 들어온 요청이 있으면
        /// 소요 시간을 기준으로 다시 정렬한다.
        let possibles = wait.filter ({ $0[0] <= current })
                            .sorted (by: { $0[1] < $1[1] })
        
        /// 현재 시점에 가능한 작업이 있다면
        if possibles.count > 0 {
            let possible = possibles[0]
            
            /// 해당 작업을 대기열에서 지운다.
            if let index = wait.firstIndex(of: possible) {
                wait.remove(at: index)
            }
            
            /// 현재 시점과 결과 값을 갱신해준다.
            /// (현재시점+소요시간) 
            current = current + possible[1]
            /// (현재시점-요청시점)
            result = result + (current - possible[0])
        } else {
            /// 현재 시점에 가능한 작업이 없다면
            /// 대기열의 가장 앞에 있는 작업을 가져온다.
            let possible = wait[0]
            
            /// 해당 작업을 대기열에서 지운다.
            if let index = wait.firstIndex(of: possible) {
                wait.remove(at: index)
            }
            
            /// 현재 시점과 결과 값을 갱신해준다.
            /// (요청시점+소요시간)
            current = possible[0] + possible[1]
            /// (소요시간)
            result = result + possible[1]
        }
    }
    
    return result / jobs.count
}
