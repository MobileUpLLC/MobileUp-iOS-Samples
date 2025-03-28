import UIKit

class ApplicationLifecycleUtil {
    static var isApplicationActive: Bool { UIApplication.shared.applicationState == .active }
    
    var onApplicationDidBecomeActive: Closure.Void? {
        didSet {
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
    }
    
    var onApplicationWillEnterForeground: Closure.Void? {
        didSet {
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
    }
    
    var onApplicationWillResignActive: Closure.Void? {
        didSet {
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
