import Foundation

struct ConfirmCodeTokenModel: Decodable {
    let accessToken: String
    let refreshToken: String
    let isNew: Bool
}
