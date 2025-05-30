struct InputOuterValidationItem {
    let context: String
    let message: String?
    let type: InputMessageType
}

enum InputOuterValidationStatus {
    case done(InputOuterValidationItem)
    case processing
    case notNeeded
    
    var isValid: Bool {
        switch self {
        case .done(let item):
            return item.type == .positive
        case .processing:
            return false
        case .notNeeded:
            return true
        }
    }
}
