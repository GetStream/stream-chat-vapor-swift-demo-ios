import Foundation

struct SignInWithAppleToken: Codable {
    let token: String
    let name: String?
    let username: String?
}
