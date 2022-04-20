import Foundation

struct LoginResponse: Codable {
    let apiToken: UserToken
    let streamToken: String
}
