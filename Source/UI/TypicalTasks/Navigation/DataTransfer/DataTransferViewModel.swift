import Foundation

final class DataTransferViewModel: ObservableObject {
    @Published var textToSend: String = ""
    
    private var onTextSubmit: Closure.String?
    private let coordinator: DataTransferCoordinator
    private let navigationRepository: NavigationRepository
    
    init(
        coordinator: DataTransferCoordinator,
        navigationRepository: NavigationRepository,
        onTextSubmit: Closure.String?
    ) {
        self.coordinator = coordinator
        self.navigationRepository = navigationRepository
        self.onTextSubmit = onTextSubmit
    }
    
    func onSubmitTextButtonTapped() {
        if let onTextSubmit {
            onTextSubmit(textToSend)
        } else {
            navigationRepository.sendTextSubmitEvent(text: textToSend)
        }
    }
    
    func onPushControllerButtonTapped() {
        coordinator.showDataTransferModule()
    }
    
    func onPopToNavigationControllerButtonTapped() {
        coordinator.popToNavigationController()
    }
}

extension String: Eventable {
    static let eventId = UUID()
}
