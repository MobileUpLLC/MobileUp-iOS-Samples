import Foundation

final class CommonOnboardingViewModel: ViewModel {
    @Published var viewItem: CommonOnboardingViewItem
    
    let finishButtonTitle: String
    let isNeedShowProgress: Bool
    var pagesCount: Int { viewItems.count }
    var isFirstPage: Bool { currentProgress == .zero }
    var isLastPage: Bool { currentProgress + .one == pagesCount }
    
    private(set) var currentProgress: Int = .zero
    private var viewItems: [CommonOnboardingViewItem] = []
    private let coordinator: OnboardingCoordinator
    
    init(coordinator: OnboardingCoordinator, onboardingType: CommonOnboardingType) {
        self.coordinator = coordinator
        viewItems = onboardingType.items
        finishButtonTitle = onboardingType.finishButtonTitle
        isNeedShowProgress = onboardingType.isNeedShowProgress
        viewItem = .empty
        
        super.init()
        
        updateViewItem()
    }
        
    func handleNextButtonTap() {
        if isLastPage {
            coordinator.dismiss()
        } else {
            currentProgress += .one
            updateViewItem()
        }
    }
    
    func handleBackButtonTap() {
        if isFirstPage == false {
            currentProgress -= .one
            updateViewItem()
        }
    }
    
    func handleCloseButtonTap() {
        coordinator.dismiss()
    }
    
    private func updateViewItem() {
        guard let newItem = viewItems[safe: currentProgress] else {
            return
        }
        
        viewItem = newItem
    }
}
