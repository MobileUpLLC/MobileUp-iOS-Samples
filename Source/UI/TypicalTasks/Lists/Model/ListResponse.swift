struct ListResponse {
    let id: Int
}

extension ListResponse: Comparable {
    static func < (lhs: ListResponse, rhs: ListResponse) -> Bool {
        return lhs.id < rhs.id
    }
}
