import Foundation

struct PerformAsync {
    @discardableResult
    init(
        operation: @escaping () async throws -> Void,
        onError: Closure.Generic<Error>? = nil
    ) async {
        await Task {
            do {
                try await operation()
            } catch let error {
                Log.performAsync.error(logEntry: .text(error.localizedDescription))
                
                onMain {
                    onError?(error)
                }
            }
        }.value
    }
}
