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

// swiftlint:disable no_emoji
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
// swiftlint:enable no_emoji

extension AuthApi: MockableMobileApiTarget {
    var isMockEnabled: Bool { getIsMockEnabled() }
    
    func getMockFileName() -> String? {
        switch self {
        case .refresh:
            return nil
        case .authorizeUserWithEmail, .authorizeUserWithPhone:
            return "MockAuthorizeUserModel"
        case .authorizeUserDevice:
            return "MockTempTokenModel"
        case .sendRecoveryConfirmationCode, .sendConfirmationCode:
            return "MockUserRegistrationModel"
        case .checkConfirmationСode:
            return "MockTokenModel"
        }
    }
    
    private func getIsMockEnabled() -> Bool {
        switch self {
        case .refresh:
            return false
        case .authorizeUserWithEmail,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode,
                .authorizeUserDevice,
                .authorizeUserWithPhone,
                .sendConfirmationCode:
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
