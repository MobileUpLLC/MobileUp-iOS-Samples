protocol AnalyticsProvider {
    func configure()
    func report(event: AnalyticsEvent, params: [AnalyticsEventParam: Any])
    func shouldReport(event: AnalyticsEvent) -> Bool
}

final class AnalyticsService {
    static let shared = AnalyticsService()
    
    private init() {}
    
    private var providers: [AnalyticsProvider] = []
    
    func configure(providers: [AnalyticsProvider]) {
        self.providers = providers
        
        providers.forEach { $0.configure() }
    }
    
    func report(
        event: AnalyticsEvent,
        params: [AnalyticsEventParam: Any] = [:]
    ) {
        providers.forEach { provider in
            provider.report(event: event, params: params)
        }
    }
}
