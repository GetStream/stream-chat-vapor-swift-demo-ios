import Foundation
import AuthenticationServices

class OAuthSignInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    
    let apiHostname: String
    
    init(apiHostname: String){
        self.apiHostname = apiHostname
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    enum OAuthType {
        case google
        case github
    }
    
    func signIn(with oauthType: OAuthType) async throws -> LoginResultData {
        fatalError()
    }
}
