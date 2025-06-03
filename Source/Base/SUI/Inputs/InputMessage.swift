import SwiftUI

enum InputMessageType {
    case positive
    case negative
    
    var foregroundColor: Color {
        switch self {
        case .positive:
            return .green
        case .negative:
            return .red
        }
    }
}

struct InputMessage {
    let value: String
    let type: InputMessageType
    
    init(value: String, type: InputMessageType = .negative) {
        self.value = value
        self.type = type
    }
    
    static func createByOuterValidation(context: String, status: InputOuterValidationStatus) -> InputMessage? {
        switch status {
        case .done(let item):
            return createFrom(context: context, item: item)
        case .processing, .notNeeded:
            return nil
        }
    }
    
    static private func createFrom(context: String, item: InputOuterValidationItem) -> InputMessage? {
        guard item.context == context, let message = item.message else {
            return nil
        }
        
        return InputMessage(value: message, type: item.type)
    }
}
