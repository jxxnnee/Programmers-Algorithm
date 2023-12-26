/*
문제 설명
신입사원 무지는 게시판 불량 이용자를 신고하고 처리 결과를 메일로 발송하는 시스템을 개발하려 합니다. 무지가 개발하려는 시스템은 다음과 같습니다.

- 각 유저는 한 번에 한 명의 유저를 신고할 수 있습니다.
    - 신고 횟수에 제한은 없습니다. 서로 다른 유저를 계속해서 신고할 수 있습니다.
    - 한 유저를 여러 번 신고할 수도 있지만, 동일한 유저에 대한 신고 횟수는 1회로 처리됩니다.
- k번 이상 신고된 유저는 게시판 이용이 정지되며, 해당 유저를 신고한 모든 유저에게 정지 사실을 메일로 발송합니다.
    - 유저가 신고한 모든 내용을 취합하여 마지막에 한꺼번에 게시판 이용 정지를 시키면서 정지 메일을 발송합니다.

이용자의 ID가 담긴 문자열 배열 id_list, 각 이용자가 신고한 이용자의 ID 정보가 담긴 문자열 배열 report, 정지 기준이 되는 신고 횟수 k가 매개변수로 주어질 때, 
각 유저별로 처리 결과 메일을 받은 횟수를 배열에 담아 return 하도록 solution 함수를 완성해주세요.

제한사항
- 2 ≤ id_list의 길이 ≤ 1,000
    - 1 ≤ id_list의 원소 길이 ≤ 10
    - id_list의 원소는 이용자의 id를 나타내는 문자열이며 알파벳 소문자로만 이루어져 있습니다.
    - id_list에는 같은 아이디가 중복해서 들어있지 않습니다.
- 1 ≤ report의 길이 ≤ 200,000
    - 3 ≤ report의 원소 길이 ≤ 21
    - report의 원소는 "이용자id 신고한id"형태의 문자열입니다.
    - 예를 들어 "muzi frodo"의 경우 "muzi"가 "frodo"를 신고했다는 의미입니다.
    - id는 알파벳 소문자로만 이루어져 있습니다.
    - 이용자id와 신고한id는 공백(스페이스)하나로 구분되어 있습니다.
    - 자기 자신을 신고하는 경우는 없습니다.
- 1 ≤ k ≤ 200, k는 자연수입니다.
    - return 하는 배열은 id_list에 담긴 id 순서대로 각 유저가 받은 결과 메일 수를 담으면 됩니다.
*/


import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    /// id_list의 갯수만큼 결과 값을 0으로 반복하여 채운다.
    var result: [Int] = Array(repeating: 0, count: id_list.count)
    var reportList: [String: [String]] = [:]
    /// report를 Set리스트로 치환하여 중복을 제거한다.
    /// ["ryan con", "ryan con", "ryan con", "ryan con"] -> ["ryan con"]
    let wrapReport: Set<String> = Set(report)
    
    /// 중복을 제거한 report 리스트를 순회하며
    /// 신고 받은 사람과 신고한 사람을 연결지어 준다.
    for rep in wrapReport {
        /// 우선 report의 문자열이 공백으로 구분되어 있기 때문에
        /// 공백으로 문자열을 분리하여 신고 받은 유저와 신고한 유저의 정보를 가져온다.
        let sep = rep.components(separatedBy: " ")
        let warned = sep[1]
        let reporter = sep[0]
        
        /// 신고 리스트에 신고 받은 유저에 대한 정보가 있다면
        /// 기존의 신고한 유저의 리스트에 새로운 유저를 추가하여 업데이트 하고
	      /// 기존에 신고 받은 유저에 대한 정보가 없다면
        /// 해당 유저에 대한 신고 유저 리스트를 추가한다.
	      reportList[warned] = (reportList[warned] ?? []) + [reporter]
    }
    
    /// 신고 리스트를 순회하며
    /// 신고 횟수를 넘긴 신고자에 한해서 체크한다.
    for (key, value) in reportList {
        guard value.count >= k else {
            continue
        }
        
        /// 신고한 유저의 리스트를 순회하며
        /// 해당 유저가 받을 메일의 갯수를 업데이트 해준다.
        for id in value {
            if let index = id_list.firstIndex(of: id) {
                result[index] += 1
            }
        }
    }
    
    return result
}
}
