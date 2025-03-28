import Foundation
import Moya

class MobileService: BaseNetworkService<MobileApi> {
    static let shared = MobileService()
    
    private init() {
        let tokenProvider = AuthRepository()
        
        let stubClosure = { (target: MobileApi) -> Moya.StubBehavior in
            return target.isMockEnabled ? .delayed(seconds: 1.5) : .never
        }
        
        let apiProvider = MoyaProvider<MobileApi>(
            stubClosure: Environments.isRelease ? MoyaProvider.neverStub : stubClosure,
            session: .defaultWithoutCache,
            plugins: [LoggerPlugin.instance, AccessTokenPlugin(accessTokenProvider: tokenProvider)]
        )
        
        super.init(apiProvider: apiProvider, tokenRefreshProvider: tokenProvider)
    }
}
