/*
문제 설명
지뢰가 있는 지역과 지뢰에 인접한 위, 아래, 좌, 우 대각선 칸을 모두 위험지역으로 분류합니다.
지뢰는 2차원 배열 board에 1로 표시되어 있고 board에는 지뢰가 매설 된 지역 1과, 지뢰가 없는 지역 0만 존재합니다.
지뢰가 매설된 지역의 지도 board가 매개변수로 주어질 때, 안전한 지역의 칸 수를 return하도록 solution 함수를 완성해주세요.

제한사항
- board는 n * n 배열입니다.
  1 ≤ n ≤ 100
- 지뢰는 1로 표시되어 있습니다.
- board에는 지뢰가 있는 지역 1과 지뢰가 없는 지역 0만 존재합니다.
*/

import Foundation

func solution(_ board:[[Int]]) -> Int {
    var temp = board
    /// 배열의 갯수 n
    let count = board.count
    /// 지뢰가 인접한 위험지역들
    let soil = [(-1, -1),  (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    
    for r in 0 ..< count {
        for c in 0 ..< count {
            /// 해당 위치에 지뢰가 있으면
            guard temp[r][c] == 1 else { continue }

            /// 인접한 위험지역들을 순회한다.
            for (sr, sc) in soil {
                /// 위험지역이 배열로 불러올 수 있는 구간이고
                if 0 <= (r+sr) && (r+sr) < count && 0 <= (c+sc) && (c+sc) < count {
                    /// 해당 지역에 숫자가 0일때
                    /// 위험 지역을 나타내는 숫자 3으로 변경해준다.
                    guard temp[r+sr][c+sc] == 0 else { continue }
                    temp[r+sr][c+sc] = 3
                }
            }
        }
    }

    /// 2차원 배열을 1차원으로 낮추고
    /// 안전지역의 갯수를 확인해 리턴한다.
    return temp.flatMap({ $0 }).filter({ $0 == 0 }).count
}
