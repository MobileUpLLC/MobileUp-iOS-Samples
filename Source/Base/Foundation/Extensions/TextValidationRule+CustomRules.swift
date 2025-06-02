//
//  TextValidationRule+CustomRules.swift
//  barcelona-ios
//
//  Created by Victor Kostin on 18.12.2024.
//

import FormView
import Foundation

extension TextValidationRule {
    static var email: Self {
        .email(message: R.string.common.ruleEmail())
    }
    
    static var oneUppercaseLetter: Self {
        .atLeastOneUppercaseLetter(message: R.string.common.ruleAtLeastOneCapitalLetter())
    }
    
    static var oneDigit: Self {
        .atLeastOneDigit(message: R.string.common.ruleAtLeastOneDigit())
    }
    
    static var excludingSpace: Self {
        TextValidationRule(message: R.string.common.ruleNotContainSpaces()) {
            $0.contains(.space) == false
        }
    }
    
    static func correspondsMinMaxLength(min: Int, max: Int) -> Self {
        TextValidationRule(message: R.string.common.ruleMinMaxLength(String(min), String(max))) {
            $0.count >= min && $0.count <= max
        }
    }
    
    static func confirmPassword(value: String) -> Self {
        .equalTo(value: value, message: R.string.common.ruleConfirmPassword())
    }
    
    static func atLeastOneOfSpecifiedSpecialCharacters(message: String) -> Self {
        TextValidationRule(message: message) {
            let allowedSpecialChar = $0.range(of: "[!?#@&><€%/\\\\]", options: .regularExpression) != nil
            let noOtherSpecialChars = $0.range(
                of: "[^A-Za-zА-Яа-яё0-9 !?#@&><€%/\\\\]",
                options: .regularExpression
            ) == nil
            return allowedSpecialChar && noOtherSpecialChars
        }
    }
}

extension Array<TextValidationRule> {
    static let password: Self = [
        .correspondsMinMaxLength(min: 8, max: 32),
        .oneUppercaseLetter,
        .oneDigit,
        .atLeastOneOfSpecifiedSpecialCharacters(message: R.string.common.ruleAtLeastOneSpecialChar()),
        .excludingSpace
    ]
}
