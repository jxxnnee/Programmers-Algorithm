/*
문제 설명

지도개발팀에서 근무하는 제이지는 지도에서 도시 이름을 검색하면 해당 도시와 관련된 맛집 게시물들을 데이터베이스에서 읽어 보여주는 서비스를 개발하고 있다.
이 프로그램의 테스팅 업무를 담당하고 있는 어피치는 서비스를 오픈하기 전 각 로직에 대한 성능 측정을 수행하였는데, 
제이지가 작성한 부분 중 데이터베이스에서 게시물을 가져오는 부분의 실행시간이 너무 오래 걸린다는 것을 알게 되었다.
어피치는 제이지에게 해당 로직을 개선하라고 닦달하기 시작하였고, 
제이지는 DB 캐시를 적용하여 성능 개선을 시도하고 있지만 캐시 크기를 얼마로 해야 효율적인지 몰라 난감한 상황이다.

어피치에게 시달리는 제이지를 도와, DB 캐시를 적용할 때 캐시 크기에 따른 실행시간 측정 프로그램을 작성하시오.
*/

import Foundation

func solution(_ cacheSize:Int, _ cities:[String]) -> Int {
    var cache: [String] = []
    var result: Int = 0
    
    for city in cities {
        /// 도시의 이름을 대소문자 구별하지 않기 위해
        /// 모두 대문자로 일괄 변경시킨다.
        let item = city.uppercased()
        if cache.contains(item) {
            /// cache hit가 발생했기 때문에
            /// result에 1을 더한다.
            result = result + 1
            
            /// LRU 알고리즘을 적용하기 위해
            /// 방금 참조한 아이템을 가장 뒤로 넘긴다.
            /// 가장 마지막에 참조한 아이템이 배열의 마지막으로 이동하는 구조.
            if let index = cache.firstIndex(of: item) {
                let element = cache.remove(at: index)
                cache.append(element)
            }
        } else {
            result = result + 5
            cache.append(item)
            
            /// 아이템을 추가 했을 때 사이즈를 초과하면
            /// 캐시 메모리에서 가장 오래 참조하지 않은 아이템을 삭제한다.
            /// 가장 오래 참조하지 않은 아이템은 배열의 가장 앞에 존재한다.
            if cache.count > cacheSize {
                cache.remove(at: 0)
            }
        } 
    }
    
    return result
}
