import Foundation
import SwiftUI
import AuthenticationServices
import StreamChatSwiftUI
import StreamChat

final class LoginViewModel: ObservableObject {
    let apiHostname: String
    @Published var username = ""
    @Published var password = ""
    @Published var oauthSignInWrapper: OAuthSignInViewModel
    @Published var showingLoginErrorAlert = false

    @Injected(\.chatClient) var chatClient

    init(apiHostname: String) {
        self.apiHostname = apiHostname
        self.oauthSignInWrapper = OAuthSignInViewModel(apiHostname: apiHostname)
    }

    @MainActor
    func login() async throws -> LoginResultData {
        fatalError()
    }

    @MainActor
    func handleSIWA(result: Result<ASAuthorization, Error>) async throws -> LoginResultData {
        fatalError()
    }

    @MainActor
    func handleLoginComplete(loginData: LoginResultData) async throws -> String {
        fatalError()
    }

    func connectUser(token: String, username: String, name: String) {
        let tokenObject = try! Token(rawValue: token)

        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
            userInfo: .init(id: username,
                            name: name,
                            imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
            token: tokenObject
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
}
