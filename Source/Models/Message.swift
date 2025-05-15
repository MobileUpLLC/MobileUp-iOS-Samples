import Foundation

struct Message: Codable, Identifiable, Equatable {
    let id: String
    let text: String
    let timestamp: Double
    let senderId: String
}
