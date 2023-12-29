/*
문제 설명
네트워크란 컴퓨터 상호 간에 정보를 교환할 수 있도록 연결된 형태를 의미합니다. 예를 들어, 컴퓨터 A와 컴퓨터 B가 직접적으로 연결되어있고, 
컴퓨터 B와 컴퓨터 C가 직접적으로 연결되어 있을 때 컴퓨터 A와 컴퓨터 C도 간접적으로 연결되어 정보를 교환할 수 있습니다. 따라서 컴퓨터 A, B, C는 모두 같은 네트워크 상에 있다고 할 수 있습니다.

컴퓨터의 개수 n, 연결에 대한 정보가 담긴 2차원 배열 computers가 매개변수로 주어질 때, 네트워크의 개수를 return 하도록 solution 함수를 작성하시오.

제한사항
- 컴퓨터의 개수 n은 1 이상 200 이하인 자연수입니다.
- 각 컴퓨터는 0부터 n-1인 정수로 표현합니다.
- i번 컴퓨터와 j번 컴퓨터가 연결되어 있으면 computers[i][j]를 1로 표현합니다.
- computer[i][i]는 항상 1입니다.
*/


import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    let n = computers.count
  /// explored -> 이미 탐색한 구역
    var explored: [Bool] = Array(repeating: false, count: n)
  /// count -> 몇 개의 네트워크가 있는지
    var count: Int = 0
    
    func bfs(start: Int) {
      /// need -> 들려야 할 구역
        var need: [Int] = [start]

      /// 들려야 할 곳이 모두 없으면 종료.
        while need.isEmpty == false {
          /// queue를 사용하기 때문에 가장 앞의 element를 가져온다.
            var index = need.removeFirst()
            let computer = computers[index]
            
            for (r, v) in computer.enumerated() {
              /// computer[i][i]는 항상 1이기 때문에 자기 자신은 탐색 할 필요가 없다.
                if r == index { continue }
              /// 값이 1 이고, 아직 탐색하지 않은 구역이라면
              /// 해당 구역을 다음에 들려야 할 구역에 넣어준다.
                if v == 1, explored[r] == false {
                    explored[r] = true
                    need.append(r)
                }
            }
        }

      /// bfs가 종료되었다면 1개의 네트워크가 있는 셈이므로
      /// count를 하나 증가 시켜준다.
        count = count + 1
    }
    
     for (r, _) in computers.enumerated() {
       /// bfs를 돌며 들렸던 구역이면 패스한다.
        guard explored[r] == false else { continue }

       /// bfs로 아직 들리지 않은 구역이라면
       /// r을 parameter로 넘겨 bfs를 시작한다.
        explored[r] = true
        bfs(start: r)
    }
    
    return count
}
