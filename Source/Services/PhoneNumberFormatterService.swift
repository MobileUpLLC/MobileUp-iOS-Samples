import Foundation

enum PhoneNumberFormatterService {
    private enum Constants {
        static let phoneNumberPattern = "+7 (XXX) XXX-XX-XX"
        static let phoneNumberPatterWithoutRegionCode = "(XXX) XXX-XX-XX"
        static let patternReplacementCharacter: Character = "X"
        static let phoneNumberMaxInputCount = 18
    }

    static func getNumberPatternWithoutRegionCode() -> String {
        return Constants.phoneNumberPatterWithoutRegionCode
    }
    
    static func getPatternReplacementCharacter() -> Character {
        return Constants.patternReplacementCharacter
    }
    
    static func getPartiallyFilledPattern(currentNumber: String) -> String {
        let pattern = Constants.phoneNumberPattern
        
        let startIndex = pattern.index(
            pattern.startIndex, offsetBy: currentNumber.prefix(Constants.phoneNumberMaxInputCount).count
        )
        let endIndex = pattern.endIndex
        
        return currentNumber + String(pattern[startIndex..<endIndex])
    }
    
    static func format(_ value: String) -> String {
        let pattern = Constants.phoneNumberPattern
        let replacementCharacter = Constants.patternReplacementCharacter
        
        let firstReplacementCharacterIndex = pattern.firstIndex(of: replacementCharacter) ?? pattern.startIndex
        var prefixedValue: String = .empty
        
        if value.count < pattern.distance(from: pattern.startIndex, to: firstReplacementCharacterIndex) {
            prefixedValue = String(pattern[pattern.startIndex..<firstReplacementCharacterIndex])
        }
        
        prefixedValue.append(value)
        
        let enteredCharacters = getEnteredCharacters(value: prefixedValue, pattern: pattern)

        let pureValue = enteredCharacters.replacingOccurrences(
            of: String.onlyNumbersRegularExpression,
            with: String.empty,
            options: .regularExpression
        )
        
        var formattedString: String = .empty
        var index = pureValue.startIndex
        
        for patternCharacter in pattern where index < pureValue.endIndex {
            if patternCharacter == replacementCharacter {
                formattedString.append(pureValue[index])
                
                index = pureValue.index(after: index)
            } else {
                formattedString.append(patternCharacter)
            }
        }
        
        return formattedString
    }

    private static func getEnteredCharacters(value: String, pattern: String) -> String {
        var resultString: String = .empty

        let pureValue = value.replacingOccurrences(
            of: String.onlyNumbersAndEnLettersRegularExpression,
            with: String.empty,
            options: .regularExpression
        )
        
        let purePattern = pattern.replacingOccurrences(
            of: String.onlyNumbersAndEnLettersRegularExpression,
            with: String.empty,
            options: .regularExpression
        )
        
        for index in Int.zero..<pureValue.count where index < purePattern.count {
            if pureValue[index] != purePattern[index] {
                resultString.append(pureValue[index])
            }
        }
        
        return resultString
    }
}
