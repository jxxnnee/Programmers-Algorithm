/*
운영체제의 역할 중 하나는 컴퓨터 시스템의 자원을 효율적으로 관리하는 것입니다. 이 문제에서는 운영체제가 다음 규칙에 따라 프로세스를 관리할 경우 특정 프로세스가 몇 번째로 실행되는지 알아내면 됩니다.

    1. 실행 대기 큐(Queue)에서 대기중인 프로세스 하나를 꺼냅니다.
    2. 큐에 대기중인 프로세스 중 우선순위가 더 높은 프로세스가 있다면 방금 꺼낸 프로세스를 다시 큐에 넣습니다.
    3. 만약 그런 프로세스가 없다면 방금 꺼낸 프로세스를 실행합니다.
      3.1 한 번 실행한 프로세스는 다시 큐에 넣지 않고 그대로 종료됩니다.

예를 들어 프로세스 4개 [A, B, C, D]가 순서대로 실행 대기 큐에 들어있고, 우선순위가 [2, 1, 3, 2]라면 [C, D, A, B] 순으로 실행하게 됩니다.
현재 실행 대기 큐(Queue)에 있는 프로세스의 중요도가 순서대로 담긴 배열 priorities와, 몇 번째로 실행되는지 알고싶은 프로세스의 위치를 알려주는 location이 매개변수로 주어질 때, 
해당 프로세스가 몇 번째로 실행되는지 return 하도록 solution 함수를 작성해주세요.

*/


import Foundation

func solution(_ priorities:[Int], _ location:Int) -> Int {
    return check(priorities, location, 0)
}

func check(_ priorities:[Int], _ location:Int, _ result: Int) -> Int {
    var temp = priorities
    var current = location
    let removed = temp.removeFirst()
    
    /// 우선 순위가 존재하지 않고
    if priorities.filter({ $0 > removed }).first == nil {
        if current == 0 {
            /// 현재 위치가 0이면, 몇 번째 실행인지 리턴하면 된다.
            return result + 1
        } else {
            /// 현재 위치가 0이 아니라면, 실행 횟수 +1 / 현재 위치 -1 을 하고
            /// 함수를 재 호출해서 다시 체크 한다.
            return check(temp, current - 1, result + 1)
        }
    }
    /// 우선 순위가 존재 하고
    else {
        /// 현재 위치가 0이면, 맨 뒤로 위치를 옮기고
        /// 현재 위치가 0이 아니라면, 한 자리 앞으로 옮기고
        /// 함수를 재 호출한다.
        temp.append(removed)
        current = current == 0 ? (temp.count - 1) : (current - 1)
        return check(temp, current, result)
    }
}
