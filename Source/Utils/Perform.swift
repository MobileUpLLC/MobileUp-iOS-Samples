import Foundation

struct Perform {
    @discardableResult
    init(
        operation: @escaping () async throws -> Void,
        onError: Closure.Generic<ServerError>? = nil
    ) {
        Task {
            do {
                try await operation()
            } catch let error {
                Log.perform.error(logEntry: .text(error.localizedDescription))
                
                onMain {
                    let error = error as? ServerError ?? .unknown(details: ErrorDetails(error: error))
                    onError?(error)
                }
            }
        }
    }
}
