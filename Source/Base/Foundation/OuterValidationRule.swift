//
//  OuterValidationRule.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

enum OuterValidationRule: Equatable {
    case unknown
    case emailNotFound
    case emailNotConfirmed
    case passwordInvalid
    case emailAlreadyExists
    case custom(String)
    
    var message: String {
        switch self {
        case .unknown:
            return R.string.common.ruleUnknownError()
        case .emailNotFound:
            return R.string.auth.authorizationEmailNotRegisteredTitle()
        case .emailNotConfirmed:
            return R.string.auth.authorizationEmailNotRegisteredTitle()
        case .passwordInvalid:
            return R.string.auth.authorizationIncorrectPasswordTitle()
        case .emailAlreadyExists:
            return R.string.auth.registrationEmailAlreadyRegistered()
        case .custom(let message):
            return message
        }
    }
}
