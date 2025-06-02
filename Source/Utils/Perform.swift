import Foundation
import Moya

struct Perform {
    @discardableResult
    init(
        operation: @escaping () async throws -> Void,
        onError: Closure.Generic<MoyaError>? = nil
    ) {
        _Concurrency.Task {
            do {
                try await operation()
            } catch let error {
                Log.perform.error(logEntry: .text(error.localizedDescription))
                
                onMain {
                    let error = error as? MoyaError ?? .underlying(error, nil)
                    onError?(error)
                }
            }
        }
    }
}
