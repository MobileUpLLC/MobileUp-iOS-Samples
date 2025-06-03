//
//  TextValidationRule+CustomRules.swift
//  barcelona-ios
//
//  Created by Victor Kostin on 18.12.2024.
//

import FormView
import Foundation

extension ValidationRule {
    static var email: Self {
        .email(conditions: [.onFieldValueChanged, .manual], message: R.string.common.ruleEmail())
    }
    
    static func oneUppercaseLetter(conditions: [ValidationBehaviour]) -> Self {
        .atLeastOneUppercaseLetter(
            conditions: conditions,
            message: R.string.common.ruleAtLeastOneCapitalLetter()
        )
    }
    
    static var oneDigit: Self {
        .atLeastOneDigit(
            conditions: [.onFieldValueChanged, .manual],
            message: R.string.common.ruleAtLeastOneDigit()
        )
    }
    
    static func excludingSpace(conditions: [ValidationBehaviour]) -> Self {
        .custom(conditions: conditions) {
            return ($0.contains(.space) == false, R.string.common.ruleNotContainSpaces())
        }
    }
    
    static func correspondsMinMaxLength(conditions: [ValidationBehaviour], min: Int, max: Int) -> Self {
        .custom(conditions: conditions) {
            return ($0.count >= min && $0.count <= max, R.string.common.ruleMinMaxLength(String(min), String(max)))
        }
    }
    
    static func confirmPassword(value: String) -> Self {
        .custom(conditions: [.onFieldValueChanged]) {
            return ($0 == value, R.string.common.ruleConfirmPassword())
        }
    }
    
    static func atLeastOneOfSpecifiedSpecialCharacters(
        conditions: [ValidationBehaviour],
        message: String
    ) -> Self {
        .custom(conditions: conditions) {
            let allowedSpecialChar = $0.range(of: "[!?#@&><€%/\\\\]", options: .regularExpression) != nil
            let noOtherSpecialChars = $0.range(
                of: "[^A-Za-zА-Яа-яё0-9 !?#@&><€%/\\\\]",
                options: .regularExpression
            ) == nil
            return (allowedSpecialChar && noOtherSpecialChars, message)
        }
    }
}

extension Array<ValidationRule> {
    static let password: Self = [
        .correspondsMinMaxLength(conditions: [.onFieldFocus, .onFieldValueChanged], min: 8, max: 32),
        .oneUppercaseLetter(conditions: [.onFieldFocus, .onFieldValueChanged]),
        .atLeastOneDigit(
            conditions: [.onFieldFocus, .onFieldValueChanged],
            message: R.string.common.ruleAtLeastOneDigit()
        ),
        .atLeastOneOfSpecifiedSpecialCharacters(
            conditions: [.onFieldFocus, .onFieldValueChanged],
            message: R.string.common.ruleAtLeastOneSpecialChar()
        ),
        .excludingSpace(conditions: [.onFieldFocus, .onFieldValueChanged])
    ]
}
