/*
문제 설명
점 네 개의 좌표를 담은 이차원 배열  dots가 다음과 같이 매개변수로 주어집니다.

[[x1, y1], [x2, y2], [x3, y3], [x4, y4]]
주어진 네 개의 점을 두 개씩 이었을 때, 두 직선이 평행이 되는 경우가 있으면 1을 없으면 0을 return 하도록 solution 함수를 완성해보세요.

제한 사항
- dots의 길이 = 4
- dots의 원소는 [x, y] 형태이며 x, y는 정수입니다.
- 0 ≤ x, y ≤ 100
- 서로 다른 두개 이상의 점이 겹치는 경우는 없습니다.
- 두 직선이 겹치는 경우(일치하는 경우)에도 1을 return 해주세요.
- 임의의 두 점을 이은 직선이 x축 또는 y축과 평행한 경우는 주어지지 않습니다.
*/



import Foundation


func solution(_ dots:[[Int]]) -> Int {
  /// 우선 [a, b, c, d] 네 개의 점을 두 개씩 이었을 때 나오는 경우의 수는
  /// [a-b, c-d] [a-c, b-d] [a-d, b-c] 이렇게 세 개가 나온다.
  /// 그리고 평행을 이룬다는 것은 기울기가 같다는 얘기다.
  /// 그래서 각각 기울기를 구해 같은 숫자가 나오면 1을 리턴하면 된다.
    if (slope(dots[0], dots[1]) == slope(dots[2], dots[3])) {
        return 1
    }
    
    if (slope(dots[0], dots[2]) == slope(dots[1], dots[3])) {
        return 1
    }
    
    if (slope(dots[0], dots[3]) == slope(dots[1], dots[2])) {
        return 1
    }
    
    return 0
}

/// 기울기를 구하는 함수
/// 기울기 = (y의 증가량) / (x의 증가량)
/// 소수가 나오는 경우도 있으니 Double로 변환하여 계산한다.
func slope(_ a: [Int], _ b: [Int]) -> Double {
    let x = a.map { Double($0) }
    let y = b.map { Double($0) }
    
    return (y[1] - x[1]) / (y[0] - x[0])
}
