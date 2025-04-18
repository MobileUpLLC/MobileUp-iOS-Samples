import Foundation

final class ListRepository {
    func requestDataFromBackend(
        sort: ListSortType = .default,
        filter: ListFilterType = .default
    ) async throws -> [ListResponse] {
        var response: [ListResponse] = []
        
        try? await Task.sleep(for: .seconds(1))
        
        let isError = Int.random(in: 1...100) <= 10
        
        if isError {
            throw ListServerError.unknown
        }
        
        for i in 0..<Int.random(in: 0..<1_000) {
            response.append(.init(id: i))
        }
        
        switch filter {
        case .odd:
            response = response.filter { $0.id.isMultiple(of: 2) == false }
        case .even:
            response = response.filter { $0.id.isMultiple(of: 2) }
        case .default:
            break
        }
        
        switch sort {
        case .ascending:
            response.sort { $0 < $1 }
        case .descending:
            response.sort { $0 > $1 }
        case .default:
            break
        }
        
        return response
    }
    
    func requestPaginationDataFromBackend(
        sort: ListSortType = .default,
        filter: ListFilterType = .default,
        page: Int,
        perPage: Int
    ) async throws -> ListPagingResponse {
        var response: [ListResponse] = []
        
        try? await Task.sleep(for: .seconds(1))
        
        let isError = Int.random(in: 1...100) <= 10
        
        if isError {
            throw ListServerError.unknown
        }
        
        for i in 0..<100 {
            response.append(.init(id: i))
        }
        
        switch filter {
        case .odd:
            response = response.filter { $0.id.isMultiple(of: 2) == false }
        case .even:
            response = response.filter { $0.id.isMultiple(of: 2) }
        case .default:
            break
        }
        
        switch sort {
        case .ascending:
            response.sort { $0 < $1 }
        case .descending:
            response.sort { $0 > $1 }
        case .default:
            break
        }
        
        let total = response.count
        
        response.removeFirst((page - 1) * perPage)
        response.removeLast(total - page * perPage)
        
        return ListPagingResponse(data: response, total: total)
    }
}
