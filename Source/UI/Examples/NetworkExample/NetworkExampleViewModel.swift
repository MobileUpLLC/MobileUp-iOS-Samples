import Foundation

// NOTE: Для примера модель располагается здесь. В другом случае нужно поместить в папку Models.
struct ExampleModel: Codable {
    let genesisHash: String
}

final class NetworkExampleViewModel: ObservableObject {
    @Published var restultText: String = .empty
    
    private let coordinator: NetworkExampleCoordinator
    private let mobileService: MobileService

    private var task: Task<(), any Error>?
    
    init(coordinator: NetworkExampleCoordinator, mobileService: MobileService) {
        self.coordinator = coordinator
        self.mobileService = mobileService
    }
        
    func onRequestDataButtonTapped() {
        restultText = "in progress"
        
        task?.cancel()
        
        task = Task {
            do {
                let _: [ExampleModel] = try await self.mobileService.request(target: .example(.testItems))
                
                Log.refreshTokenFlow.debug(logEntry: .text("NetworkExampleViewModel. Data received successfully"))

                onMain { [weak self] in
                    self?.restultText = "success"
                }
            } catch {
                Log.refreshTokenFlow.debug(logEntry: .text("NetworkExampleViewModel. Data not received successfully"))

                onMain { [weak self] in
                    self?.restultText = "error \(error)"
                }
            }
        }
    }
    
    func onCancelRequestButtonTapped() {
        task?.cancel()
        
        Log.refreshTokenFlow.debug(logEntry: .text("NetworkExampleViewModel. Cancel task"))
    }
}
