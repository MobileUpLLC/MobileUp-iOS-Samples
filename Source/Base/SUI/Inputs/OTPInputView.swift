//
//  OTPInputView.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

import SwiftUI

enum OTPInputViewState {
    case input
    case validation
    case valid
    case error
}

struct OTPInputView: View {
    private enum Constants {
        static let numberOfDigits: Int = .four
        static let digitsSpacing: CGFloat = .eight
    }
    
    @Binding var text: String
    @Binding var state: OTPInputViewState
    
    @FocusState var isFocused: Bool
    
    let onTextChange: Closure.String
    
    @State private var digitLabelSideLength: CGFloat = 0
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: Constants.digitsSpacing) {
                ForEach(Int.zero..<Constants.numberOfDigits, id: \.self) { index in
                    DigitLabel(
                        value: text[safe: index] ?? Character(.space),
                        isActive: checkIsActiveState(with: index),
                        state: state,
                        sideLength: digitLabelSideLength
                    )
                }
            }
            .background(
                TextField(String.empty, text: $text)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .disabled(state != .input)
                    .opacity(0)
                    .onChange(of: text) { newValue in
                        if newValue.count > Constants.numberOfDigits {
                            let newText = String(newValue.prefix(Constants.numberOfDigits))
                            text = newText
                            onTextChange(newText)
                        } else {
                            onTextChange(newValue)
                        }
                    }
            )
            .focused($isFocused)
            .onTapGesture(perform: handleOnTapGesture)
        }
        .frame(maxWidth: .infinity)
        .readSize { size in
            digitLabelSideLength = getDigitLabelSideLength(viewWidth: size.width)
        }
        .onAppear {
            isFocused = true
        }
    }
    
    private func handleOnTapGesture() {
        if isFocused == false {
            isFocused.toggle()
        }
    }
    
    private func getDigitLabelSideLength(viewWidth: CGFloat) -> CGFloat {
        let allSpacings = (CGFloat(Constants.numberOfDigits) - 1) * Constants.digitsSpacing
        
        return (viewWidth - allSpacings) / CGFloat(Constants.numberOfDigits)
    }
    
    private func checkIsActiveState(with index: Int) -> Bool {
        if isFocused == false {
            return false
        } else if index == .zero, text[safe: index] == nil {
            return true
        } else if index != .zero, text[safe: index - 1] == nil {
            return false
        } else if text[safe: index] == nil {
             return true
        } else {
            return false
        }
    }
}

private struct DigitLabel: View {
    @State var isAnimate = false
    
    let value: Character
    let isActive: Bool
    let state: OTPInputViewState
    let sideLength: CGFloat
    
    var body: some View {
        Text(String(value))
            .foregroundColor(.blue)
            .frame(width: sideLength, height: sideLength)
            .background(.white)
            .cornerRadius(16)
            .defaultStroke(cornerRadius: 16, color: isActive ? .gray : getStrokeColor())
            .overlay {
                if isActive {
                    Rectangle()
                        .foregroundStyle(.blue)
                        .frame(width: 2, height: 22)
                        .opacity(isAnimate ? 1 : 0)
                        .animation(.linear(duration: 0.4).repeatForever(), value: isAnimate)
                        .onAppear { isAnimate.toggle() }
                }
            }
    }
    
    private func getStrokeColor() -> Color {
        switch state {
        case .input, .validation:
            return .white
        case .valid:
            return .green
        case .error:
            return .red
        }
    }
}

#Preview {
    OTPInputView(
        text: .constant(.empty),
        state: .constant(.input),
        onTextChange: { _ in }
    )
}
