import SwiftUI
import FormView

struct PhoneNumberInputBlock: View {
    private enum Constants {
        static let phoneNumberMaxInputCount = 18
    }
    
    @Binding var phoneNumber: String
    @Binding var isValid: Bool
    @Binding var outerValidationStatus: InputOuterValidationStatus
        
    var body: some View {
        let rules: [TextValidationRule] = [.regex(value: .phoneNumberRegularExpression, message: .empty)]
        FormField(value: $phoneNumber, rules: rules) { _ in
            HStack(spacing: 0) {
                if phoneNumber.isEmpty {
                    Text(String.phoneNumberRegionCode)
                        .foregroundColor(.white)
                        .padding(.trailing, 15)
                }
                
                TextField(String.empty, text: $phoneNumber, prompt: Text(verbatim: .empty).foregroundColor(.gray))
            }
            .transaction { $0.animation = nil }
        }
        .background(alignment: .leading) {
            PhoneInputOverlay(text: phoneNumber)
                .padding(.leading, phoneNumber.isEmpty ? 35 : 0)
        }
        .onChange(of: phoneNumber) { value in
            phoneNumber = PhoneNumberFormatterService.format(String(value.prefix(Constants.phoneNumberMaxInputCount)))
        }
        .autocorrectionDisabled(true)
        .keyboardType(.numberPad)
    }
    
    init(
        phoneNumber: Binding<String>,
        isValid: Binding<Bool>,
        outerValidationStatus: Binding<InputOuterValidationStatus> = .constant(.notNeeded)
    ) {
        self._phoneNumber = phoneNumber
        self._isValid = isValid
        self._outerValidationStatus = outerValidationStatus
    }
}

private struct PhoneNumberOverlayPlaceholderView: View {
    let partiallyFilledPattern: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Int.zero..<partiallyFilledPattern.count, id: \.self) { characterIndex in
                PhoneNumberCharacterPlaceholderView(character: partiallyFilledPattern[characterIndex])
            }
        }
    }
}

private struct PhoneNumberCharacterPlaceholderView: View {
    let character: Character
    
    var body: some View {
        if character == PhoneNumberFormatterService.getPatternReplacementCharacter() {
            Rectangle()
                .frame(width: 13.3, height: 1)
                .foregroundColor(.gray)
        } else {
            Text(String(character))
                .hidden()
        }
    }
}

private struct PhoneInputOverlay: View {
    let text: String
    
    private let partiallyFilledPattern: String
    
    var body: some View {
        Text(getAttributedText(currentTextLength: text.count))
            .overlay(alignment: .center) {
                PhoneNumberOverlayPlaceholderView(partiallyFilledPattern: partiallyFilledPattern)
            }
    }
    
    init(text: String) {
        self.text = text
        
        partiallyFilledPattern = Self.getPartiallyFilledPattern(text: text)
    }
    
    private static func getPartiallyFilledPattern(text: String) -> String {
        if text.isEmpty {
            return PhoneNumberFormatterService.getNumberPatternWithoutRegionCode()
        } else {
            return PhoneNumberFormatterService.getPartiallyFilledPattern(currentNumber: text)
        }
    }
    
    private func getAttributedText(currentTextLength: Int) -> AttributedString {
        let overlayedText = replacePlaceholderCharactersWithSpaces(partiallyFilledPattern)
        
        let startIndex = overlayedText.startIndex
        let endIndex = overlayedText.endIndex
        let patternStartIndex = overlayedText.index(startIndex, offsetBy: currentTextLength)
        
        let phoneNumberSubstring = overlayedText[startIndex..<patternStartIndex]
        let patternSubstring = overlayedText[patternStartIndex..<endIndex]
        
        var attributedPhoneNumber = AttributedString(phoneNumberSubstring)
        var attributedPattern = AttributedString(patternSubstring)
        
        attributedPhoneNumber.foregroundColor = .black.opacity(0)
        
        attributedPattern.foregroundColor = .black

        return attributedPhoneNumber + attributedPattern
    }
    
    private func replacePlaceholderCharactersWithSpaces(_ string: String) -> String {
        return string.replacingOccurrences(
            of: String(PhoneNumberFormatterService.getPatternReplacementCharacter()),
            with: String.space + String.space,
            options: .regularExpression
        )
    }
}
