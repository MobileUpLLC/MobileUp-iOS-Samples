import Foundation

final class DataTransferViewModel: ObservableObject {
    @Published var textToSend: String = ""
    
    private var onTextSubmit: (String) -> Void
    private let coordinator: DataTransferCoordinator
    private let navigationRepository: NavigationRepository
    
    init(
        coordinator: DataTransferCoordinator,
        navigationRepository: NavigationRepository,
        onTextSubmit: @escaping (String) -> Void
    ) {
        self.coordinator = coordinator
        self.navigationRepository = navigationRepository
        self.onTextSubmit = onTextSubmit
    }
    
    func onSubmitTextButtonTapped() {
//        onTextSubmit(textToSend)
        navigationRepository.sendTextSubmitEvent(text: textToSend)
    }
}

extension String: Eventable {
    static let eventId = UUID()
}
