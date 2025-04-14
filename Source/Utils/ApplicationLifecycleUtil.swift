import UIKit

class ApplicationLifecycleUtil {
    static var isApplicationActive: Bool { UIApplication.shared.applicationState == .active }
    
    var onApplicationDidBecomeActive: Closure.Void? {
        didSet { handleApplicationDidBecomeActive() }
    }
    
    var onApplicationWillEnterForeground: Closure.Void? {
        didSet { handleApplicationWillEnterForeground() }
    }
    
    var onApplicationWillResignActive: Closure.Void? {
        didSet { handleApplicationWillResignActive() }
    }
    
    private func handleApplicationDidBecomeActive() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    private func handleApplicationWillEnterForeground() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    private func handleApplicationWillResignActive() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc private func willResignActive() {
        onApplicationWillResignActive?()
    }
    
    @objc private func willEnterForeground() {
        onApplicationWillEnterForeground?()
    }
    
    @objc private func didBecomeActive() {
        onApplicationDidBecomeActive?()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
