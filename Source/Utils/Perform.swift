import Foundation

struct Perform {
    @discardableResult
    init(
        operation: @escaping () async throws -> Void,
        onError: Closure.Generic<Error>? = nil
    ) {
        Task {
            do {
                try await operation()
            } catch let error {
                Log.perform.error(logEntry: .text(error.localizedDescription))
                
                onMain {
                    onError?(error)
                }
            }
        }
    }
}
