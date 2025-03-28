import Firebase

final class FirebaseService: AnalyticsProvider {
    static let shared = FirebaseService()
    
    private init() {}
    
    func configure() {
        FirebaseApp.configure()
    }
    
    func report(event: AnalyticsEvent, params: [AnalyticsEventParam: Any]) {
        guard shouldReport(event: event) else {
            return
        }
        
        var parameters: [String: Any] = [:]
        
        params.forEach { key, value in
            if let stringArray = value as? [String] {
                parameters[key.rawValue] = stringArray.joined(separator: String.comma)
            } else {
                parameters[key.rawValue] = value
            }
        }
        
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
    
    func shouldReport(event: AnalyticsEvent) -> Bool {
        switch event {
        case .webviewCellTap:
            return true
        default:
            return false
        }
    }
}
