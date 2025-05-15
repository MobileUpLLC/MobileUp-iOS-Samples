import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let text: String
    let timestamp: Date
    let senderId: String
}
