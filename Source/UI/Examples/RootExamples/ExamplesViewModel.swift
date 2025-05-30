import SwiftUI
import AVFoundation

final class ExamplesViewModel: ObservableObject {
    private enum Constants {
        static let webPageLink = "https://mobileup.ru/"
        static let redirectLink = "https://mobileup.ru/contacts"
        static let viewName = "ExamplesView"
    }
    
    var examples: [ExamplesViewItem] = []
    
    private let coordinator: ExamplesCoordinator
    
    init(coordinator: ExamplesCoordinator) {
        self.coordinator = coordinator
        
        examples = getExamples()
    }
    
    func onItemTap(item: ExamplesViewItem) {
        item.action()
    }
    
    private func showWebPageModule() {
        AnalyticsService.shared.report(
            event: .webviewCellTap,
            params: [.testParam: Constants.viewName]
        )
        
        guard let redirectUrl = URL(string: Constants.redirectLink) else {
            return
        }
        
        let pageModel = WebPageModel(
            url: URL(string: Constants.webPageLink),
            navigationTitle: R.string.examples.examplesWebPageNavigationTitle(),
            redirectUrls: [redirectUrl],
            redirectAction: { print($0.absoluteString) }
        )
        
        coordinator.showWebPageModule(pageModel: pageModel)
    }
    
    private func showSkeletonModule() {
        coordinator.showSkeletonModule()
    }
    
    private func showBottomSheetExample() {
        coordinator.showBottomSheetExample()
    }
    
    private func showMultipleBottomSheetExample() {
        coordinator.showMultipleBottomSheetExample()
    }
    
    private func showErrorHandlingModule() {
        coordinator.showErrorHandlingModule()
    }
    
    private func showStorageModule() {
        coordinator.showStorageModule()
    }
    
    private func showToastExample() {
        coordinator.showToastExampleModule()
    }
    
    private func showNetworkExample() {
        coordinator.showNetworkExampleModule()
    }
    
    private func getExamples() -> [ExamplesViewItem] {
        return [
            .init(title: R.string.examples.examplesWebPage()) { [weak self] in
                self?.showWebPageModule()
            },
            .init(title: R.string.examples.examplesSkeleton()) { [weak self] in
                self?.showSkeletonModule()
            },
            .init(title: R.string.examples.examplesBottomSheet()) { [weak self] in
                self?.showBottomSheetExample()
            },
            .init(title: R.string.examples.examplesMultipleBottomSheet()) { [weak self] in
                self?.showMultipleBottomSheetExample()
            },
            .init(title: R.string.examples.examplesErrorHandling()) { [weak self] in
                self?.showErrorHandlingModule()
            },
            .init(title: R.string.examples.examplesStorage()) { [weak self] in
                self?.showStorageModule()
            },
            .init(title: R.string.examples.examplesToast()) { [weak self] in
                self?.showToastExample()
            },
            .init(title: R.string.examples.examplesNetwork()) { [weak self] in
                self?.showNetworkExample()
            }
        ]
    }
}
