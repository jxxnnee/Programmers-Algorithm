/*
문제 설명
선분 3개가 평행하게 놓여 있습니다. 세 선분의 시작과 끝 좌표가 [[start, end], [start, end], [start, end]] 형태로 들어있는 2차원 배열 lines가 매개변수로 주어질 때,
두 개 이상의 선분이 겹치는 부분의 길이를 return 하도록 solution 함수를 완성해보세요.

제한사항
- lines의 길이 = 3
- lines의 원소의 길이 = 2
- 모든 선분은 길이가 1 이상입니다.
- lines의 원소는 [a, b] 형태이며, a, b는 각각 선분의 양 끝점 입니다.
- -100 ≤ a < b ≤ 100
*/

import Foundation

func solution(_ lines:[[Int]]) -> Int {
    /// 좌표계가 -100 ~ 100까지 총 200개의 포인트를 가진다.
    /// 그러므로 200개의 포인트를 갖는 배열을 생성해준다.
    var coordinate: [Int] = Array(repeating: 0, count: 200)
  
    for line in lines {
        /// stride 함수를 활용해 해당 범위 안의 숫자들을 가져온다.
        /// ex) [1, 5] -> 1, 2, 3, 4, 5
        for index in stride(from: line[0], to: line[1], by: 1) {
            /// 좌표계는 -100부터 시작하지만 실제 배열은 0부터 시작하므로 +100
            let point = index+100
            coordinate[point] = coordinate[point] + 1
        }
    }

    /// 좌표계에 숫자가 2 이상이면 겹친것이므로 해당하는 갯수를 필터링해서 가져온다.
    return coordinate.filter { $0 > 1 }.count
}

