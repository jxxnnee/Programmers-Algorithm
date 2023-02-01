/*

*/

import Foundation

func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var pTemp = progresses
    var sTemp = speeds
    var result: [Int] = []
    
    repeat {
        /// 작업을 진행한다.
        pTemp = doWork(pTemp, sTemp)
        /// 완료 된 작업은 제거한다.
        let notDone = isDone(pTemp)
      
        /// 기존 작업 갯수와 제거 된 작업의 갯수를 비교한다.
        /// 0개 이상이면 결과에 추가한다.
        let distribute = pTemp.count - notDone.count
        if distribute > 0 {
            result.append(distribute)
        }
        /// 완료 된 작업을 제거한 리스트를 다시 담아준다.
        pTemp = notDone
        /// 작업이 제거 된 만큼 속도 리스트도 제거한다.
        sTemp = deleteSpeed(sTemp, count: distribute)
      /// 작업 갯수가 0이 아닐때 까지 루프한다.
    } while isComplete(pTemp)
   
    return result
}

func isComplete(_ progresses: [Int]) -> Bool {
    return progresses.count != 0
}
func doWork(_ progresses: [Int], _ speeds: [Int]) -> [Int] {
    var result: [Int] = []
    progresses.indices.forEach {
        /// 기존 작업 진도에 속도를 더해준다.
        let value = progresses[$0] + speeds[$0]
        result.append(value)
    }
    
    return result
}
func isDone(_ progresses: [Int]) -> [Int] {
    var temp = progresses
    /// 맨 앞의 값이 완료되었다면 진행한다.
    guard temp[0] > 99 else {
        return temp
    }
    for value in temp {
        /// 완료 되지 않은 값이 나온 순간 리턴하고 종료한다.
        guard value > 99 else { return temp }
        
        /// 완료 된 작업은 제거한다.
        temp.removeFirst()
    }
    
    return temp
}
func deleteSpeed(_ speeds: [Int], count: Int) -> [Int] {
    var temp = speeds
    for _ in 0 ..< count {
        temp.removeFirst()
    }
    
    return temp
}
