import Foundation

final class DataTransferExampleViewModel: ObservableObject {
    @Published var textToSend: String = .empty
    
    private var onTextSubmit: Closure.String?
    private let coordinator: DataTransferExampleCoordinator
    private let navigationRepository: NavigationRepository
    
    init(
        coordinator: DataTransferExampleCoordinator,
        navigationRepository: NavigationRepository,
        onTextSubmit: Closure.String?
    ) {
        self.coordinator = coordinator
        self.navigationRepository = navigationRepository
        self.onTextSubmit = onTextSubmit
    }
    
    func handleTapOnSubmitTextButton() {
        if let onTextSubmit {
            onTextSubmit(textToSend)
        } else {
            navigationRepository.sendTextSubmitEvent(text: textToSend)
        }
        
        textToSend = .empty
    }
    
    func handleTapOnPushControllerButton() {
        coordinator.showDataTransferExampleModule()
    }
    
    func handleTapOnPopToNavigationControllerButton() {
        coordinator.popToNavigationExampleController()
    }
}
