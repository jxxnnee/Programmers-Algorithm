/*
문제 설명

H-Index는 과학자의 생산성과 영향력을 나타내는 지표입니다. 어느 과학자의 H-Index를 나타내는 값인 h를 구하려고 합니다. 위키백과1에 따르면, H-Index는 다음과 같이 구합니다.
어떤 과학자가 발표한 논문 n편 중, h번 이상 인용된 논문이 h편 이상이고 나머지 논문이 h번 이하 인용되었다면 h의 최댓값이 이 과학자의 H-Index입니다.
어떤 과학자가 발표한 논문의 인용 횟수를 담은 배열 citations가 매개변수로 주어질 때, 이 과학자의 H-Index를 return 하도록 solution 함수를 작성해주세요.
*/

import Foundation

func solution(_ citations:[Int]) -> Int {
    var indexArr: [Int] = []
  
    /// 논문별 인용 횟수는 0회 이상 10,000회 이하이다.
    /// 하지만 굳이 10,000회까지 탐색해야 할 필요가 없으므로
    /// 해당 배열의 최대값까지만 탐색하도록 max 값을 구한다.
    /// max가 0 이라면 그냥 0을 return해도 된다.
    guard let max = citations.max(), max > 0 else {
        return 0
    }
    
    for i in 0...max {
        let count = citations.filter {
            /// h번 이상 인용된 논문을 필터링한다.
            $0 >= i
        }.count
        
        /// h번 이상 인용된 논문의 갯수가 h편 이상인지 체크한다.
        if count >= i {
            /// 맞다면 array에 추가한다.
            indexArr.append(i)
        }
    }
    
    /// indexArr의 최댓값을 구한다.
    guard let index = indexArr.max() else {
        return 0
    }
    
    return index
}
