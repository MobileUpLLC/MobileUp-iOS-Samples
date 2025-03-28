import Foundation

struct WebPageModel {
    let url: URL?
    let navigationTitle: String
    let redirectUrls: [URL]
    let redirectAction: Closure.Generic<URL>?
    let errorAction: Closure.Generic<Error>?
    
    init(
        url: URL?,
        navigationTitle: String,
        redirectUrls: [URL] = [],
        redirectAction: Closure.Generic<URL>? = nil,
        errorAction: Closure.Generic<Error>? = nil
    ) {
        self.url = url
        self.navigationTitle = navigationTitle
        self.redirectUrls = redirectUrls
        self.redirectAction = redirectAction
        self.errorAction = errorAction
    }
}

class WebPageViewModel: ViewModel {
    let url: URL?
    let redirectUrls: [URL]
    let navigationTitle: String
    
    private(set) var redirectAction: Closure.Generic<URL>?
    private(set) var errorAction: Closure.Generic<Error>?
    
    private let coordinator: WebPageCoordinator
    
    init(coordinator: WebPageCoordinator, pageModel: WebPageModel) {
        self.coordinator = coordinator
        self.url = pageModel.url
        self.redirectUrls = pageModel.redirectUrls
        self.navigationTitle = pageModel.navigationTitle
        
        super.init()
        
        self.redirectAction = { [weak self] result in
            self?.dismiss()
            pageModel.redirectAction?(result)
        }
        
        self.errorAction = { [weak self] result in
            self?.dismiss()
            pageModel.errorAction?(result)
        }
    }
    
    func dismiss() {
        coordinator.close()
    }
}
