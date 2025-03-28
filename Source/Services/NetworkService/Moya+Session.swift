//
//  Moya+Session.swift
//  ileDeBeaute-iOS
//
//  Created by Petrovich on 21.06.2024.
//

import Moya
import Foundation
import Pulse
import Alamofire

extension Session {
    static var defaultWithoutCache: Session { defaultWithoutCacheAlamofireSession() }

    private static func defaultWithoutCacheAlamofireSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.urlCache = nil
        
        if Environments.isRelease {
            return Session(configuration: configuration, startRequestsImmediately: true)
        } else {
            // если не нужно использовать библиотеку Pulse для просмотра логов, убираем этот блок
            // все параметры и настройка сессии заимствованы из инициализатора Session,
            // который находится в файле Session библиотеки Alamofire,
            // + добавлена настройка URLSessionProxy для работы с Pulse
            let sessionDelegate = SessionDelegate()
            let rootQueue = DispatchQueue(label: "org.alamofire.session.rootQueue")
            let serialRootQueue = DispatchQueue(label: rootQueue.label, target: rootQueue)
            
            let delegateQueue = OperationQueue(
                maxConcurrentOperationCount: 1,
                underlyingQueue: serialRootQueue,
                name: "\(serialRootQueue.label).sessionDelegate"
            )
            
            let session = URLSessionProxy(
                configuration: configuration,
                delegate: sessionDelegate,
                delegateQueue: delegateQueue
            )
            
            let alamofireSession = Session(
                session: session.session,
                delegate: sessionDelegate,
                rootQueue: serialRootQueue,
                startRequestsImmediately: true
            )
            
            return alamofireSession
        }
    }
}

private extension OperationQueue {
    // инициализатор заимствован из файла OperationQueue+Alamofire.swift библиотеки Alamofire
    // используется при создании delegateQueue, который нужен, чтобы инициализировать Session
    // аналогично тому, как это реализовано в самом Alamofire
    convenience init(
        qualityOfService: QualityOfService = .default,
        maxConcurrentOperationCount: Int = OperationQueue.defaultMaxConcurrentOperationCount,
        underlyingQueue: DispatchQueue? = nil,
        name: String? = nil,
        startSuspended: Bool = false
    ) {
        self.init()
        self.qualityOfService = qualityOfService
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
        self.underlyingQueue = underlyingQueue
        self.name = name
        isSuspended = startSuspended
    }
}
