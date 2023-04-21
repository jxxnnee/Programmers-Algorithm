/**
  문제 설명  
  2차원 행렬 arr1과 arr2를 입력받아, arr1에 arr2를 곱한 결과를 반환하는 함수, solution을 완성해주세요.

  제한 조건
  - 행렬 arr1, arr2의 행과 열의 길이는 2 이상 100 이하입니다.
  - 행렬 arr1, arr2의 원소는 -10 이상 20 이하인 자연수입니다.
  - 곱할 수 있는 배열만 주어집니다.
*/

import Foundation

/** 
  행 - Vertical
  열 - Horizontal
*/

func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    /// 1. arr1 행렬을 순차적으로 가져온다.
    return arr1.enumerated().map { index, rows in
        /// 2. arr2 행렬 행의 인덱스를 순차적으로 가져온다.
        /// 첫번째 열의 길이로 0부터 순회하여 인덱스로 사용하는것.
        return arr2[0].indices.map { row -> Int in
            /// 3. arr1 행렬의 값과 arr2 행렬의 값을 순차적으로 곱한다.
            /// $1 = arr1 행렬 행의 값
            /// $0 = arr2 행렬 열의 인덱스
            return rows.enumerated()
                .map { $1 * arr2[$0][row] }
                /// 4. 곱한 값들을 모두 더해준다.
                .reduce(0) { $0 + $1 }
        }
    }
}
