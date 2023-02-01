/*

문제 설명

정수 n, left, right가 주어집니다. 다음 과정을 거쳐서 1차원 배열을 만들고자 합니다.
n행 n열 크기의 비어있는 2차원 배열을 만듭니다.
i = 1, 2, 3, ..., n에 대해서, 다음 과정을 반복합니다.
1행 1열부터 i행 i열까지의 영역 내의 모든 빈 칸을 숫자 i로 채웁니다.
1행, 2행, ..., n행을 잘라내어 모두 이어붙인 새로운 1차원 배열을 만듭니다.
새로운 1차원 배열을 arr이라 할 때, arr[left], arr[left+1], ..., arr[right]만 남기고 나머지는 지웁니다.
정수 n, left, right가 매개변수로 주어집니다. 주어진 과정대로 만들어진 1차원 배열을 return 하도록 solution 함수를 완성해주세요.

제한사항

1 ≤ n ≤ 107
0 ≤ left ≤ right < n2
right - left < 105

*/

import Foundation

/// (1, 1) - 1 / (1, 2) - 2 / (1, 3) - 3
/// (2, 1) - 2 / (2, 2) - 2 / (2, 3) - 3
/// (3, 1) - 3 / (3, 2) - 3 / (3, 3) - 3 
/// 위와 같이 x, y 좌표중 큰 값이 배열의 값으로 들어간다.
/// 그러므로 left-right 범위를 좌표로 치환후에 비교하여 배열에 넣어주면 된다.
func solution(_ n:Int, _ left:Int64, _ right:Int64) -> [Int] {
    var result: [Int] = []
    
    for i in left...right {
        let row = Int(i + 1)
        /// 범위 / 행의 갯수 = y 좌표
        var y = row / n
        /// 범위 % 행의 갯수 = x 좌표
        var x = row % n
        
        /// x값이 0을 넘겼다면 y 좌표가 한 줄 더 내려간것이므로 1을 더해준다. 
        y = x > 0 ? y + 1 : y
        /// x값이 0이라면 x좌표의 끝이기 때문에 행의 최대값을 넣어준다.
        x = x > 0 ? x : n
        
        /// x, y 비교후에 배열에 추가.
        let value = x > y ? x : y
        result.append(value)
    }
    
    return result
}
