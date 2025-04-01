//
//  MockableApiTargetType.swift
//  Example
//
//  Created by MobileUp on 24.01.2025.
//

import Foundation

protocol MockableMobileApiTarget: MobileApiTargetType {
    var isMockEnabled: Bool { get }
    
    func getMockFileName() -> String?
}

extension MockableMobileApiTarget {
    var sampleData: Data { getSampleData() }

    private func getSampleData() -> Data {
        let logStart = "Для запроса \(path) моковые данные"

        guard let mockFileName = getMockFileName() else {
            let log = "💽🆓 \(logStart) не используются."
            Log.mockableMobileApiTarget.debug(logEntry: .text(log))
            return Data()
        }

        let mockExtension = "json"

        guard let mockFileUrl = Bundle.main.url(forResource: mockFileName, withExtension: mockExtension) else {
            let log = "💽🚨 \(logStart) \(mockFileName).\(mockExtension) не найдены."
            Log.mockableMobileApiTarget.error(logEntry: .text(log))
            return Data()
        }

        do {
            let data = try Data(contentsOf: mockFileUrl)
            let log = "💽✅ \(logStart) успешно прочитаны по URL: \(mockFileUrl)."
            Log.mockableMobileApiTarget.debug(logEntry: .text(log))
            return data
        } catch {
            let log =
            "💽🚨\n\(logStart) из файла \(mockFileName).\(mockExtension) невозможно прочитать.\nОшибка: \(error)"
            Log.mockableMobileApiTarget.error(logEntry: .text(log))
            return Data()
        }
    }
}

extension AuthApi: MockableMobileApiTarget {
    var isMockEnabled: Bool { getIsMockEnabled() }
    
    func getMockFileName() -> String? {
        switch self {
        case .refresh:
            return nil
        case .authorizeUser:
            return "MockAuthorizeUserModel"
        case .sendRecoveryConfirmationCode:
            return "MockUserRegistrationModel"
        case .checkConfirmationСode:
            return "MockTokenModel"
        }
    }
    
    private func getIsMockEnabled() -> Bool {
        switch self {
        case .refresh:
            return false
        case .authorizeUser,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode:
            return true
        }
    }
}

extension ExampleApi: MockableMobileApiTarget {
    var isMockEnabled: Bool { getIsMockEnabled() }
    
    func getMockFileName() -> String? {
        switch self {
        case .testItems:
            return nil
        }
    }
    
    private func getIsMockEnabled() -> Bool {
        switch self {
        case .testItems:
            return false
        }
    }
}

extension MobileApi: MockableMobileApiTarget {
    var isMockEnabled: Bool { getIsMockEnabled() }
    
    func getMockFileName() -> String? {
        switch self {
        case .auth(let authApi):
            return authApi.getMockFileName()
        case .example(let exampleApi):
            return exampleApi.getMockFileName()
        }
    }
    
    private func getIsMockEnabled() -> Bool {
        switch self {
        case .auth(let authApi):
            return authApi.isMockEnabled
        case .example(let exampleApi):
            return exampleApi.isMockEnabled
        }
    }
}
